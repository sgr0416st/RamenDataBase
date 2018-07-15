//
//  RamenListViewController.swift
//  MyRamenDataBase
//
//  Created by 佐藤　傑 on 2018/07/14.
//  Copyright © 2018年 佐藤　傑. All rights reserved.
//

import UIKit

class RamenListViewController: UIViewController {

    var addBtn: UIBarButtonItem!
    let titleName: String?
    private lazy var container: UIView = {
        let container = UIView()
        container.backgroundColor = UIColor.cyan
        return container
    }()
    
    init(titleName: String) {
        self.titleName = titleName
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        self.titleName=""
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = titleName
        self.view.addSubview(container)
        container.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        addBtn = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(self.onClick))
        self.navigationItem.rightBarButtonItem = addBtn

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func onClick() {
        let nextVC = SelectShopViewController(titleName: "SelectShop")
        nextVC.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(nextVC, animated: true)
    }

}
