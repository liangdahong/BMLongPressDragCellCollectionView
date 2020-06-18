//
//  BMTouTiaoCell.h
//  TodayHeadlinesDrag
//
//  Created by __liangdahong on 2017/7/23.
//  Copyright © 2017年 https://liangdahong.com All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMTouTiaoModel;

typedef void(^BMTouTiaoCellBlock)(UICollectionViewCell *cell);

@interface BMTouTiaoCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (nonatomic, copy) BMTouTiaoCellBlock block; ///< block

@end
