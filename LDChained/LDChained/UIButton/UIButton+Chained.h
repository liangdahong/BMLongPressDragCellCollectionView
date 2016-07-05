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

#pragma mark - 属性方法

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

#pragma mark - 其他配置方法

@property (copy, nonatomic, readonly, getter=ld_title) UIButton *(^title_block)(NSString *title, UIControlState state);
@property (copy, nonatomic, readonly, getter=ld_titleColor) UIButton *(^titleColor_block)(UIColor *titleColor, UIControlState state);
@property (copy, nonatomic, readonly, getter=ld_titleShadowColor) UIButton *(^titleShadowColor_block)(UIColor *titleShadowColor, UIControlState state);
@property (copy, nonatomic, readonly, getter=ld_image) UIButton *(^image_block)(UIImage *image, UIControlState state);
@property (copy, nonatomic, readonly, getter=ld_backgroundImage) UIButton *(^backgroundImage_block)(UIImage *backgroundImage, UIControlState state) UI_APPEARANCE_SELECTOR;
@property (copy, nonatomic, readonly, getter=ld_attributedTitle) UIButton *(^attributedTitle_block)(NSAttributedString *attributedTitle, UIControlState state) NS_AVAILABLE_IOS(6_0);;

@end
