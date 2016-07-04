//
//  UIView+Chained.h
//  LDChained
//
//  Created by Daredos on 16/7/4.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDCollocationMaker.h"

typedef void(^LDCollocationMakerBlock)(LDCollocationMaker *make);

@interface UIView (Chained)

- (void)ld_makeCollocation:(LDCollocationMakerBlock)block;

@end
