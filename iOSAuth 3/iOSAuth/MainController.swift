//
//  MainController.swift
//  iOSAuth
//
//  Created by 吴宇飞 on 2018/1/20.
//  Copyright © 2018年 Aran. All rights reserved.
//

import UIKit
import CryptoSwift

class MainController: UIViewController ,WebSocketConnectionDelegate,scanQRCodeControllerDelegate,loginvcDelegate,UITableViewDelegate,UITableViewDataSource {
    
    var idArr = [String]()
    
    var connections = [String: WebSocketConnection]()
    
    // MARK: Current Connection Info
    var currentKey: Data?
    var currentID: String?
    var currentHostname: String?
    var currentConnection: WebSocketConnection?
    var tableview: UITableView?
    
    var isPush = false
    
    var alter: alterView?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.white
        
        let deviceInfo = ["Auth://UU9id2JEaW5rWUpic0tkOExUb2xwampQNlgxTDdtQUw=-RVRuWlZOb2Zva2NieDhxMTNyTno=-N1Jib3pPd2E=",
                          "Auth://NUZJaWpGV2dIQ0ZYd0RiSDYxYTU3S1B5RUtFS1d4SEk=-d1piMVlKQjI5aHhJT3JsZ3dLNVE=-N1Jib3pPd2E=",
                          "Auth://WXNaVEtwbTVWSEdybFpQUXFHb1h5cEZMZ3lZaFdDY0Q=-YWhXOWtxQWRDR0E3NlNhdFVRYlA=-N1Jib3pPd2E="]
        
        let deviceInfo1 = ["Auth://V2FVTUZZVWRQT1dmUWJkTENMQnlPbjN0WUFsVGhPeWI=-cGNxVzJTMWRXdUxsMXJVVEE1Smk=-N1Jib3pPd2E=",
                           "Auth://WWJxQUVGVmVLcW54amxaZ0Z6akVqWGp5aWZOOFZFVDM=-RWljd05zZEhNNTJNRmg0Q2JzTU4=-N1Jib3pPd2E="
                          ]
        
        for devId in deviceInfo1 {
            let value = parseURL(url: devId)
            
            let keychainData = getKeyFromKeyChain(forID: devId)
            if keychainData == nil
            {
                saveKeyInKeyChain(key: value.key, hostname: value.hostname, forID: value.id)
            }
            
            idArr.append(value.id)
        }

        UserDefaults.standard.set(idArr, forKey: "DeviceIdentifiers")
        
     
        let loginValue = UserDefaults.standard.value(forKey: "loginSuccess")
        if loginValue == nil {
            let loginVC = loginController()
            loginVC.delegate = self
            loginVC.loginSuccess = "no"
            self.present(loginVC, animated: true, completion: nil)
        }
        else
        {
            let value = UserDefaults.standard.value(forKey: "DeviceIdentifiers")
            
            if (value != nil) {
                print(value!);
            }
            
            if let devices = value as? [String] {
                for device in devices {
                    let wsc = WebSocketConnection(id: device)
                    
                    currentConnection = wsc
                    
                    wsc.delegate = self
                    wsc.webSocketConnect()
                    connections[device] = wsc            }
            }
            
            self.tableview?.reloadData()
        }
       
