//
//  UILabel+Chained.h
//  LDChained
//
//  Created by Daredos on 16/7/4.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDCollocationLabelMaker.h"

typedef void (^LDCollocationMakerLabelBlock)(LDCollocationLabelMaker *make);

@interface UILabel (Chained)

- (void)ld_makeCollocationLabel:(LDCollocationMakerLabelBlock)block;

@end
