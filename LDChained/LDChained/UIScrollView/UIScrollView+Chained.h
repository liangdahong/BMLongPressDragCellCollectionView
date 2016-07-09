//
//  UIScrollView+Chained.h
//  LDChained
//
//  Created by Daredos on 16/7/9.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDDefinition.h"

@interface UIScrollView (Chained)

kPropertyView(UIScrollView, CGPoint, contentOffset);
kPropertyView(UIScrollView, CGSize, contentSize);
kPropertyView(UIScrollView, UIEdgeInsets, contentInset);
kPropertyView(UIScrollView, id<UIScrollViewDelegate>, delegate);

kPropertyView(UIScrollView, BOOL, directionalLockEnabled);
kPropertyView(UIScrollView, BOOL, bounces);
kPropertyView(UIScrollView, BOOL, alwaysBounceVertical);
kPropertyView(UIScrollView, BOOL, alwaysBounceHorizontal);
kPropertyView(UIScrollView, BOOL, pagingEnabled) __TVOS_PROHIBITED;
kPropertyView(UIScrollView, BOOL, scrollEnabled);
kPropertyView(UIScrollView, BOOL, showsHorizontalScrollIndicator);
kPropertyView(UIScrollView, BOOL, showsVerticalScrollIndicator);
kPropertyView(UIScrollView, UIEdgeInsets, scrollIndicatorInsets);
kPropertyView(UIScrollView, UIScrollViewIndicatorStyle, indicatorStyle);
kPropertyView(UIScrollView, CGFloat, decelerationRate) NS_AVAILABLE_IOS(3_0);
kPropertyView(UIScrollView, BOOL, delaysContentTouches);
kPropertyView(UIScrollView, BOOL, canCancelContentTouches);
kPropertyView(UIScrollView, CGFloat, minimumZoomScale);
kPropertyView(UIScrollView, CGFloat, maximumZoomScale);
kPropertyView(UIScrollView, CGFloat, zoomScale);
kPropertyView(UIScrollView, BOOL, bouncesZoom);
kPropertyView(UIScrollView, BOOL, scrollsToTop);
kPropertyView(UIScrollView, UIScrollViewKeyboardDismissMode, keyboardDismissMode);

@end
