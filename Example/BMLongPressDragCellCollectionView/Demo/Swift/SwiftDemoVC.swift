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
    var dataSourceArray = [(1...100).map { $0 }]
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
        dataSourceArray = newDataArray as! [[Int]]
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = SwiftDemoCollectionViewCell.bm_collectionViewCellFromAlloc(with: collectionView, for: indexPath)!
        let num = dataSourceArray[indexPath.section][indexPath.item]
        cell.desc = "\(num)"
        return cell
    }
}
