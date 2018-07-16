//
//  StandardViewController.swift
//  
//
//  Created by 佐藤　傑 on 2018/07/16.
//

import UIKit

class StandardViewController: UIViewController {
        
    var addBtn: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = "Top"

        self.addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.addData))
        self.navigationItem.rightBarButtonItem = addBtn
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func addData() {
        let nextVC = SelectShopViewController(titleName: "SelectShop")
        nextVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
}
