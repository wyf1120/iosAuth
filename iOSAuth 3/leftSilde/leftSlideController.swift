//
//  leftSlideController.swift
//  iOSAuth
//
//  Created by 吴宇飞 on 2018/1/19.
//  Copyright © 2018年 Aran. All rights reserved.
//

import UIKit

class leftSlideController: UIViewController {

    func initLeftViewAndMainView(leftView:UIViewController , mainView:UIViewController) {
        
        //self.view.backgroundColor = UIColor.red
        self.view.addSubview(mainView.view)
        //return self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
