//
//  leftSortsController.swift
//  iOSAuth
//
//  Created by 吴宇飞 on 2018/1/19.
//  Copyright © 2018年 Aran. All rights reserved.
//

import UIKit

class leftSortsController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView = UIImageView(frame: self.view.bounds)
        imageView.image = UIImage.init(named: "leftbackiamge")
        self.view.addSubview(imageView)
        
        let tableview = UITableView(frame: self.view.bounds, style: .plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.tableFooterView = UIView()
        tableview.separatorStyle = .none
        self.view.addSubview(tableview)
        
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellID = "cell"
        var cell = tableView.dequeueReusableCell(withIdentifier: cellID)
        if !(cell != nil) {
            cell = UITableViewCell(style: .default, reuseIdentifier: cellID)
        }
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 20.0)
        cell?.backgroundColor = UIColor.clear
        cell?.textLabel?.textColor = UIColor.white
        cell?.textLabel?.font = UIFont.systemFont(ofSize: 20)
        cell?.imageView?.bounds = CGRect(x: 0, y: 0, width: 25, height: 25)
        switch indexPath.row {
        case 0:
            cell?.textLabel?.text = "区块链概述"
            cell?.imageView?.image = UIImage.init(named: "blockchain")
            break
        case 1:
            cell?.textLabel?.text = "蓝牙连接"
            cell?.imageView?.image = UIImage.init(named: "bluetooth")
            break
        case 2:
            cell?.textLabel?.text = "设置"
            cell?.imageView?.image = UIImage.init(named: "set")
            break
        default:
            break
        }
        return cell!
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            tableView.deselectRow(at: indexPath, animated: true)
            let appdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let blockC = blockChainController()
            appdelegate.leftSvc?.closeLeftView()
            appdelegate.navigationController?.pushViewController(blockC, animated: true)
            break
        case 1:
            tableView.deselectRow(at: indexPath, animated: true)
            let appdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let blueTooth = blueToothController()
            appdelegate.leftSvc?.closeLeftView()
            appdelegate.navigationController?.pushViewController(blueTooth, animated: true)
            break
        case 2:
            tableView.deselectRow(at: indexPath, animated: true)
            let appdelegate:AppDelegate = UIApplication.shared.delegate as! AppDelegate
            let blueTooth = setController()
            appdelegate.leftSvc?.closeLeftView()
            appdelegate.navigationController?.pushViewController(blueTooth, animated: true)
            break
        default:
            break
        }
        
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: 180))
        view.backgroundColor = UIColor.clear
        return view
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
