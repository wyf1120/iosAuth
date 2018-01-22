//
//  AuthenticationPushViewController.swift
//  iOSAuth
//
//  Created by Aran on 2017/3/7.
//  Copyright © 2017年 Aran. All rights reserved.
//

import UIKit

class AuthenticationPushViewController: UIViewController {
    
    @IBOutlet weak var ImageConfirm: UIImageView!
    @IBOutlet weak var ImageCancel: UIImageView!
    
    @IBOutlet weak var LabelApplication: UILabel!
    @IBOutlet weak var LabelApplicationData: UILabel!
    @IBOutlet weak var LabelIP: UILabel!
    @IBOutlet weak var LabelIPData: UILabel!
    @IBOutlet weak var LabelLocation: UILabel!
    @IBOutlet weak var LabelLocationData: UILabel!
    @IBOutlet weak var LabelTime: UILabel!
    @IBOutlet weak var LabelTimeData: UILabel!
    
    
    var connection: WebSocketConnection?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        SetupUI()
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
    
    // MARK: Action
    
    @IBAction func ConfirmPush(_ sender: UITapGestureRecognizer) {
        guard let connection = self.connection else {
            fatalError("Connection is not set")
        }
        connection.hasNewPush = false
        navigationController?.popViewController(animated: true)
        connection.replyPushAuth(result: true)
    }
    
    
    @IBAction func DenyPush(_ sender: UITapGestureRecognizer) {
        guard let connection = self.connection else {
            fatalError("Connection is not set")
        }
        connection.hasNewPush = false
        navigationController?.popViewController(animated: true)
        connection.replyPushAuth(result: false)
    }
    
    // MARK: private functions
    
    func SetupUI() {
        LabelApplication.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self.view.frame.width)
            make.centerX.equalTo(self.view.frame.width * 0.5)
            make.centerY.equalTo(self.view.frame.height * 1.0 / 6.0)
        }
        LabelApplicationData.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self.view.frame.width)
            make.centerX.equalTo(self.view.frame.width * 0.5)
            make.top.equalTo(self.LabelApplication.snp.bottom).offset(8.0)
        }
        
        LabelIP.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self.view.frame.width)
            make.centerX.equalTo(self.view.frame.width * 0.5)
            make.centerY.equalTo(self.view.frame.height * 2.0 / 6.0)
        }
        LabelIPData.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self.view.frame.width)
            make.centerX.equalTo(self.view.frame.width * 0.5)
            make.top.equalTo(self.LabelIP.snp.bottom).offset(8.0)
        }
        
        LabelLocation.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self.view.frame.width)
            make.centerX.equalTo(self.view.frame.width * 0.5)
            make.centerY.equalTo(self.view.frame.height * 3.0 / 6.0)
        }
        LabelLocationData.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self.view.frame.width)
            make.centerX.equalTo(self.view.frame.width * 0.5)
            make.top.equalTo(self.LabelLocation.snp.bottom).offset(8.0)
        }
        
        LabelTime.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self.view.frame.width)
            make.centerX.equalTo(self.view.frame.width * 0.5)
            make.centerY.equalTo(self.view.frame.height * 4.0 / 6.0)
        }
        LabelTimeData.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(self.view.frame.width)
            make.centerX.equalTo(self.view.frame.width * 0.5)
            make.top.equalTo(self.LabelTime.snp.bottom).offset(8.0)
        }
        
        ImageConfirm.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(70)
            make.height.equalTo(70)
            make.centerY.equalTo(self.view.frame.height * 5.0 / 6.0)
            make.centerX.equalTo(self.view.frame.width * 0.3)
        }
        
        ImageCancel.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(70)
            make.height.equalTo(70)
            make.centerY.equalTo(self.view.frame.height * 5.0 / 6.0)
            make.centerX.equalTo(self.view.frame.width * 0.7)
        }
    }

}
