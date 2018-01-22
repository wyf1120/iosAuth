//
//  WebSocketConnection.swift
//  iOSAuth
//
//  Created by Aran on 2017/3/9.
//  Copyright © 2017年 Aran. All rights reserved.
//

import UIKit
import CryptoSwift
import Base32
import OneTimePassword
import TrueTime

enum WebSocketConnectionError: Error {
    case ConnectionFailed
}

// MARK: Message status
enum ConnectionStatus {
    case noConversation
    case waitConnectionConfirm
    case connectionConfirmed
}

protocol WebSocketConnectionDelegate {
    func firstConnectionSuccess()
    func reloadData()
    func showAuthPush(connection: WebSocketConnection)
}

class WebSocketConnection: WebSocketDelegate{
    
    // MARK: Keychain item
    var keyChainItem: NSMutableDictionary?
    var aes: AES?
    
    // MARK: constant prefix string
    let SYN_PREFIX = "SYN"
    let ACK_PREFIX = "ACK"
    let AUTH_PREFIX = "AUTH"
    let SUCCEED_PREFIX = "SUCCEED"
    let FAILED_PREFIX = "FAILED"
    
    let URL_PREFIX = "ws://54.222.230.131:8081/api-"
    let URL_SUFFIX = "/mobile"
    
    let INIT_VECTOR = "0000000000000000"
    
    // MARK: properties
    var socket: WebSocket?
    
    var isConnected: Bool = false {
        didSet {
            delegate?.reloadData()
        }
    }
    
    var isFirstConnection: Bool
    var isRetry: Bool = true
    
    var connectionStatus: ConnectionStatus = .noConversation
    
    var id: String
    var key: Data?
    var hostname: String?
    
    var label: String?
    
    var delegate: WebSocketConnectionDelegate?
    
    var timerRetry: DispatchSourceTimer?
    var timerUpdateCode: DispatchSourceTimer?
    
    var currentRandom: String?
    var currentSeq: Int = -1
    
    var hasData: Bool = false
    var lastCounter: UInt64 = 0
    var generator: Generator?
    var code: String?
    
    var hasNewPush: Bool = false {
        didSet {
            delegate?.reloadData()
        }
    }

    
    init(id: String) {
        
        self.id = id
        self.isFirstConnection = false
        
        let value = getKeyFromKeyChain(forID: id)
        print("value = ", value)
        self.key = value.key
        self.hostname = value.hostname
        
        socket = WebSocket(url: URL(string: URL_PREFIX + hostname! + "/" + id + URL_SUFFIX)!)
        socket?.delegate = self
        
        do {
            aes = try AES(key: Array<UInt8>(key!), iv: Array(INIT_VECTOR.utf8), blockMode: .CBC, padding: ZeroPadding())
        } catch  {
            print(error)
        }
        
        let device = UserDefaults.standard.value(forKey: "info-" + id) as? [String: String] ?? [String: String]()
        label = device["label"]
        
        if let seed = getTOTPFromKeyChain(forID: id) {
            
            print("seed: \(MF_Base32Codec.base32String(from: seed))")
            generator = Generator(factor: .timer(period: 30), secret: seed, algorithm: .sha1, digits: 6)
            hasData = true
            updateCode()
        }
        
    }
    
    init(id: String, key: Data, hostname: String) {
        
        self.id = id
        self.isFirstConnection = true
        
        self.key = key
        self.hostname = hostname
        
        socket = WebSocket(url: URL(string: URL_PREFIX + hostname + "/" + id + URL_SUFFIX)!)
        socket?.delegate = self
        
        do {
            aes = try AES(key: Array<UInt8>(key), iv: Array(INIT_VECTOR.utf8), blockMode: .CBC, padding: ZeroPadding())
        } catch  {
            print(error)
        }
        
    }

    
    func webSocketConnect() {
        socket?.connect()
    }

