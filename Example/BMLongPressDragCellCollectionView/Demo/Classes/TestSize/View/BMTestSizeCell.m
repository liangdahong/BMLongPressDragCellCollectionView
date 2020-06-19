
//
//  BMTestSizeCell.m
//  BMLongPressDragCellCollectionViewDemo
//
//  Created by __liangdahong on 2017/7/17.
//  Copyright © 2017年 https://liangdahong.com All rights reserved.
//

#import "BMTestSizeCell.h"

@implementation BMTestSizeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.label.textAlignment = NSTextAlignmentCenter;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.333];
    self.layer.cornerRadius = 10;
}

@end
