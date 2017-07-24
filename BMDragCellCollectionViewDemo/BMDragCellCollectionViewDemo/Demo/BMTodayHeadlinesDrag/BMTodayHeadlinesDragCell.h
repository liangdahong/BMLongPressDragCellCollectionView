//
//  BMTodayHeadlinesDragCell.h
//  TodayHeadlinesDrag
//
//  Created by __liangdahong on 2017/7/23.
//  Copyright © 2017年 http://idhong.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMTodayHeadlinesDragModel;

@interface BMTodayHeadlinesDragCell : UICollectionViewCell

    @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
    @property (weak, nonatomic) IBOutlet UIButton *removeButton;
    
    @end
