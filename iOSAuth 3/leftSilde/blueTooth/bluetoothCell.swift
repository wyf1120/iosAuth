//
//  bluetoothCell.swift
//  iOSAuth
//
//  Created by 吴宇飞 on 2018/1/22.
//  Copyright © 2018年 Aran. All rights reserved.
//

import UIKit

class bluetoothCell: UITableViewCell {

    let bluetoothName = UILabel()
    let connectState = UILabel()
    let connectBtn = UIButton(type: .custom)
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI()  {
        
        bluetoothName.font = UIFont.systemFont(ofSize: 17)
        self.contentView.addSubview(bluetoothName)
        
        connectState.font = UIFont.systemFont(ofSize: 17)
        connectState.textAlignment = .center
        self.contentView.addSubview(connectState)
        
        connectBtn.setTitle("连接", for: .normal)
        connectBtn.backgroundColor = UIColor.white
        connectBtn.setTitleColor(UIColor.black, for: .normal)
        connectBtn.layer.borderWidth = 1
        connectBtn.layer.borderColor = UIColor.gray.cgColor
        connectBtn.layer.cornerRadius = 4
        connectBtn.layer.masksToBounds = true
        self.contentView.addSubview(connectBtn)
        
        bluetoothName.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(12.5)
            make.left.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 120, height: 20));
        }
        
        connectState.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(bluetoothName.snp.centerY)
            make.size.equalTo(CGSize(width: 100, height: 20))
        }
        
        connectBtn.snp.makeConstraints { (make) in
            make.centerY.equalTo(bluetoothName.snp.centerY)
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 80, height: 35))
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