        self.tableview = UITableView(frame: self.view.bounds, style: .plain)
        self.tableview?.register(UINib.init(nibName: "deviceConnectionCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableview?.delegate = self
        self.tableview?.dataSource = self;
        self.tableview?.tableFooterView = UIView()
        self.view.addSubview(self.tableview!)
        
        self.navigationItem.title = "我的记录"
        
//        let topView = UIImageView(frame: CGRect(x: UIScreen.main.bounds.size.width/2-20, y: 0, width: 40, height: 40));
//        topView.image = UIImage(named: "2")
//        topView.layer.cornerRadius = 20;
//        topView.layer.masksToBounds = true
//        self.navigationController?.navigationBar.addSubview(topView)
        
        createBtn()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 56.0/255.0, green: 69.0/255.0, blue: 78.0/255.0, alpha: 1)
        
        //        tableView.estimatedRowHeight = 96.0
        //        tableView.rowHeight = UITableViewAutomaticDimension
        self.tableview?.tableFooterView = UIView()
        
        //firstLoadInfo()
        
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:deviceConnectionCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! deviceConnectionCell
        cell.selectionStyle = .none
        let pushConnect = Array(connections.values)[indexPath.row]
        
        if(pushConnect.hasNewPush) {
            
            if(!isPush)
            {
                isPush = true
                alter = alterView(frame: UIScreen.main.bounds)
                alter?.alertShow(withText: "是否确认登录？")
                alter?.lookBtn.addTarget(self, action: #selector(alterTrueBtnClick(sender:)), for: .touchUpInside)
                
                alter?.cancelBtn.addTarget(self, action: #selector(alterFalseBtnClick(sender:)), for: .touchUpInside)
            }
        }
        
        cell.accessoryType = .disclosureIndicator
        cell.setWebSocketConnection(connection: Array(connections.values)[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.navigationController?.pushViewController(accountDetailController(), animated: true)

    }
    
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除";
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? deviceConnectionCell {
            cell.connection?.isRetry = false
            cell.connection?.socket?.disconnect()
            self.connections.removeValue(forKey: (cell.connection?.id)!)
            
                        UserDefaults.standard.set(Array(self.connections.keys), forKey: "DeviceIdentifiers")
                        UserDefaults.standard.synchronize()
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    // MARK: Connection ask for confirm
    var pushConnection: WebSocketConnection?
    
    func scanSuccess(_ str: String!) {
        navigationController?.popViewController(animated: true)
        print("get qrcode :------\(str)------")
        
        //let value = parseURL(url: url)
        let value = parseURL(url: str)
        
        currentID = value.id
        currentHostname = value.hostname
        currentKey = value.key
        
        print("id = ", currentID ?? "空id", "hostname = ", currentHostname ?? "空hostname", "key = ", currentKey ?? "空key")
        
        print("数组的keys：\(connections.keys)")
        
        if connections.keys.contains(currentID!) {
            // delete the connection and information before
            
            connections[currentID!]?.isRetry = false
            connections[currentID!]?.socket?.disconnect()
            connections.removeValue(forKey: currentID!)
            
            UserDefaults.standard.set(Array(connections.keys), forKey: "DeviceIdentifiers")
            UserDefaults.standard.synchronize()
            
            
        }
        currentConnection = WebSocketConnection(id: currentID!, key: currentKey!, hostname: currentHostname!)
        currentConnection?.delegate = self as? WebSocketConnectionDelegate
        currentConnection?.webSocketConnect()
    }
    
    func firstLoadInfo() {
        
        
        
//        let deviceInfo = ["Auth://UU9id2JEaW5rWUpic0tkOExUb2xwampQNlgxTDdtQUw=-RVRuWlZOb2Zva2NieDhxMTNyTno=-N1Jib3pPd2E=",
//                          "Auth://NUZJaWpGV2dIQ0ZYd0RiSDYxYTU3S1B5RUtFS1d4SEk=-d1piMVlKQjI5aHhJT3JsZ3dLNVE=-N1Jib3pPd2E=",
//                          "Auth://WXNaVEtwbTVWSEdybFpQUXFHb1h5cEZMZ3lZaFdDY0Q=-YWhXOWtxQWRDR0E3NlNhdFVRYlA=-N1Jib3pPd2E="]
        
        let deviceInfo = ["Auth://UU9id2JEaW5rWUpic0tkOExUb2xwampQNlgxTDdtQUw=-RVRuWlZOb2Zva2NieDhxMTNyTno=-N1Jib3pPd2E="]
        
        
        for info in deviceInfo {
            loadInfo(str: info)
        }
    }
    
    func loadInfo(str:String) {
        let value = parseURL(url: str)
        
        currentID = value.id
        currentHostname = value.hostname
        currentKey = value.key
        
        print("id = ", currentID ?? "空id", "hostname = ", currentHostname ?? "空hostname", "key = ", currentKey ?? "空key")
        
        print("数组的keys：\(connections.keys)")
        
        if connections.keys.contains(currentID!) {
            // delete the connection and information before
            
            connections[currentID!]?.isRetry = false
            connections[currentID!]?.socket?.disconnect()
            connections.removeValue(forKey: currentID!)
            
            UserDefaults.standard.set(Array(connections.keys), forKey: "DeviceIdentifiers")
            UserDefaults.standard.synchronize()
            
            
        }
        currentConnection = WebSocketConnection(id: currentID!, key: currentKey!, hostname: currentHostname!)
        currentConnection?.delegate = self
        currentConnection?.webSocketConnect()
    }
    
    // MARK: AuthenticationPushViewControllerDelegate
    
    func authenticationPushResponse(controller: AuthenticationPushViewController, result: Bool) {
        pushConnection?.replyPushAuth(result: result)
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: WebSocketConnectionDelegate
    func firstConnectionSuccess() {
        connections[currentID!] = currentConnection
        
        UserDefaults.standard.set(Array(connections.keys), forKey: "DeviceIdentifiers")
        UserDefaults.standard.synchronize()
        
        reloadData()
    }
    
    func reloadData() {
        DispatchQueue.main.async(){
            self.tableview?.reloadData()
        }
    }
    
    func showAuthPush(connection: WebSocketConnection) {
        pushConnection = connection
    }
    
    
    func createBtn() {
        let rightBtn = UIButton(type: .custom)
        rightBtn.setBackgroundImage(UIImage.init(named: "add"), for: .normal)
        rightBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20);
        rightBtn.addTarget(self, action: #selector(MainTableViewController.qrScannerBtnClick), for: .touchUpInside)
        
        let leftBtn = UIButton(type: .custom)
        leftBtn.setBackgroundImage(UIImage.init(named: "men"), for: .normal)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20);
        
        let rightItem = UIBarButtonItem(customView: rightBtn)
        //let rightItem1 = UIBarButtonItem(customView: rightBtn1)
        
        //let btnItems:[UIBarButtonItem] = [rightItem,rightItem1]
        self.navigationItem.rightBarButtonItem = rightItem
        
        
//        let leftBtn = UIButton(type: .custom)
//        leftBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 20);
//        leftBtn.setTitle("edit", for: .normal)
//        leftBtn.setTitle("done", for: .selected)
//        leftBtn.titleLabel?.adjustsFontSizeToFitWidth = true
//        leftBtn.setTitleColor(UIColor.white, for: .normal)
        
        //_ = UIBarButtonItem(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        //leftBtn.addTarget(self, action: #selector(editBtnClick), for: .touchUpInside)
        //leftBtn.addTarget(self, action: #selector(editBtnClick(sender:)), for: .touchUpInside)
        leftBtn.addTarget(self, action: #selector(openLeftSlide), for: .touchUpInside)
    }
    
    func openLeftSlide() {
        let appdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
        if (appdelegate.leftSvc?.closed)! {
            appdelegate.leftSvc?.openLeftView()
        }
        else
        {
            appdelegate.leftSvc?.closeLeftView()
        }
    }
    
    func editBtnClick(sender:UIButton)  {
        if sender.isSelected {
            self.tableview?.setEditing(false, animated: true)
            sender.isSelected = false
        }
        else
        {
            self.tableview?.setEditing(true, animated: true)
            sender.isSelected = true
        }
        
    }
    
    func qrScannerBtnClick() {
        let zbarC = ScanQRCodeViewController()
        zbarC.delegate = self;
        self.navigationController?.pushViewController(zbarC, animated: true)
        //self.present(zbarC, animated: true, completion: nil)
        
    }
    
    func alterTrueBtnClick(sender: UIButton) -> () {
        
        isPush = false
        currentConnection?.hasNewPush = false
        currentConnection?.replyPushAuth(result: true)
        alter?.close()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.5) {
            DMCAlertCenter.default().postAlert(withMessage: "登录验证成功")
        }
    }
    
    func alterFalseBtnClick(sender: UIButton) -> () {
        isPush = false
        currentConnection?.hasNewPush = false
        currentConnection?.replyPushAuth(result: false)
        alter?.close()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1.5) {
            DMCAlertCenter.default().postAlert(withMessage: "登录验证失败")
        }
    }
    
    // MARK: private functions
    
    func parseURL(url: String) -> (key: Data, id: String, hostname: String) {
        let noPrefix: String = url.substring(from: url.index(url.startIndex, offsetBy: 7))
        let b64Array = noPrefix.characters.split(separator: "-")
        
        let keyData = Data(base64Encoded: String(b64Array[0]))
        
        let idData = Data(base64Encoded: String(b64Array[1]))
        let idString = String(data: idData!, encoding: String.Encoding.ascii)
        
        let hostnameData = Data(base64Encoded: String(b64Array[2]))
        let hostnameString = String(data: hostnameData!, encoding: String.Encoding.ascii)
        
        return (keyData!, idString!, hostnameString!)
    }
    
    //loginvcDelegate
    func loginvcDel() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+1) {
            let value = UserDefaults.standard.value(forKey: "DeviceIdentifiers")
            
            if (value != nil) {
                print(value!);
            }
            
            if let devices = value as? [String] {
                for device in devices {
                    let wsc = WebSocketConnection(id: device)
                    
                    self.currentConnection = wsc
                    
                    wsc.delegate = self
                    wsc.webSocketConnect()
                    self.connections[device] = wsc            }
            }
            
            self.tableview?.reloadData()
        }
    }
    
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
