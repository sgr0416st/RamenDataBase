//
//  ShopData.swift
//  Sample
//
//  Created by 佐藤　傑 on 2018/07/11.
//  Copyright © 2018年 佐藤　傑. All rights reserved.
//

import Foundation
import UIKit

class NoodlesData: NSObject,NSCoding{
    var name:String
    var image:UIImage
    var type:String
    var comment:String
    private var imageData:Data
    
    static let name_key = "name"
    static let imageData_key = "image"
    static let type_key = "type"
    static let comment_key = "comment"
    
    init(name: String, image: UIImage!, type: String, comment:String) {
        self.name = name
        self.image = image
        self.type = type
        self.comment = comment
        self.imageData = UIImagePNGRepresentation(self.image)!
    }
    
    required init(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObject(forKey: NoodlesData.name_key) as! String
        self.imageData = aDecoder.decodeObject(forKey: NoodlesData.imageData_key) as! Data
        self.type = aDecoder.decodeObject(forKey: NoodlesData.type_key) as! String
        self.comment = aDecoder.decodeObject(forKey: NoodlesData.comment_key) as! String
        
        self.image =  UIImage(data: self.imageData)!
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.name, forKey: NoodlesData.name_key)
        aCoder.encode(self.imageData, forKey: NoodlesData.imageData_key)
        aCoder.encode(self.type, forKey: NoodlesData.type_key)
        aCoder.encode(self.comment, forKey: NoodlesData.comment_key)
    }
}

class ShopData: NSObject,NSCoding{
    var shopName:String
    var noodles:NoodlesData
    
    static let shopName_key = "shopName"
    static let noodles_key = "noodles"
    
    init(shopName:String, noodles:NoodlesData) {
        self.shopName = shopName
        self.noodles = noodles
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.shopName = aDecoder.decodeObject(forKey: ShopData.shopName_key) as! String
        self.noodles = aDecoder.decodeObject(forKey: ShopData.noodles_key) as! NoodlesData
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.shopName, forKey: ShopData.shopName_key)
        aCoder.encode(self.noodles, forKey: ShopData.noodles_key)

    }
}


class Singleton: NSObject {
    var shopDataList:[ShopData] = {
        var s_list:[ShopData] = []
        if let unarchivedObject = UserDefaults.standard.object(forKey: "MyRamenDataBase") as? Data{
            if let list = NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject) as? [ShopData] {
                s_list = list
            }
        }
        return s_list
    }()
    static let sharedInstance: Singleton = Singleton()
    
    private override init(){
    }
}