    // MARK: WebSocketDelegate
    func websocketDidConnect(socket: WebSocket) {
        print("🔌Connect with id: \(self.id), key: \(String(data: self.key!, encoding: .ascii) ?? ""), hostname: \(self.hostname ?? "")")
    }
    func websocketDidDisconnect(socket: WebSocket, error: NSError?) {
        isConnected = false
        connectionStatus = .noConversation
        
        print("🔌Disconnect id:\(id), key:\(String(data: key!, encoding: .ascii) ?? ""), hostname:\(hostname ?? ""), self:\(Unmanaged.passRetained(self).toOpaque())")
        print("\t" + String(describing: error))
        
        if(isRetry) {
            timerRetry = DispatchSource.makeTimerSource()
            timerRetry?.scheduleOneshot(deadline: .now() + 10)
            timerRetry?.setEventHandler {
                self.webSocketConnect()
            }
            timerRetry?.resume()
        }
    }
    func websocketDidReceiveMessage(socket: WebSocket, text: String) {
        print("📲From server: \(text)")
        var cookieData: [UInt8]?
        if let msgData = Data(base64Encoded: text) {
            do {
                cookieData = try aes?.decrypt(msgData)
            } catch  {
                
            }
        }
        
        guard cookieData != nil else {
            socket.disconnect()
            return
        }
        
        print("\tDecrypt " + (String(bytes: cookieData!, encoding: .ascii) ?? ""))
        
        switch connectionStatus {
        case .noConversation:
            // Build a connection
            let random = parseSYNMessage(data: cookieData!)
            let randomTransformed = transformRandom(string: random)
            sendACKMessage(randomTransformed: randomTransformed)
            if isFirstConnection {
                saveKeyInKeyChain(key: key!, hostname: hostname!, forID: id)
                delegate?.firstConnectionSuccess()
            }
            connectionStatus = .waitConnectionConfirm
            break
        case .waitConnectionConfirm:
            let cookie = String(bytes: cookieData!, encoding: .utf8)
            if(cookie == "OK") {
                isConnected = true
                connectionStatus = .connectionConfirmed
            }
            else {
                socket.disconnect()
            }
            break
        case .connectionConfirmed:
            var json: [String: Any]
            do {
                json = try JSONSerialization.jsonObject(with: Data(bytes: cookieData!), options: .allowFragments) as? [String: Any] ?? [String: Any]()
            } catch {
                fatalError("Not Json")
            }
            
            
            switch json["type"] as? String ?? ""{
                
            // Receive Data
            case "info":
                saveLabelAndTOTP(label: json["data"] as! String, seed: json["seed"] as! String)
                break
            
            // Get an Auth Push request
            case "autopush":
                processAuthPush(json: json)
                break
            default: break
                
            }
            break
        }
    }
    
    func websocketDidReceiveData(socket: WebSocket, data: Data) {
        
    }
    
    func websocketSendMessage(message: String) {
        socket?.write(string: message)
        print("📱Send: \(message)")
    }
    
    // MARK: Interaction with server
    func parseSYNMessage(data: [UInt8]) -> String{
            let cookie = String(bytes: data, encoding: .utf8)
            let cookieArray = cookie?.characters.split(separator: "\0")
            
            guard cookieArray?.count == 2 else {
                socket?.disconnect()
                return ""
            }
            
            guard String(cookieArray![0]) == SYN_PREFIX else {
                socket?.disconnect()
                return ""
            }
            
            return String(cookieArray![1])
    }
    
    func transformRandom(string: String) -> String {
        return String(string.characters.reversed())
    }
    
    func sendACKMessage(randomTransformed: String) {
        do {
            let cookieString = ACK_PREFIX + "\0" + randomTransformed
            let cipher = try aes?.encrypt(Array(cookieString.utf8))
            websocketSendMessage(message: (cipher?.toBase64())!)
        } catch {
            print(error)
        }
        
    }
    
    func processAuthPush(json: [String: Any]) {
            currentRandom = json["random"] as? String
            hasNewPush = true
    }
    
    func replyPushAuth(result: Bool) {
        do {
            let cookieString = (result ? SUCCEED_PREFIX : FAILED_PREFIX) + "\0" + transformRandom(string: currentRandom!)
            let message = [
                "action": "EXPLICIT",
                "info": cookieString
            ]
            let messageJson = try JSONSerialization.data(withJSONObject: message, options: [])
            let cipher = try aes?.encrypt(messageJson)
            websocketSendMessage(message: (cipher?.toBase64())!)
        } catch {
            print(error)
        }
        
    }
    
    func requireData() {
        if(hasData == false) {
            let message = [
                "action": "REQUIRE",
            ]
            do {
                let messageJson = try JSONSerialization.data(withJSONObject: message, options: [])
                let cipher = try aes?.encrypt(messageJson)
                websocketSendMessage(message: (cipher?.toBase64())!)
            } catch  {
                
            }
            let timer = DispatchSource.makeTimerSource()
            timer.scheduleOneshot(deadline: .now() + 10)
            timer.setEventHandler {
                self.requireData()
            }
            timer.resume()
        }
    }
    
    func saveLabelAndTOTP(label: String, seed: String) {
        var device = UserDefaults.standard.value(forKey: "info-" + id) as? [String: String] ?? [String: String]()
        device["label"] = label
        self.label = label
        
        UserDefaults.standard.set(device, forKey: "info-" + id)
        UserDefaults.standard.synchronize()
        
        let secret = MF_Base32Codec.data(fromBase32String: seed)
        print("secret = ", secret as Any)
        saveTOTPInKeyChain(secret: secret!, forID: id)
        
        generator = Generator(factor: .timer(period: 30), secret: secret!, algorithm: .sha1, digits: 6)
        hasData = true
        updateCode()
    }
    
    // MARK:  产生随机数
    
