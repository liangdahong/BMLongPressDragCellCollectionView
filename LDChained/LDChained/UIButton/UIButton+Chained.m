//
//  UIButton+Chained.m
//  LDChained
//
//  Created by Daredos on 16/7/5.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "UIButton+Chained.h"

@implementation UIButton (Chained)

kImplementView(UIButton, UIEdgeInsets, contentEdgeInsets);
kImplementView(UIButton, UIEdgeInsets, titleEdgeInsets);
kImplementView(UIButton, BOOL, reversesTitleShadowWhenHighlighted);
kImplementView(UIButton, UIEdgeInsets, imageEdgeInsets);
kImplementView(UIButton, BOOL, adjustsImageWhenHighlighted);
kImplementView(UIButton, BOOL, adjustsImageWhenDisabled);
kImplementView(UIButton, BOOL, showsTouchWhenHighlighted);
kImplementView(UIButton, NSLineBreakMode, lineBreakMode);
kImplementView(UIButton, CGSize, titleShadowOffset);
kImplementViewObject(UIButton, UIColor, tintColor);
kImplementViewObject(UIButton, UIFont, font);

@end
