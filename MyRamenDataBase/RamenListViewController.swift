//
//  RamenListViewController.swift
//  MyRamenDataBase
//
//  Created by 佐藤　傑 on 2018/07/14.
//  Copyright © 2018年 佐藤　傑. All rights reserved.
//

import UIKit

struct Pages {
    var viewControllers:[UIViewController] = []
}

class RamenListViewController: StandardViewController,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var ramenCollectionView : UICollectionView!
    let singleton :Singleton =  Singleton.sharedInstance
    var pages:Pages = Pages(){
        didSet {
            ramenCollectionView.reloadData()
        }
    }
    var computedCellSize: CGSize?


    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red

        // CollectionViewのレイアウトを生成.
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        
        // CollectionViewを生成.
        self.ramenCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        self.ramenCollectionView.isPagingEnabled = true
        self.view.addSubview(ramenCollectionView)
        self.ramenCollectionView.snp.makeConstraints{ make in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
        // Cellに使われるクラスを登録.
        ramenCollectionView.register(RamenCollectionViewCell.self, forCellWithReuseIdentifier: "RamenPageCell")
        ramenCollectionView.delegate = self
        ramenCollectionView.dataSource = self
        
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        ramenCollectionView.reloadData()
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
        
        let cell : RamenCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RamenPageCell", for: indexPath) as! RamenCollectionViewCell
        
        cell.shopNameLb?.text = self.singleton.shopDataList[indexPath.row].shopName
        cell.imageView?.image = self.singleton.shopDataList[indexPath.row].noodles.image
        cell.noodlesNameLb.text = self.singleton.shopDataList[indexPath.row].noodles.name
        cell.commentLb.text = self.singleton.shopDataList[indexPath.row].noodles.comment
        
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
            let cellSize = prototypeCell.propotionalScaledSize(for: flowLayout!, numberOfColumns: 1, numberOfLines: 1)
            self.computedCellSize = cellSize
            
            return cellSize
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

class RamenCollectionViewCell : UICollectionViewCell, PrototypeViewSizing{
    
    var shopNameLb : UILabel!
    var imageView: UIImageView!
    var noodlesNameLb: UILabel!
    var commentLb:UILabel!
    var scrollView: UIScrollView!
    var inView: UIView!
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.scrollView = UIScrollView()
        self.inView = UIView()
        self.shopNameLb = UILabel()
        self.shopNameLb?.textAlignment = NSTextAlignment.center
        self.imageView = UIImageView()
        self.noodlesNameLb = UILabel()
        self.noodlesNameLb?.textAlignment = NSTextAlignment.center
        self.commentLb = UILabel()
        self.commentLb?.textAlignment = NSTextAlignment.left
        
        self.contentView.backgroundColor = UIColor.white
        
        self.contentView.addSubview(self.scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
        self.scrollView.addSubview(self.inView)
        inView.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self.scrollView)
            make.left.right.equalTo(self.contentView) // => IMPORTANT: this makes the width of the contentview static (= size of the screen), while the contentview will stretch vertically
        }
        self.inView.addSubview(self.shopNameLb!)
        self.shopNameLb.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalToSuperview().dividedBy(16)
            make.top.equalTo(self.inView).offset(20)
            make.centerX.equalToSuperview()
        }
        self.inView.addSubview(self.imageView!)
        self.imageView.snp.makeConstraints{ make in
            make.width.equalTo(shopNameLb)
            make.height.equalTo(self.imageView.snp.width).multipliedBy(1.33)
            make.top.equalTo(self.shopNameLb.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        self.inView.addSubview(self.noodlesNameLb!)
        self.noodlesNameLb.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalToSuperview().dividedBy(16)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.imageView.snp.bottom).offset(20)
        }
        self.inView.addSubview(self.commentLb!)
        self.commentLb.snp.makeConstraints{ make in
            make.width.equalToSuperview().multipliedBy(0.75)
            make.centerX.equalToSuperview()
            make.top.equalTo(self.noodlesNameLb.snp.bottom).offset(20)
            make.bottom.equalTo(self.inView).offset(-20)
        }
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.shopNameLb?.text = "no shop name"
        self.imageView?.image = nil
        self.noodlesNameLb?.text = "no noodles name"
        self.commentLb?.text = "no comment"

    }

}
