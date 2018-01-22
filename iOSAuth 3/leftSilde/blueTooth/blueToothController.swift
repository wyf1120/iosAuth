//
//  blueToothController.swift
//  iOSAuth
//
//  Created by 吴宇飞 on 2018/1/22.
//  Copyright © 2018年 Aran. All rights reserved.
//

import UIKit

class blueToothController: UIViewController ,UITableViewDelegate,UITableViewDataSource{

    let bluetoothNameArr = ["设备名","sdfs","erw1","gyd666","wyf888"];
    let bluetoothStateArr = ["连接状态","OFF","OFF","ON","ON"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configUI()
        // Do any additional setup after loading the view.
    }

    func configUI() {
        let tableview = UITableView(frame: self.view.bounds, style: .plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.register(bluetoothCell.self, forCellReuseIdentifier: "cell")
        tableview.tableFooterView = UIView()
        self.view.addSubview(tableview)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bluetoothNameArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:bluetoothCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! bluetoothCell
        cell.bluetoothName.text = bluetoothNameArr[indexPath.row]
        cell.connectState.text = bluetoothStateArr[indexPath.row]
        if indexPath.row == 0 {
            cell.connectBtn.removeFromSuperview()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
