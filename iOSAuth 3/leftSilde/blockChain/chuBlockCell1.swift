//
//  chuBlockCell1.swift
//  iOSAuth
//
//  Created by 吴宇飞 on 2018/1/25.
//  Copyright © 2018年 Aran. All rights reserved.
//

import UIKit

class chuBlockCell1: UITableViewCell {

    let lab = UILabel()
    let lab1 = UILabel()
    let lab2 = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() -> () {
        lab.font = UIFont.systemFont(ofSize: 17)
        lab.layer.borderColor = UIColor.gray.cgColor
        lab.textColor = UIColor.gray
        lab.layer.borderWidth = 0.5
        self.contentView.addSubview(lab)
        
        lab1.font = UIFont.systemFont(ofSize: 17)
        lab1.layer.borderColor = UIColor.gray.cgColor
        lab1.textColor = UIColor.gray
        lab1.layer.borderWidth = 0.5
        self.contentView.addSubview(lab1)
        
        lab2.font = UIFont.systemFont(ofSize: 17)
        lab2.textColor = UIColor.gray
        lab2.layer.borderColor = UIColor.gray.cgColor
        lab2.layer.borderWidth = 0.5
        self.contentView.addSubview(lab2)
        
        lab.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(0)
            make.size.equalTo(CGSize(width: UIScreen.main.bounds.size.width/3, height: 30))
        }
        
        lab1.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(lab.snp.right).offset(0)
            make.size.equalTo(CGSize(width: UIScreen.main.bounds.size.width/3, height: 30))
        }
        
        lab2.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.left.equalTo(lab1.snp.right).offset(0)
            make.size.equalTo(CGSize(width: UIScreen.main.bounds.size.width/3, height: 30))
        }
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
