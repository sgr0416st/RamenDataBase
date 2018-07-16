//
//  PrototypeViewSizing.swift.swift
//  MyRamenDataBase
//
//  Created by 佐藤　傑 on 2018/07/16.
//  Copyright © 2018年 佐藤　傑. All rights reserved.
//

import UIKit

protocol PrototypeViewSizing: class {
}

extension PrototypeViewSizing where Self: UICollectionViewCell {
    /// 原型ビューに準拠した大きさを求める。
    /// self自身のレイアウトを変更するため、表示に利用していないビューから呼び出すこと。
    ///
    /// - Parameters:
    ///   - flowLayout: フローレイアウト
    ///   - nColumns: 列数
    /// - Returns: 大きさを返す
    func propotionalScaledSize(
        for flowLayout: UICollectionViewFlowLayout,
        numberOfColumns nColumns: Int
        ) -> CGSize {
        // 幅は必ず指定のwidthに合わせ、高さはLayout Constraintに則った値とするサイズを求める
        let width = flowLayout.preferredItemWidth(forNumberOfColumns: nColumns)
        self.bounds.size = CGSize(width: width, height: 0)
        self.layoutIfNeeded()
        
        return self.systemLayoutSizeFitting(
            UILayoutFittingExpandedSize,
            withHorizontalFittingPriority: UILayoutPriority.required,
            verticalFittingPriority: UILayoutPriority.defaultLow
        )
    }
    
    func propotionalScaledSize(
        for flowLayout: UICollectionViewFlowLayout,
        numberOfLines nLines: Int
        ) -> CGSize {
        // 高さは必ず指定のHeightに合わせ、幅はLayout Constraintに則った値とするサイズを求める
        let height = flowLayout.preferredItemWidth(forNumberOfColumns: nLines)
        
        self.bounds.size = CGSize(width: 0, height: height)
        
        self.layoutIfNeeded()
        
        return self.systemLayoutSizeFitting(
            UILayoutFittingExpandedSize,
            withHorizontalFittingPriority: UILayoutPriority.defaultLow,
            verticalFittingPriority: UILayoutPriority.required
        )
    }
    
    func propotionalScaledSize(
        for flowLayout: UICollectionViewFlowLayout,
        numberOfColumns nColumns: Int,
        numberOfLines nLines: Int
        ) -> CGSize {
        // 指定のHeight,widthに合わせる
        let height = flowLayout.preferredItemHeight(forNumberOfColumns: nLines)
        let width = flowLayout.preferredItemWidth(forNumberOfColumns: nColumns)
        return CGSize(width: width, height: height)

    }
}

private extension UICollectionViewFlowLayout {
    /// 列数に対するアイテムの推奨サイズ(幅)を求める。
    ///
    /// - Parameter nColumns: 列数
    /// - Returns: 幅を返す
    func preferredItemWidth(forNumberOfColumns nColumns: Int) -> CGFloat {
        guard nColumns > 0 else {
            return 0
        }
        guard let collectionView = self.collectionView else {
            fatalError()
        }
        
        let collectionViewWidth = collectionView.bounds.width
        let inset = self.sectionInset
        let spacing = self.minimumInteritemSpacing
        
        print(collectionViewWidth)
        print(inset)
        print(spacing)
        
        // コレクションビューの幅から、各余白を除いた幅を均等に割る
        return (collectionViewWidth - (inset.left + inset.right + spacing * CGFloat(nColumns - 1))) / CGFloat(nColumns)
    }
    
    func preferredItemHeight(forNumberOfColumns nLines: Int) -> CGFloat {
        guard nLines > 0 else {
            return 0
        }
        guard let collectionView = self.collectionView else {
            fatalError()
        }
        
        let collectionViewHeight = collectionView.bounds.height
        let inset = self.sectionInset
        let spacing = self.minimumInteritemSpacing
        
        print(collectionViewHeight)
        print(inset)
        print(spacing)
        
        // コレクションビューの幅から、各余白を除いた幅を均等に割る
        return (collectionViewHeight - (inset.top + inset.bottom + spacing * CGFloat(nLines - 1))) / CGFloat(nLines)
    }
    
}
