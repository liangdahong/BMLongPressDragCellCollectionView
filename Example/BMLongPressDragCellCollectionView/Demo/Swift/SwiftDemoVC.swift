//
//  SwiftDemoVC.swift
//  BMLongPressDragCellCollectionView_Example
//
//  Created by liangdahong on 2020/7/1.
//  Copyright © 2020 ios@liangdahong.com. All rights reserved.
//

import UIKit

class SwiftDemoVC: UIViewController {
    @IBOutlet weak var collectionView: BMLongPressDragCellCollectionView!
    lazy var dataSourceArray: [Int8] = {
        var arr = [Int8]()
        for i in 0...10 {
            arr.append(Int8(i))
        }
        return arr
    }()
}

extension SwiftDemoVC : BMLongPressDragCellCollectionViewDelegate, BMLongPressDragCellCollectionViewDataSource {
    
    func dragCellCollectionView(_ dragCellCollectionView: BMLongPressDragCellCollectionView, newDataArrayAfterMove newDataArray: [Any]?) {
        if let arr = newDataArray as? [Int8] {
            dataSourceArray = arr
        }
    }

    func dataSource(with dragCellCollectionView: BMLongPressDragCellCollectionView) -> [Any]? {
        return dataSourceArray
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSourceArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let num = dataSourceArray[indexPath.item]
        if num%2 == 0 {
            let cell = SwiftDemoCollectionViewCell.bm_collectionViewCellFromAlloc(with: collectionView, for: indexPath)
            if let cell1 = cell {
                cell1.desc = String(dataSourceArray[indexPath.item])
                return cell1
            }
        } else {
            let cell = SwiftDemoXibCollectionViewCell.bm_collectionViewCellFromNib(with: collectionView, for: indexPath)
            if let cell1 = cell {
                return cell1
            }
        }
        return UICollectionViewCell()
    }
}
