//
//  blockChainCell.swift
//  iOSAuth
//
//  Created by 吴宇飞 on 2018/1/21.
//  Copyright © 2018年 Aran. All rights reserved.
//

import UIKit

class blockChainCell: UITableViewCell {

    var leftView:UIView?
    var leftNumLab:UILabel?
    var leftTextLab:UILabel?
    var rightView:UIView?
    var rightNumLab:UILabel?
    var rightTextLab:UILabel?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()
    }
    
    func configUI() {
        leftView = UIView()
        leftView?.backgroundColor = UIColor(red: 79.0/255.0, green: 115.0/255, blue: 166.0/255, alpha: 1)
        self.contentView.addSubview(leftView!)
        
        leftNumLab = UILabel()
        leftNumLab?.font = UIFont.systemFont(ofSize: 20)
        leftNumLab?.text = "23"
        leftNumLab?.textColor = UIColor.white
        leftNumLab?.textAlignment = .right
        leftView?.addSubview(leftNumLab!)
        
        leftTextLab = UILabel()
        leftTextLab?.font = UIFont.systemFont(ofSize: 20)
        leftTextLab?.text = "联盟成员数量"
        leftTextLab?.textColor = UIColor.white
        leftTextLab?.textAlignment = .right
        leftTextLab?.adjustsFontSizeToFitWidth = true
        leftView?.addSubview(leftTextLab!)
        
        
        
        rightView = UIView()
        rightView?.backgroundColor = UIColor(red: 115.0/255.0, green: 167.0/255, blue: 93.0/255, alpha: 1)
        self.contentView.addSubview(rightView!)
        
        rightNumLab = UILabel()
        rightNumLab?.font = UIFont.systemFont(ofSize: 20)
        rightNumLab?.text = "41"
        rightNumLab?.textColor = UIColor.white
        rightNumLab?.textAlignment = .right
        rightView?.addSubview(rightNumLab!)
        
        rightTextLab = UILabel()
        rightTextLab?.font = UIFont.systemFont(ofSize: 20)
        rightTextLab?.text = "区块平均产生时间"
        rightTextLab?.textAlignment = .right
        rightTextLab?.textColor = UIColor.white
        rightTextLab?.adjustsFontSizeToFitWidth = true
        rightView?.addSubview(rightTextLab!)
        
        let lineView = UIView()
        lineView.backgroundColor = UIColor.gray
        self.contentView.addSubview(lineView)
        
        let lineView1 = UIView()
        lineView1.backgroundColor = UIColor.gray
        self.contentView.addSubview(lineView1)
        
        lineView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0)
            make.bottom.equalToSuperview().offset(0)
            make.width.equalTo(1)
            make.centerX.equalToSuperview()
        }
        
        leftView?.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.left.equalToSuperview().offset(10)
            make.right.equalTo(lineView.snp.left).offset(-10)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        leftNumLab?.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 100, height: 25))
        }
        
        leftTextLab?.snp.makeConstraints { (make) in
            make.top.equalTo(leftNumLab!.snp.bottom).offset(10)
            make.right.equalTo(leftNumLab!.snp.right)
            make.size.equalTo(CGSize(width: 150, height: 30))
        }
        
        rightView?.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-10)
            make.left.equalTo(lineView.snp.left).offset(10)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        rightNumLab?.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(5)
            make.right.equalToSuperview().offset(-10)
            make.size.equalTo(CGSize(width: 100, height: 25))
        }
        
        rightTextLab?.snp.makeConstraints { (make) in
            make.top.equalTo(rightNumLab!.snp.bottom).offset(10)
            make.right.equalTo(rightNumLab!.snp.right)
            make.size.equalTo(CGSize(width: 150, height: 30))
        }
        
        lineView1.snp.makeConstraints { (make) in
            //make.top.equalTo(leftView!.snp.bottom).offset(1)
            make.bottom.equalToSuperview().offset(0)
            make.left.right.equalToSuperview().offset(0)
            make.height.equalTo(1)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
