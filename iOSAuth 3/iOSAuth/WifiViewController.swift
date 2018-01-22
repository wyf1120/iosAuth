//
//  WifiViewController.swift
//  iOSAuth
//
//  Created by Aran on 2017/4/11.
//  Copyright © 2017年 Aran. All rights reserved.
//

import UIKit
import NetworkExtension

class WifiViewController: UIViewController {
    @IBOutlet weak var wifiLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let options: [String: NSObject] = [kNEHotspotHelperOptionDisplayName : "Join this WIFI" as NSObject]
        let queue: DispatchQueue = DispatchQueue(label: "com.aran", attributes: DispatchQueue.Attributes.concurrent)
        
        NSLog("Started wifi scanning.")
        
        let bool = NEHotspotHelper.register(options: options, queue: queue) { (cmd: NEHotspotHelperCommand) in
            NSLog("Received command: \(cmd.commandType.rawValue)")
        }
        
        print(bool)
        
        var list = NEHotspotHelper.supportedNetworkInterfaces()
        wifiLabel.text = String(describing: list.count)
        // Do any additional setup after loading the view.
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
