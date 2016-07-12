//
//  UIView+Chained.h
//  LDChained
//
//  Created by Daredos on 16/7/4.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDDefinition.h"

@interface UIView (Chained)

kPropertyView(UIView, BOOL, userInteractionEnabled);
kPropertyView(UIView, NSInteger, tag);
kPropertyView(UIView, UISemanticContentAttribute, semanticContentAttribute) NS_AVAILABLE_IOS(9_0);

kPropertyView(UIView, CGRect, frame);
kPropertyView(UIView, CGRect, bounds);
kPropertyView(UIView, CGPoint, center);
kPropertyView(UIView, CGAffineTransform, transform);

kPropertyView(UIView, CGFloat, contentScaleFactor) NS_AVAILABLE_IOS(4_0);
kPropertyView(UIView, BOOL, multipleTouchEnabled);
kPropertyView(UIView, BOOL, exclusiveTouch);
kPropertyView(UIView, BOOL, autoresizesSubviews);
kPropertyView(UIView, UIViewAutoresizing, autoresizingMask);

kPropertyView(UIView, UIEdgeInsets, layoutMargins);
kPropertyView(UIView, BOOL, preservesSuperviewLayoutMargins)NS_AVAILABLE_IOS(8_0);

kPropertyView(UIView, BOOL, clipsToBounds);
kPropertyView(UIView, CGFloat, alpha);
kPropertyView(UIView, BOOL, opaque);

kPropertyView(UIView, BOOL, clearsContextBeforeDrawing);
kPropertyView(UIView, BOOL, hidden);
kPropertyView(UIView, UIViewContentMode, contentMode);
kPropertyView(UIView, CGRect, contentStretch) NS_DEPRECATED_IOS(3_0,6_0) __TVOS_PROHIBITED;

kPropertyView(UIView, UIViewTintAdjustmentMode, tintAdjustmentMode) NS_AVAILABLE_IOS(7_0);
kPropertyView(UIView, BOOL, translatesAutoresizingMaskIntoConstraints) NS_AVAILABLE_IOS(6_0);;

kPropertyViewObject(UIView, UIColor, backgroundColor) UI_APPEARANCE_SELECTOR;
kPropertyViewObject(UIView, UIView, maskView)NS_AVAILABLE_IOS(8_0);
kPropertyViewObject(UIView, UIColor, tintColor)  NS_AVAILABLE_IOS(7_0);

@property (copy, nonatomic, readonly, getter=ld_x) UIView * (^x_block)(CGFloat x);
@property (copy, nonatomic, readonly, getter=ld_y) UIView * (^y_block)(CGFloat y);
@property (copy, nonatomic, readonly, getter=ld_width)  UIView * (^width_block)(CGFloat width);
@property (copy, nonatomic, readonly, getter=ld_height) UIView * (^height_block)(CGFloat height);
@property (copy, nonatomic, readonly, getter=ld_origin) UIView * (^origin_block)(CGPoint origin);
@property (copy, nonatomic, readonly, getter=ld_size)   UIView * (^size_block)(CGSize size);

#pragma mark - 辅助方法

- (instancetype)_;
- (instancetype)with;
- (instancetype)and;
- (instancetype)stop;
- (instancetype)end

@end
