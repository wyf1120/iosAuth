//
//  DeviceTableViewCell.swift
//  iOSAuth
//
//  Created by Aran on 2017/4/1.
//  Copyright © 2017年 Aran. All rights reserved.
//

import UIKit
import TrueTime

class DeviceConnectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var identifierLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    
    @IBOutlet weak var timeLab: UILabel!
    
    
    var connection: WebSocketConnection?
    
    
    var timer: DispatchSourceTimer?

    override func awakeFromNib() {
        super.awakeFromNib()
        
        timer = DispatchSource.makeTimerSource()
        timer?.scheduleRepeating(deadline: .now(), interval: 1)
        timer?.setEventHandler {
            let counter = TrueTimeClient.sharedInstance.referenceTime?.now().timeIntervalSince1970 ?? Date().timeIntervalSince1970
            //let progress = counter / 30 - floor(counter / 30)
            
            print("counter: \(counter/30) , floor: \(floor(counter/30)) , 余：\(counter.truncatingRemainder(dividingBy: 30))")
            
            print("(\(floor(counter.truncatingRemainder(dividingBy: 30)))s)")
            
            var num:Int = Int(floor(counter.truncatingRemainder(dividingBy: 30)))
            print("num: \(30 - num)")
            DispatchQueue.main.async(){
                //self.timeProgress.setProgress(Float(progress), animated: true)
                self.timeLab.text = "(\(30 - num)s)"

            }
            
        }
        timer?.resume()
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    override func didMoveToSuperview() {
//        super.didMoveToSuperview()
//        pushView.frame = CGRect(x: Int(self.contentView.frame.width), y: 0, width: 70, height: Int(self.contentView.frame.height))
//        pushView.isHidden = false
//    }
    
    func setWebSocketConnection(connection: WebSocketConnection) {
        
        self.connection = connection
        
        if connection.label != nil
        {
            //let index = connection.label
            
            identifierLabel.text = "admin: " + connection.label!.substring(to: connection.label!.index(connection.label!.startIndex, offsetBy:4))
        }
        
        codeLabel.text = connection.code ?? ""
        //connectImage.image = connection.isConnected ? #imageLiteral(resourceName: "connected") : #imageLiteral(resourceName: "connecting")
        
//        UIView.animate(withDuration: 0.5, delay: 0.5, options: .curveEaseInOut, animations: {
//            () -> Void in
//            if(self.connection?.hasNewPush)! {
//
//                self.pushView?.frame = CGRect(x: Int(self.contentView.frame.width - 70), y: 0, width: 70, height: Int(self.contentView.frame.height))
//            }
//            else {
//                self.pushView?.frame = CGRect(x: Int(self.contentView.frame.width), y: 0, width: 70, height: Int(self.contentView.frame.height))
//            }
//        })
    }

}
