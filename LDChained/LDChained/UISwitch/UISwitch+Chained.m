//
//  UISwitch+Chained.m
//  LDChained
//
//  Created by Daredos on 16/7/6.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "UISwitch+Chained.h"

@implementation UISwitch (Chained)

kImplementViewObject(UISwitch, UIColor, onTintColor);
kImplementViewObject(UISwitch, UIColor, tintColor);
kImplementViewObject(UISwitch, UIColor, thumbTintColor);
kImplementViewObject(UISwitch, UIImage, onImage);
kImplementViewObject(UISwitch, UIImage, offImage);
kImplementView(UISwitch, BOOL, on);
- (UISwitch *(^)(BOOL, BOOL))ld_onFunc {

    wself(self)
    return ^UISwitch * (BOOL on, BOOL animated) {
        sself(self)
        [self setOn:on animated:animated];
        return self;
    };
}

@end
