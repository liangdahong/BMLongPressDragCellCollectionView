//
//  UIButton+Chained.h
//  LDChained
//
//  Created by Daredos on 16/7/5.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDDefinition.h"

@interface UIButton (Chained)

kPropertyView(UIButton, UIEdgeInsets, contentEdgeInsets);
kPropertyView(UIButton, UIEdgeInsets, titleEdgeInsets);
kPropertyView(UIButton, BOOL, reversesTitleShadowWhenHighlighted);
kPropertyView(UIButton, UIEdgeInsets, imageEdgeInsets);
kPropertyView(UIButton, BOOL, adjustsImageWhenHighlighted);
kPropertyView(UIButton, BOOL, adjustsImageWhenDisabled);
kPropertyView(UIButton, BOOL, showsTouchWhenHighlighted);
kPropertyView(UIButton, NSLineBreakMode, lineBreakMode) NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;
kPropertyView(UIButton, CGSize, titleShadowOffset) NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;
kPropertyViewObject(UIButton, UIColor, tintColor);
kPropertyViewObject(UIButton, UIFont, font) NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;

@end
