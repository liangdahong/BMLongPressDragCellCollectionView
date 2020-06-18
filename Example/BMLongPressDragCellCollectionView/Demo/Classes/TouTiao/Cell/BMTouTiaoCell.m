
//
//  BMTouTiaoCell.m
//  TodayHeadlinesDrag
//
//  Created by __liangdahong on 2017/7/23.
//  Copyright © 2017年 https://liangdahong.com All rights reserved.
//

#import "BMTouTiaoCell.h"
#import "BMTouTiaoModel.h"

@interface BMTouTiaoCell ()

@property (weak, nonatomic) IBOutlet UIView *mybackgroundView;

@end

@implementation BMTouTiaoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.mybackgroundView.layer.cornerRadius = 4.0;
    self.mybackgroundView.layer.borderColor = [UIColor grayColor].CGColor;
    self.mybackgroundView.layer.borderWidth = 0.5;
    self.removeButton.layer.cornerRadius = 8.0;
    self.removeButton.layer.masksToBounds = YES;
}

- (IBAction)removeButtonClick {
    !_block ? : _block(self);
}

@end
