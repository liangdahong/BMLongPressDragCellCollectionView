//
//  BMChannelEditCell.h
//  ToutiaoDemo
//
//  Created by ___liangdahong on 2017/12/11.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMChannelModel;

typedef void(^BMChannelEditCellBlock)(UICollectionViewCell *cell);

@interface BMChannelEditCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (nonatomic, copy) BMChannelEditCellBlock block; ///< block

@end
