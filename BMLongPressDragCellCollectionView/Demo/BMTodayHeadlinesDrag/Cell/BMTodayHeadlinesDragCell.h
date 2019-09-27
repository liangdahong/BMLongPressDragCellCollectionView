//
//  BMTodayHeadlinesDragCell.h
//  TodayHeadlinesDrag
//
//  Created by __liangdahong on 2017/7/23.
//  Copyright © 2017年 https://liangdahong.com All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMTodayHeadlinesDragModel;

typedef void(^BMTodayHeadlinesDragCellBlock)(UICollectionViewCell *cell);


@interface BMTodayHeadlinesDragCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (nonatomic, copy) BMTodayHeadlinesDragCellBlock block; ///< block

@end
