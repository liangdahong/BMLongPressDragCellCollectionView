//
//  UISwitch+Chained.h
//  LDChained
//
//  Created by Daredos on 16/7/6.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDDefinition.h"

@interface UISwitch (Chained)

kPropertyViewObject(UISwitch, UIColor, onTintColor) NS_AVAILABLE_IOS(5_0) UI_APPEARANCE_SELECTOR;
kPropertyViewObject(UISwitch, UIColor, tintColor) NS_AVAILABLE_IOS(6_0);
kPropertyViewObject(UISwitch, UIColor, thumbTintColor) NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
kPropertyViewObject(UISwitch, UIImage, onImage) NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
kPropertyViewObject(UISwitch, UIImage, offImage) NS_AVAILABLE_IOS(6_0) UI_APPEARANCE_SELECTOR;
kPropertyView(UISwitch, BOOL, on);

@property (copy, nonatomic, readonly, getter=ld_onFunc) UISwitch *(^onFunc_block)(BOOL on, BOOL animated);

@end
