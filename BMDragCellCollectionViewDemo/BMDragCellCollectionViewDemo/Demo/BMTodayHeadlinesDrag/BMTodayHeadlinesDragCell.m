
//
//  BMTodayHeadlinesDragCell.m
//  TodayHeadlinesDrag
//
//  Created by __liangdahong on 2017/7/23.
//  Copyright © 2017年 http://idhong.com. All rights reserved.
//

#import "BMTodayHeadlinesDragCell.h"
#import "BMTodayHeadlinesDragModel.h"

@interface BMTodayHeadlinesDragCell ()

@property (weak, nonatomic) IBOutlet UIView *mybackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation BMTodayHeadlinesDragCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.titleLabel.font = [UIFont systemFontOfSize:13];
    self.mybackgroundView.layer.cornerRadius = 8.0;
    self.mybackgroundView.layer.borderColor = [UIColor grayColor].CGColor;
    self.mybackgroundView.layer.borderWidth = 1.0;
}

- (void)setTodayHeadlinesDragModel:(BMTodayHeadlinesDragModel *)todayHeadlinesDragModel {
    _todayHeadlinesDragModel = todayHeadlinesDragModel;
    self.titleLabel.text = todayHeadlinesDragModel.title;
}

@end
