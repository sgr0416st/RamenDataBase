//
//  ViewController.swift
//  MyRamenDataBase
//
//  Created by 佐藤　傑 on 2018/07/14.
//  Copyright © 2018年 佐藤　傑. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: StandardViewController ,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let nColumns = 2
    let nLines = 3
    let singleton :Singleton =  Singleton.sharedInstance
    
    var myCollectionView : UICollectionView!
    var computedCellSize: CGSize?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
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
    
    //Cellが選択された際に呼び出される
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
    }
    
    //Cellが選択された際に呼び出される
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.singleton.shopDataList.count
    }
    
    //Cellにデータを設定する
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell : CustomUICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomUICollectionViewCell
        
        cell.textLabel?.text = self.singleton.shopDataList[indexPath.row].shopName
        cell.imageBtn?.setImage(self.singleton.shopDataList[indexPath.row].noodles.image, for: .normal)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 一度計算したらキャッシュし、負荷を軽減
        // TODO: landscape表示に対応している場合は再計算を行うこと
        if let cellSize = self.computedCellSize {
            return cellSize
        } else {
            // PropotionalSizingCell.nibから原型セルを生成し、2列表示に適切なサイズを求める
            let prototypeCell = RamenCollectionViewCell()
            let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout
            //1ko
            let cellSize = prototypeCell.propotionalScaledSize(for: flowLayout!, numberOfColumns: self.nColumns, numberOfLines: self.nLines)
            self.computedCellSize = cellSize
            
            return cellSize
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

class CustomUICollectionViewCell : UICollectionViewCell,  PrototypeViewSizing{
    
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
            make.height.equalTo(self.imageBtn.snp.width)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10)
            
        }
        self.contentView.addSubview(self.textLabel!)
        self.textLabel.snp.makeConstraints{ make in
            make.width.equalTo(self.imageBtn.snp.width)
            make.height.equalTo(20)
            make.top.equalTo(self.imageBtn.snp.bottom).offset(10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.textLabel?.text = "no_name"
    }
    
}

