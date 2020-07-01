//
//  SwiftDemoCollectionViewCell.swift
//  BMLongPressDragCellCollectionView_Example
//
//  Created by liangdahong on 2020/7/1.
//  Copyright © 2020 ios@liangdahong.com. All rights reserved.
//

import UIKit
import SnapKit

class SwiftDemoCollectionViewCell: UICollectionViewCell {

    var descLabel = UILabel()

    var desc: String? {
        get {
            descLabel.text
        }
        set {
            descLabel.text  = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(descLabel)
        descLabel.backgroundColor = .darkGray
        descLabel.layer.cornerRadius = 20
        descLabel.layer.masksToBounds = true
        descLabel.textAlignment = .center
        descLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(10)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
