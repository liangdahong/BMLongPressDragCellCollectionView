//
//  UIImageView+Chained.m
//  LDChained
//
//  Created by Daredos on 16/7/5.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "UIImageView+Chained.h"

@implementation UIImageView (Chained)

kImplementView(UIImageView, BOOL, userInteractionEnabled);
kImplementView(UIImageView, BOOL, highlighted);
kImplementView(UIImageView, NSTimeInterval, animationDuration);
kImplementView(UIImageView, NSInteger, animationRepeatCount);
kImplementView(UIImageView, BOOL, adjustsImageWhenAncestorFocused);

kImplementViewObject(UIImageView, UIColor, tintColor);
kImplementViewObject(UIImageView, UIImage, image);
kImplementViewObject(UIImageView, UIImage, highlightedImage);
kImplementViewObject(UIImageView, NSArray<UIImage *>, animationImages);
kImplementViewObject(UIImageView, NSArray<UIImage *>, highlightedAnimationImages);

@end
