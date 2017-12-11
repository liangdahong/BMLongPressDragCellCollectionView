
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

@end

@implementation BMTodayHeadlinesDragCell

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
