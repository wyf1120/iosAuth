//
//  deviceConnectionCell.swift
//  iOSAuth
//
//  Created by 吴宇飞 on 2018/1/20.
//  Copyright © 2018年 Aran. All rights reserved.
//

import UIKit
import TrueTime


class deviceConnectionCell: UITableViewCell {
    @IBOutlet var admin: UILabel!
    @IBOutlet var connetionNum: UILabel!
    @IBOutlet var timeLab: UILabel!
    
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
            self.connetionNum.text = "960407"
            DispatchQueue.main.async(){
                //self.timeProgress.setProgress(Float(progress), animated: true)
                self.timeLab.text = "(\(30 - num)s)"
                
            }
            
        }
        timer?.resume()
    }

    func setWebSocketConnection(connection: WebSocketConnection) {
        
        self.connection = connection
        
        if connection.label != nil
        {
            //let index = connection.label
            admin.adjustsFontSizeToFitWidth = true
            admin.text = "admin: " + connection.label!.substring(to: connection.label!.index(connection.label!.startIndex, offsetBy:5))
        }
        
        connetionNum.text = connection.code ?? ""
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
