//
//  SwiftDemoVC.swift
//  BMLongPressDragCellCollectionView_Example
//
//  Created by liangdahong on 2020/7/1.
//  Copyright © 2020 ios@liangdahong.com. All rights reserved.
//

import UIKit



// ---------------------------------------------------------
// MARK: - SwiftDemoVC
// ---------------------------------------------------------
class SwiftDemoVC: UIViewController {
    
    @IBOutlet weak var collectionView: BMLongPressDragCellCollectionView!
    var dataSourceArray = [(1...10).map { $0 }]
}



// ---------------------------------------------------------
// MARK: - BMLongPressDragCellCollectionViewDataSource
// ---------------------------------------------------------

extension SwiftDemoVC : BMLongPressDragCellCollectionViewDataSource {
    
    func dataSource(with dragCellCollectionView: BMLongPressDragCellCollectionView) -> [[Any]]? {
        dataSourceArray
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        dataSourceArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSourceArray[section].count
    }
}



// ---------------------------------------------------------
// MARK: - BMLongPressDragCellCollectionViewDelegate
// ---------------------------------------------------------

extension SwiftDemoVC : BMLongPressDragCellCollectionViewDelegate {
    
    func dragCellCollectionView(_ dragCellCollectionView: BMLongPressDragCellCollectionView, newDataArrayAfterMove newDataArray: [[Any]]?) {
        if let arr = newDataArray as? [[Int]] {
            dataSourceArray = arr
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = SwiftDemoCollectionViewCell.bm_collectionViewCellFromAlloc(with: collectionView, for: indexPath)
        if let cell1 = cell {
            let num = dataSourceArray[indexPath.section][indexPath.item]
            cell1.desc = "\(num)"
            return cell1
        }
        return UICollectionViewCell()
    }
}
