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
        super.init(frame: frame)
        contentView.addSubview(descLabel)
        descLabel.backgroundColor = .init(red: 0, green: 0, blue: 0, alpha: 0.2)
        descLabel.textAlignment = .center
        descLabel.snp.makeConstraints { (make) in
            make.edges.equalToSuperview().inset(10)
        }
        descLabel.layer.cornerRadius = 15
        descLabel.layer.masksToBounds = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
