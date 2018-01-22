//
//  cellDetailController.swift
//  iOSAuth
//
//  Created by 吴宇飞 on 2018/1/15.
//  Copyright © 2018年 Aran. All rights reserved.
//

import UIKit

class cellDetailController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.title = "cellDetail"
        self.view.backgroundColor = UIColor.white
        
        let backBtn = UIButton(type: .custom)
        backBtn.setBackgroundImage(UIImage.init(named: "back"), for: .normal)
        backBtn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        backBtn.addTarget(self, action: #selector(backBtnClick), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        // Do any additional setup after loading the view.
    }

    func backBtnClick()  {
        self.navigationController?.popViewController(animated: true)
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
