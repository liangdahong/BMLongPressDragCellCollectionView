//
//  BMAlipayCell.m
//  BMDragCellCollectionViewDemo
//
//  Created by __liangdahong on 2017/7/25.
//  Copyright © 2017年 http://idhong.com. All rights reserved.
//

#import "BMAlipayCell.h"

@implementation BMAlipayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.layer.cornerRadius = 10;
    self.titleLabel.layer.masksToBounds = YES;

}

@end
