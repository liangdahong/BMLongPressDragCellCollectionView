//
//  UIButton+Chained.m
//  LDChained
//
//  Created by Daredos on 16/7/5.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "UIButton+Chained.h"

@implementation UIButton (Chained)

#pragma mark - 属性方法

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

#pragma mark - 其他配置方法

- (UIButton *(^)(NSString *, UIControlState))ld_title {
    
    wself(self)
    return ^UIButton * (NSString *title, UIControlState state) {
        sself(self)
        [self setTitle:title forState:state];
        return self;
    };
}

- (UIButton *(^)(UIColor *, UIControlState))ld_titleColor {
    
    wself(self)
    return ^UIButton * (UIColor *titleColor, UIControlState state) {
        sself(self)
        [self setTitleColor:titleColor forState:state];
        return self;
    };
}

- (UIButton *(^)(UIColor *, UIControlState))ld_titleShadowColor {
    
    wself(self)
    return ^UIButton * (UIColor *titleShadowColor, UIControlState state) {
        sself(self)
        [self setTitleShadowColor:titleShadowColor forState:state];
        return self;
    };
}

- (UIButton *(^)(UIImage *, UIControlState))ld_image {

    wself(self)
    return ^UIButton * (UIImage *image, UIControlState state) {
        sself(self)
        [self setImage:image forState:state];
        return self;
    };
}

- (UIButton *(^)(UIImage *, UIControlState))ld_backgroundImage {
    
    wself(self)
    return ^UIButton * (UIImage *backgroundImage, UIControlState state) {
        sself(self)
        [self setBackgroundImage:backgroundImage forState:state];
        return self;
    };
}

- (UIButton *(^)(NSAttributedString *, UIControlState))ld_attributedTitle {
    
    wself(self)
    return ^UIButton * (NSAttributedString *attributedTitle, UIControlState state) {
        sself(self)
        [self setAttributedTitle:attributedTitle forState:state];
        return self;
    };
}

@end
