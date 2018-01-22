//
//  blockChainController.swift
//  iOSAuth
//
//  Created by 吴宇飞 on 2018/1/21.
//  Copyright © 2018年 Aran. All rights reserved.
//

import UIKit

class blockChainController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var colorArr = [UIColor(red: 79.0/255.0, green: 115.0/255, blue: 166.0/255, alpha: 1),UIColor(red: 115.0/255.0, green: 167.0/255, blue: 93.0/255, alpha: 1),UIColor(red: 200.0/255.0, green: 155.0/255, blue: 83.0/255, alpha: 1),UIColor(red: 171.0/255.0, green: 77.0/255, blue: 74.0/255, alpha: 1)]
    
    var nummberArr = ["23","41","124","54天"]
    
    var textArr = ["联盟成员数量","区块平均产生时间","区块高度","距上次出块时间"];
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "区块链状态"
        self.view.backgroundColor = UIColor.white
        
        let backBtn = UIButton(type: .custom)
        backBtn.setBackgroundImage(UIImage.init(named: "back"), for: .normal)
        backBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        
        configUI()
        // Do any additional setup after loading the view.
    }
    
    func configUI() {
        let tabelview = UITableView(frame: self.view.bounds, style: .plain)
        tabelview.delegate = self
        tabelview.dataSource = self
        tabelview.tableFooterView = UIView()
        tabelview.register(blockChainCell.self, forCellReuseIdentifier: "cell")
        tabelview.separatorStyle = .none
        self.view.addSubview(tabelview)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:blockChainCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! blockChainCell
        cell.selectionStyle = .none
        
        if indexPath.row == 0 {
            cell.leftView?.backgroundColor = colorArr[0]
            cell.leftNumLab?.text = nummberArr[0]
            cell.leftTextLab?.text = textArr[0]
            cell.rightView?.backgroundColor = colorArr[1]
            cell.rightNumLab?.text = nummberArr[1]
            cell.rightTextLab?.text = textArr[0]
        }
        else
        {
            cell.leftView?.backgroundColor = colorArr[2]
            cell.leftNumLab?.text = nummberArr[2]
            cell.leftTextLab?.text = textArr[2]
            cell.rightView?.backgroundColor = colorArr[3]
            cell.rightNumLab?.text = nummberArr[3]
            cell.rightTextLab?.text = textArr[3]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func backBtnClick()  {
        
        self.navigationController?.popViewController(animated: true)
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
