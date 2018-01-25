//
//  abnormalCell.swift
//  iOSAuth
//
//  Created by 吴宇飞 on 2018/1/25.
//  Copyright © 2018年 Aran. All rights reserved.
//

import UIKit

class abnormalCell: UITableViewCell {

    let numLab = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configUI() {
        let hackerImg = UIImageView()
        hackerImg.image = UIImage.init(named: "hacker")
        self.contentView.addSubview(hackerImg)
        
        let textLab = UILabel()
        textLab.textColor = UIColor.red
        textLab.text = "账户威胁次数"
        textLab.font = UIFont.systemFont(ofSize: 22)
        textLab.textAlignment = .center
        self.contentView.addSubview(textLab)
        
        numLab.font = UIFont.systemFont(ofSize: 30, weight: 0.5)
        numLab.text = "13次"
        numLab.textAlignment = .center
        self.contentView.addSubview(numLab)
        
        hackerImg.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.left.equalTo(10)
            make.size.equalTo(CGSize(width: 200, height: 158))
        }
        
        textLab.snp.makeConstraints { (make) in
            make.top.equalTo(30);
            make.left.equalTo(hackerImg.snp.right).offset(0)
            make.right.equalTo(0)
            make.height.equalTo(35)
        }
        
        numLab.snp.makeConstraints { (make) in
            make.top.equalTo(textLab.snp.bottom).offset(20)
            make.left.equalTo(textLab.snp.left)
            make.right.equalTo(textLab.snp.right)
            make.height.equalTo(40)
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
