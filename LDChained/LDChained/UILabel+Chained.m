//
//  UILabel+Chained.m
//  LDChained
//
//  Created by Daredos on 16/7/4.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "UILabel+Chained.h"

@implementation UILabel (Chained)

- (void)ld_makeCollocationLabel:(LDCollocationMakerLabelBlock)block {
    
    LDCollocationLabelMaker *make = [[LDCollocationLabelMaker alloc] init];
    make.view = self;
    block ? block(make) : nil;
}

@end
