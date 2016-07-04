//
//  UIView+Chained.m
//  LDChained
//
//  Created by Daredos on 16/7/4.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "UIView+Chained.h"

@implementation UIView (Chained)

- (void)ld_makeCollocation:(LDCollocationMakerBlock)block {
    LDCollocationMaker *make = [[LDCollocationMaker alloc] init];
    make.view = self;
    block ? block(make) : nil;
}
@end
