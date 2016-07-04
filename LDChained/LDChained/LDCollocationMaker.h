//
//  LDCollocationMaker.h
//  LDChained
//
//  Created by Daredos on 16/7/4.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class LDCollocationMaker;

typedef LDCollocationMaker *(^LDCollocationMakerTagBlock)(NSInteger tag);
typedef LDCollocationMaker *(^LDCollocationMakerFrameBlock)(CGRect frame);
typedef LDCollocationMaker *(^LDCollocationMakerBackgroundColorBlock)(UIColor *color);
typedef LDCollocationMaker *(^LDCollocationMakerBoundsBlock)(CGRect bounds);

typedef LDCollocationMaker *(^LDCollocationMakerCenterBlock)(CGPoint center);
typedef LDCollocationMaker *(^LDCollocationMakerTransformBlock)(CGAffineTransform transform);
typedef LDCollocationMaker *(^LDCollocationMakerContentScaleFactorBlock)(CGFloat contentScaleFactor);
typedef LDCollocationMaker *(^LDCollocationMakerMultipleTouchEnabledBlock)(BOOL multipleTouchEnabled);
typedef LDCollocationMaker *(^LDCollocationMakerExclusiveTouchBlock)(BOOL exclusiveTouch);


@interface LDCollocationMaker : NSObject

@property (strong, nonatomic) UIView *view;

@property (copy, nonatomic, readonly) LDCollocationMakerTagBlock tagBlock;
@property (copy, nonatomic, readonly) LDCollocationMakerFrameBlock frameBlock;
@property (copy, nonatomic, readonly) LDCollocationMakerBoundsBlock boundsBlock;

@property (copy, nonatomic, readonly) LDCollocationMakerCenterBlock centerBlock;
@property (copy, nonatomic, readonly) LDCollocationMakerTransformBlock transformBlock;
@property (copy, nonatomic, readonly) LDCollocationMakerContentScaleFactorBlock scaleFactorBlock;
@property (copy, nonatomic, readonly) LDCollocationMakerMultipleTouchEnabledBlock multipleTouchEnabledBlock;
@property (copy, nonatomic, readonly) LDCollocationMakerExclusiveTouchBlock exclusiveTouchBlock;

@property (copy, nonatomic, readonly) LDCollocationMakerBackgroundColorBlock backgroundColorBlock;

@property (strong, nonatomic, readonly) LDCollocationMaker *and;
@property (strong, nonatomic, readonly) LDCollocationMaker *with;

@end
