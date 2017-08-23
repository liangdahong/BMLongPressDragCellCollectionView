//
//  BMAlipayCell.m
//  BMDragCellCollectionViewDemo
//
//  Created by __liangdahong on 2017/7/25.
//  Copyright © 2017年 http://idhong.com. All rights reserved.
//

#import "BMAlipayCell.h"

@interface BMAlipayCell ()

@property (weak, nonatomic) IBOutlet UIView *myBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@end


@implementation BMAlipayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.myBackgroundView.layer.cornerRadius = 10;
    self.myBackgroundView.layer.masksToBounds = YES;
}

- (void)setModel:(BMAlipayModel *)model {
    if (model == _model) {
        return;
    }
    _model = model;
    self.nameLabel.text = model.title;
    self.iconImageView.image = [UIImage imageNamed:model.iconName];
}

@end
