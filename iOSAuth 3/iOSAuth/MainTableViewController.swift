//
//  MainTableViewController.swift
//  iOSAuth
//
//  Created by Aran on 2017/3/6.
//  Copyright © 2017年 Aran. All rights reserved.
//

import UIKit
import CryptoSwift

class MainTableViewController: UITableViewController, QRScannerViewControllerDelegate, WebSocketConnectionDelegate, scanQRCodeControllerDelegate {

    
    var connections = [String: WebSocketConnection]()
    
    // MARK: Current Connection Info
    var currentKey: Data?
    var currentID: String?
    var currentHostname: String?
    var currentConnection: WebSocketConnection?
    
    var isPush = false
    
    var alter: alterView?
    
    // MARK: Connection ask for confirm
    var pushConnection: WebSocketConnection?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let topView = UIImageView(frame: CGRect(x: UIScreen.main.bounds.size.width/2-20, y: 0, width: 40, height: 40));
        topView.image = UIImage(named: "2")
        topView.layer.cornerRadius = 20;
        topView.layer.masksToBounds = true
        self.navigationController?.navigationBar.addSubview(topView)
        
        createBtn()
        
        self.navigationController?.navigationBar.barTintColor = UIColor(red: 56.0/255.0, green: 69.0/255.0, blue: 78.0/255.0, alpha: 1)
        
//        tableView.estimatedRowHeight = 96.0
//        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        
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
        
        tableView.reloadData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        switch section {
        case 0:
            return connections.count
        case 1:
            return 1
        default:
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        switch indexPath.section {
        case 0:
            if (indexPath.row < connections.count) {
                cell = tableView.dequeueReusableCell(withIdentifier: "TableCellDevice", for: indexPath)
                
                let deviceCell = cell as! DeviceConnectionTableViewCell
                
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
                
                cell?.accessoryType = .disclosureIndicator
                deviceCell.setWebSocketConnection(connection: Array(connections.values)[indexPath.row])
            }
            else {
                cell = tableView.dequeueReusableCell(withIdentifier: "TableCellScanQRCode", for: indexPath)
            }
            break
        case 1:
            cell = tableView.dequeueReusableCell(withIdentifier: "ToTestCell", for: indexPath)
            break
        default:
            break
        }

        guard (cell != nil) else {
            fatalError("cell is nil")
        }
        
        return cell!
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? DeviceConnectionTableViewCell {
            
            self.navigationController?.pushViewController(cellDetailController(), animated: true)
            
//            if(cell.connection?.hasNewPush)! {
//                performSegue(withIdentifier: "SegueAuthPush", sender: cell)
//            }
//            else {
//                let alert: UIAlertController = UIAlertController(title:nil, message:"Are you sure to delete this item?", preferredStyle:UIAlertControllerStyle.alert)
//                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
//                alert.addAction(UIAlertAction(title: "Delete", style: .destructive, handler: {
//                    (action: UIAlertAction) -> Void in
//                    cell.connection?.isRetry = false
//                    cell.connection?.socket?.disconnect()
//                    self.connections.removeValue(forKey: (cell.connection?.id)!)
//
//                    UserDefaults.standard.set(Array(self.connections.keys), forKey: "DeviceIdentifiers")
//                    UserDefaults.standard.synchronize()
//
//                    tableView.reloadData()
//                }))
//                self.present(alert, animated: true, completion: nil)
//            }
        }
    }
    
    // MARK: - Navigation

    //delte cell
    override func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        return "删除";
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? DeviceConnectionTableViewCell {
            cell.connection?.isRetry = false
            cell.connection?.socket?.disconnect()
            self.connections.removeValue(forKey: (cell.connection?.id)!)
            
//            UserDefaults.standard.set(Array(self.connections.keys), forKey: "DeviceIdentifiers")
//            UserDefaults.standard.synchronize()
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 96
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueScanQR" {
            let vc = segue.destination as! QRScannerViewController
            vc.delegate = self
        }
        else if segue.identifier == "SegueAuthPush" {
            let vc = segue.destination as! AuthenticationPushViewController
            guard let cell = sender as? DeviceConnectionTableViewCell else {
                fatalError("sender is not a DeviceConnectionTableViewCell")
            }
            vc.connection = cell.connection
        }
    }
    
    // MARK: QRScannerViewControllerDelegate
    
    
    func scanSuccess(_ str: String!) {
        print("scanStr: \(str)")
        
        let value = parseURL(url: str)
        currentID = value.id
        currentHostname = value.hostname
        currentKey = value.key
        
        print("id = ", currentID, "hostname = ", currentHostname, "key = ", currentKey)
        
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
    
    
    func qrScanningDidFinish(controller: QRScannerViewController, url: String) {
        navigationController?.popViewController(animated: true)
        print("get qrcode :\(url)")
        
        let value = parseURL(url: url)
        currentID = value.id
        currentHostname = value.hostname
        currentKey = value.key
        
        print("id = ", currentID, "hostname = ", currentHostname, "key = ", currentKey)
        
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
            self.tableView.reloadData()
        }
    }
    
    func showAuthPush(connection: WebSocketConnection) {
        pushConnection = connection
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
    
    // MARK: create nagivegation item

    func createBtn() {
        let rightBtn = UIButton(type: .custom)
        rightBtn.setBackgroundImage(UIImage.init(named: "add"), for: .normal)
        rightBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20);
        rightBtn.addTarget(self, action: #selector(MainTableViewController.qrScannerBtnClick), for: .touchUpInside)
        
        let rightBtn1 = UIButton(type: .custom)
        rightBtn1.setBackgroundImage(UIImage.init(named: "men"), for: .normal)
        rightBtn1.frame = CGRect(x: 0, y: 0, width: 20, height: 20);
        
        let rightItem = UIBarButtonItem(customView: rightBtn)
        let rightItem1 = UIBarButtonItem(customView: rightBtn1)

        let btnItems:[UIBarButtonItem] = [rightItem,rightItem1]
        self.navigationItem.rightBarButtonItems = btnItems
        
        
        let leftBtn = UIButton(type: .custom)
        leftBtn.frame = CGRect(x: 0, y: 0, width: 40, height: 20);
        leftBtn.setTitle("edit", for: .normal)
        leftBtn.setTitle("done", for: .selected)
        leftBtn.titleLabel?.adjustsFontSizeToFitWidth = true
        leftBtn.setTitleColor(UIColor.white, for: .normal)
        
        //_ = UIBarButtonItem(customView: leftBtn)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftBtn)
        //leftBtn.addTarget(self, action: #selector(editBtnClick), for: .touchUpInside)
        leftBtn.addTarget(self, action: #selector(editBtnClick(sender:)), for: .touchUpInside)
    }
    
    func editBtnClick(sender:UIButton)  {
        if sender.isSelected {
            tableView.setEditing(false, animated: true)
            sender.isSelected = false
        }
        else
        {
            tableView.setEditing(true, animated: true)
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
    
}
