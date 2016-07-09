//
//  UIScrollView+Chained.m
//  LDChained
//
//  Created by Daredos on 16/7/9.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "UIScrollView+Chained.h"

@implementation UIScrollView (Chained)

kImplementView(UIScrollView, CGPoint, contentOffset);
kImplementView(UIScrollView, CGSize, contentSize);
kImplementView(UIScrollView, UIEdgeInsets, contentInset);
kImplementView(UIScrollView, id<UIScrollViewDelegate>, delegate);
kImplementView(UIScrollView, BOOL, directionalLockEnabled);
kImplementView(UIScrollView, BOOL, bounces);
kImplementView(UIScrollView, BOOL, alwaysBounceVertical);
kImplementView(UIScrollView, BOOL, alwaysBounceHorizontal);
kImplementView(UIScrollView, BOOL, pagingEnabled);
kImplementView(UIScrollView, BOOL, scrollEnabled);
kImplementView(UIScrollView, BOOL, showsHorizontalScrollIndicator);
kImplementView(UIScrollView, BOOL, showsVerticalScrollIndicator);
kImplementView(UIScrollView, UIEdgeInsets, scrollIndicatorInsets);
kImplementView(UIScrollView, UIScrollViewIndicatorStyle, indicatorStyle);
kImplementView(UIScrollView, CGFloat, decelerationRate);
kImplementView(UIScrollView, BOOL, delaysContentTouches);
kImplementView(UIScrollView, BOOL, canCancelContentTouches);
kImplementView(UIScrollView, CGFloat, minimumZoomScale);
kImplementView(UIScrollView, CGFloat, maximumZoomScale);
kImplementView(UIScrollView, CGFloat, zoomScale);
kImplementView(UIScrollView, BOOL, bouncesZoom);
kImplementView(UIScrollView, BOOL, scrollsToTop);
kImplementView(UIScrollView, UIScrollViewKeyboardDismissMode, keyboardDismissMode);

@end
