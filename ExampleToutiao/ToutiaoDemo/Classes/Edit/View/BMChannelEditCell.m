//
//  BMChannelEditCell.m
//  ToutiaoDemo
//
//  Created by ___liangdahong on 2017/12/11.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMChannelEditCell.h"
#import "BMChannelModel.h"

@interface BMChannelEditCell ()

@property (weak, nonatomic) IBOutlet UIView *mybackgroundView;

@end

@implementation BMChannelEditCell

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
