//
//  abnormalDetailController.swift
//  iOSAuth
//
//  Created by 吴宇飞 on 2018/1/29.
//  Copyright © 2018年 Aran. All rights reserved.
//

import UIKit

class abnormalDetailController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "异常登录详情"
        self.view.backgroundColor = UIColor.white
        
        let backBtn = UIButton(type: .custom)
        backBtn.setBackgroundImage(UIImage.init(named: "back"), for: .normal)
        backBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)

        configUI()
        
        // Do any additional setup after loading the view.
    }

    func backBtnClick()  {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func configUI()  {
        let tableview = UITableView(frame: self.view.bounds, style: .plain)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.separatorStyle = .none
        tableview.register(mapCell.self, forCellReuseIdentifier: "mapCell")
        tableview.register(normalAccountCell.self, forCellReuseIdentifier: "normalCell")
        tableview.tableFooterView = UIView()
        self.view.addSubview(tableview)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell:normalAccountCell = tableView.dequeueReusableCell(withIdentifier: "normalCell", for: indexPath) as! normalAccountCell
            cell.selectionStyle = .none
            cell.img.image = UIImage.init(named: "abnormal")
            return cell
        }
        else
        {
            let cell:mapCell = tableView.dequeueReusableCell(withIdentifier: "mapCell", for: indexPath) as! mapCell
            cell.configUI(text: "异常登录")
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 155*UIScreen.main.bounds.size.height/568;
        }
        else
        {
            return UIScreen.main.bounds.size.height - 155
        }
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
