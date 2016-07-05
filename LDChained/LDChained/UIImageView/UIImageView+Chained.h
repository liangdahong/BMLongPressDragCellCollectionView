//
//  UIImageView+Chained.h
//  LDChained
//
//  Created by Daredos on 16/7/5.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDDefinition.h"

@interface UIImageView (Chained)

kPropertyView(UIImageView, BOOL, userInteractionEnabled);
kPropertyView(UIImageView, BOOL, highlighted) NS_AVAILABLE_IOS(3_0);
kPropertyView(UIImageView, NSTimeInterval, animationDuration);
kPropertyView(UIImageView, NSInteger, animationRepeatCount);
kPropertyView(UIImageView, BOOL, adjustsImageWhenAncestorFocused) UIKIT_AVAILABLE_TVOS_ONLY(9_0);;

kPropertyViewObject(UIImageView, UIColor, tintColor);
kPropertyViewObject(UIImageView, UIImage, image);
kPropertyViewObject(UIImageView, UIImage, highlightedImage) NS_AVAILABLE_IOS(3_0);
kPropertyViewObject(UIImageView, NSArray<UIImage *>, animationImages);
kPropertyViewObject(UIImageView, NSArray<UIImage *>, highlightedAnimationImages);

@end
