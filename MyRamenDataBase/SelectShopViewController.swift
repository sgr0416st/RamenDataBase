//
//  SelectShopViewController.swift
//  MyRamenDataBase
//
//  Created by 佐藤　傑 on 2018/07/14.
//  Copyright © 2018年 佐藤　傑. All rights reserved.
//

import UIKit

class SelectShopView: UIView{
    let titleName: String?
    let shopNameTF: UITextField!
    let topMargin: CGFloat
    
    init(frame:CGRect, titleName:String, topMargin: CGFloat){
        //それぞれの部品の設定
        self.titleName = titleName
        self.topMargin = topMargin
        self.shopNameTF = UITextField()
        
        shopNameTF.placeholder = "店名を入力してください"
        shopNameTF.textAlignment = .center
        super.init(frame: frame)
        
        //配置の設定
        self.addSubview(shopNameTF)
        shopNameTF.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.top.equalTo(self.topMargin + 20)
            make.centerX.equalToSuperview()
        }
        
        self.backgroundColor = UIColor.yellow
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class SelectShopViewController: UIViewController, UITextFieldDelegate {
    
    var shopView: SelectShopView?
    var nextBtn: UIBarButtonItem!
    var backBtn: UIBarButtonItem!
    let titleName: String?
    var navBarHeight: CGFloat?
    var statusBarHeight:  CGFloat?
    var topMargin: CGFloat?

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

        //set up navigation bar
        self.navigationItem.title = titleName
        self.nextBtn = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(self.onClick))
        self.backBtn = UIBarButtonItem(title: "back", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = self.backBtn
        self.navigationItem.rightBarButtonItem = nextBtn
        self.statusBarHeight = UIApplication.shared.statusBarFrame.height
        if self.statusBarHeight == nil{
            self.statusBarHeight = CGFloat(0.0)
        }
        self.navBarHeight = self.navigationController?.navigationBar.frame.size.height
        if self.navBarHeight == nil{
            self.navBarHeight = CGFloat(0.0)
        }
        self.topMargin = self.statusBarHeight! + self.navBarHeight!
        
        //set up view
        self.shopView = SelectShopView(frame: self.view.bounds, titleName:self.titleName!, topMargin: self.topMargin!)
        self.view.addSubview(self.shopView!)
        self.shopView!.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        self.shopView?.shopNameTF.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //
        textField.resignFirstResponder()
        return true
    }

    
    @objc func onClick() {
        let nextVC = AddRamenDataViewController()
        nextVC.shopName = self.shopView?.shopNameTF.text
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
