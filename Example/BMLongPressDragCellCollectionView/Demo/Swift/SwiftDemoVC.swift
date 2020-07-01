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
    lazy var dataSourceArray: [String] = {
        var arr = [String]()
        for i in 0...10 {
            arr.append(String(i))
        }
        return arr
    }()
}

extension SwiftDemoVC : BMLongPressDragCellCollectionViewDelegate, BMLongPressDragCellCollectionViewDataSource {
    func dragCellCollectionView(_ dragCellCollectionView: BMLongPressDragCellCollectionView, newDataArrayAfterMove newDataArray: [Any]?) {
        if let arr = newDataArray as? [String] {
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
        let cell = SwiftDemoCollectionViewCell.bm_collectionViewCellFromAlloc(with: collectionView, for: indexPath)
        if let cell1 = cell {
            cell1.desc = dataSourceArray[indexPath.item]
            return cell1
        }
        return UICollectionViewCell()
    }
}
