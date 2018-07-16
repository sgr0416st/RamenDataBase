//
//  ViewController.swift
//  MyRamenDataBase
//
//  Created by 佐藤　傑 on 2018/07/14.
//  Copyright © 2018年 佐藤　傑. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: StandardViewController ,  UICollectionViewDelegate, UICollectionViewDataSource{
    
    var myCollectionView : UICollectionView!
    let singleton :Singleton =  Singleton.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        
        // Cell一つ一つの大きさ.
        //layout.itemSize = CGSize(width:50, height:50)
        //layout.itemSize = CGSize(width:self.view.frame.width, height: )
            let cellWidth = floor(self.view.bounds.width / 2)  // *7列*
            
            layout.itemSize = CGSize(width: cellWidth, height: cellWidth*1.5)
            // ここからはオプション マージンとかをなくしている
            layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            layout.minimumInteritemSpacing = 0 // アイテム間?
            layout.minimumLineSpacing = 0 // 行間
        
        
        // Cellのマージン.
        //layout.sectionInset = UIEdgeInsetsMake(16, 16, 32, 16)
        
        // セクション毎のヘッダーサイズ.
        layout.headerReferenceSize = CGSize(width:100,height:30)
        
        // CollectionViewを生成.
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        
        // Cellに使われるクラスを登録.
        myCollectionView.register(CustomUICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
        
        myCollectionView.delegate = self
        myCollectionView.dataSource = self
        
        self.view.addSubview(myCollectionView)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myCollectionView.reloadData()
    }
    
    //* 下記はViewController で指定する (マージン対策）
    override func viewWillLayoutSubviews() {
        self.view.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    /*
     Cellが選択された際に呼び出される
     */
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        
    }
    
    /*
     Cellの総数を返す
     */
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.singleton.shopDataList.count
    }
    
    /*
     Cellにデータを設定する
     */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CustomUICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomUICollectionViewCell
        
        cell.textLabel?.text = self.singleton.shopDataList[indexPath.row].shopName
        cell.imageBtn?.setImage(self.singleton.shopDataList[indexPath.row].noodles.image, for: .normal)
        
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class CustomUICollectionViewCell : UICollectionViewCell{
    
    var textLabel : UILabel!
    var imageBtn: UIButton!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.imageBtn = UIButton()
        self.imageBtn?.imageView?.contentMode = .scaleAspectFit
        self.imageBtn?.contentHorizontalAlignment = .fill
        self.imageBtn?.contentVerticalAlignment = .fill
        self.textLabel = UILabel()
        self.textLabel?.text = "nil"
        self.textLabel?.textAlignment = NSTextAlignment.center
        self.contentView.backgroundColor = UIColor.white
        
        self.contentView.addSubview(self.imageBtn!)
        self.imageBtn.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalToSuperview().multipliedBy(0.75)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            
        }
        self.contentView.addSubview(self.textLabel!)
        self.textLabel.snp.makeConstraints{ make in
            make.width.equalToSuperview()
            make.top.equalTo(self.imageBtn.snp.bottom).offset(10)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.textLabel?.text = "no_name"
    }
    
}

