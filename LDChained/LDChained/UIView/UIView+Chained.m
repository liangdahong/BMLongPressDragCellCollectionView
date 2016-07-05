//
//  UIView+Chained.m
//  LDChained
//
//  Created by Daredos on 16/7/4.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "UIView+Chained.h"

@implementation UIView (Chained)

kImplementView(UIView, BOOL, userInteractionEnabled);
kImplementView(UIView, NSInteger, tag);
kImplementView(UIView, UISemanticContentAttribute, semanticContentAttribute);

kImplementView(UIView, CGRect, frame);
kImplementView(UIView, CGRect, bounds);
kImplementView(UIView, CGPoint, center);
kImplementView(UIView, CGAffineTransform, transform);

kImplementView(UIView, CGFloat, contentScaleFactor);
kImplementView(UIView, BOOL, multipleTouchEnabled);
kImplementView(UIView, BOOL, exclusiveTouch);
kImplementView(UIView, BOOL, autoresizesSubviews);
kImplementView(UIView, UIViewAutoresizing, autoresizingMask);

kImplementView(UIView, UIEdgeInsets, layoutMargins);
kImplementView(UIView, BOOL, preservesSuperviewLayoutMargins);

kImplementView(UIView, BOOL, clipsToBounds);
kImplementView(UIView, CGFloat, alpha);
kImplementView(UIView, BOOL, opaque);

kImplementView(UIView, BOOL, clearsContextBeforeDrawing);
kImplementView(UIView, BOOL, hidden);
kImplementView(UIView, UIViewContentMode, contentMode);
kImplementView(UIView, CGRect, contentStretch);

kImplementView(UIView, UIViewTintAdjustmentMode, tintAdjustmentMode);
kImplementView(UIView, BOOL, translatesAutoresizingMaskIntoConstraints);

kImplementViewObject(UIView, UIColor, backgroundColor);
kImplementViewObject(UIView, UIView, maskView);
kImplementViewObject(UIView, UIColor, tintColor);

- (instancetype)with {
    
    return self;
}

- (instancetype)and  {
    return self;
}
@end