    func updateCode() {
        let now = TrueTimeClient.sharedInstance.referenceTime?.now() ?? Date()
        let counter = UInt64((now.timeIntervalSince1970) / 30)
        if counter != lastCounter {
            lastCounter = counter
            do {
                code = try generator?.password(at: now)
                print("code: \(code ?? ""), time: \(now.timeIntervalSince1970)")
            } catch  {
                
            }
            
            delegate?.reloadData()
            
            timerUpdateCode = DispatchSource.makeTimerSource()
            timerUpdateCode?.scheduleOneshot(deadline: .now() + 30 - now.timeIntervalSince1970.truncatingRemainder(dividingBy: 30))
            timerUpdateCode?.setEventHandler {
                self.updateCode()
            }
            timerUpdateCode?.resume()
        }
        else {
            timerUpdateCode = DispatchSource.makeTimerSource()
            timerUpdateCode?.scheduleOneshot(deadline: .now() + 1)
            timerUpdateCode?.setEventHandler {
                self.updateCode()
            }
            timerUpdateCode?.resume()
        }
    }
    
    // MARK: KeyChain
    
    func saveKeyInKeyChain(key: Data, hostname: String, forID: String) {
        print("saveKeyInKeyChain called")
        var searchDictionary = [String: AnyObject]()
        
        searchDictionary[kSecAttrAccount as String] = forID as AnyObject?
        searchDictionary[kSecClass as String] = kSecClassInternetPassword
        searchDictionary[kSecAttrType as String] = "SecK" as AnyObject
        
        // If id existed, update the data
        if SecItemCopyMatching(searchDictionary as CFDictionary, nil) == noErr {
            var updateDictionary = [String: AnyObject]()
            updateDictionary[kSecAttrServer as String] = hostname as AnyObject?
            updateDictionary[kSecValueData as String] = key as AnyObject?
            let status = SecItemUpdate(searchDictionary as CFDictionary, updateDictionary as CFDictionary)
            guard status == 0 else {
                print(status)
                return
            }
        }
        else {
            searchDictionary[kSecAttrServer as String] = hostname as AnyObject?
            searchDictionary[kSecValueData as String] = key as AnyObject?
            let status = SecItemAdd(searchDictionary as CFDictionary, nil)
            guard status == 0 else {
                print(status)
                return
            }
        }
    }
    
    func saveTOTPInKeyChain(secret: Data, forID: String) {
        print("saveTOTPInKeyChan called")
        var searchDictionary = [String: AnyObject]()
        
        searchDictionary[kSecAttrAccount as String] = forID as AnyObject?
        searchDictionary[kSecClass as String] = kSecClassInternetPassword
        searchDictionary[kSecAttrType as String] = "TOTP" as AnyObject
        
        // If id existed, update the data
        if SecItemCopyMatching(searchDictionary as CFDictionary, nil) == noErr {
            var updateDictionary = [String: AnyObject]()
            updateDictionary[kSecValueData as String] = secret as AnyObject?
            let status = SecItemUpdate(searchDictionary as CFDictionary, updateDictionary as CFDictionary)
            guard status == 0 else {
                print(status)
                return
            }
        }
        else {
            searchDictionary[kSecValueData as String] = secret as AnyObject?
            let status = SecItemAdd(searchDictionary as CFDictionary, nil)
            guard status == 0 else {
                print(status)
                return
            }
        }
    }
    
    func getKeyFromKeyChain(forID: String) -> (key: Data, hostname: String) {
        print("getKeyFromKeyChain called")
        // init search dictionary
        var searchDictionary = [String: AnyObject]()
        
        searchDictionary[kSecAttrAccount as String] = forID as AnyObject?
        searchDictionary[kSecClass as String] = kSecClassInternetPassword
        searchDictionary[kSecAttrType as String] = "SecK" as AnyObject
        searchDictionary[kSecReturnAttributes as String] = kCFBooleanTrue
        searchDictionary[kSecReturnData as String] = kCFBooleanTrue
        
        var queryResult: AnyObject?
        
        let status = SecItemCopyMatching(searchDictionary as CFDictionary, &queryResult)
        guard status == 0 else {
            print(status)
            return (Data(), "")
        }
        let queryResultDict = queryResult as! [String: AnyObject]
        
        let hostname = queryResultDict[kSecAttrServer as String] as! String
        let key = queryResultDict[kSecValueData as String] as! Data
        
        return (key, hostname)
    }
    
    func getTOTPFromKeyChain(forID: String) -> Data? {
        print("getTOTPFromKeyChain called")
        // init search dictionary
        var searchDictionary = [String: AnyObject]()
        
        searchDictionary[kSecAttrAccount as String] = forID as AnyObject?
        searchDictionary[kSecClass as String] = kSecClassInternetPassword
        searchDictionary[kSecAttrType as String] = "TOTP" as AnyObject
        searchDictionary[kSecReturnAttributes as String] = kCFBooleanTrue
        searchDictionary[kSecReturnData as String] = kCFBooleanTrue
        
        var queryResult: AnyObject?
        
        let status = SecItemCopyMatching(searchDictionary as CFDictionary, &queryResult)
        guard status == 0 else {
            print(status)
            return nil
        }
        let queryResultDict = queryResult as! [String: AnyObject]
        
        let secret = queryResultDict[kSecValueData as String] as! Data
        
        return secret
    }
}
