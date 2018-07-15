//
//  MainTabBarController.swift
//  MyRamenDataBase
//
//  Created by 佐藤　傑 on 2018/07/14.
//  Copyright © 2018年 佐藤　傑. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let collectionVC = ViewController(titleName: "Top")
        collectionVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        let nv = UINavigationController(rootViewController: collectionVC)
        
        let listVC = RamenListViewController(titleName: "Myリスト")
        listVC.tabBarItem = UITabBarItem(tabBarSystemItem: .mostViewed, tag: 2)
        listVC.tabBarItem.title = "list"
        let nv2 = UINavigationController(rootViewController: listVC)
        
        let MapVC = MapViewController(titleName: "Map")
        MapVC.tabBarItem = UITabBarItem(tabBarSystemItem: .bookmarks, tag: 3)
        MapVC.tabBarItem.title = "map"
        let nv3 = UINavigationController(rootViewController: MapVC)
        
        setViewControllers([nv, nv2, nv3], animated: false)
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
