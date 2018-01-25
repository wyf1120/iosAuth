//
//  chuBlcokCell.swift
//  iOSAuth
//
//  Created by 吴宇飞 on 2018/1/25.
//  Copyright © 2018年 Aran. All rights reserved.
//

import UIKit

class chuBlcokCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let tradeNumLab = UILabel()
        tradeNumLab.text = "近期登录产生交易数量"
        tradeNumLab.textAlignment = .center
        tradeNumLab.font = UIFont.systemFont(ofSize: 17)
        tradeNumLab.layer.borderWidth = 1
        tradeNumLab.layer.borderColor = UIColor.gray.cgColor
        self.contentView.addSubview(tradeNumLab)
        
        tradeNumLab.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: UIScreen.main.bounds.size.width, height: 20));
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
