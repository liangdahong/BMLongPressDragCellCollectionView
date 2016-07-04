//
//  LDCollocationMaker.m
//  LDChained
//
//  Created by Daredos on 16/7/4.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "LDCollocationMaker.h"

@implementation LDCollocationMaker

- (LDCollocationMakerTagBlock)tagBlock {
    
    LDCollocationMakerTagBlock block = ^LDCollocationMaker * (NSInteger tag){
        self.view.tag = tag;
        return self;
    };
    return block;
}

- (LDCollocationMakerFrameBlock)frameBlock {

    LDCollocationMakerFrameBlock block = ^LDCollocationMaker * (CGRect frame){
        self.view.frame = frame;
        return self;
    };
    return block;
}

- (LDCollocationMakerBoundsBlock)boundsBlock {
    
    LDCollocationMakerBoundsBlock block = ^LDCollocationMaker * (CGRect bounds){
        self.view.bounds = bounds;
        return self;
    };
    return block;
}


- (LDCollocationMakerCenterBlock)centerBlock {

    LDCollocationMakerCenterBlock block = ^LDCollocationMaker * (CGPoint center){
        self.view.center = center;
        return self;
    };
    return block;
}

- (LDCollocationMakerTransformBlock)transformBlock {

    LDCollocationMakerTransformBlock block = ^LDCollocationMaker * (CGAffineTransform transform){
        self.view.transform = transform;
        return self;
    };
    return block;
}

- (LDCollocationMakerContentScaleFactorBlock)scaleFactorBlock {

    LDCollocationMakerContentScaleFactorBlock block = ^LDCollocationMaker * (CGFloat contentScaleFactor){
        self.view.contentScaleFactor = contentScaleFactor;
        return self;
    };
    return block;
}


- (LDCollocationMakerMultipleTouchEnabledBlock)multipleTouchEnabledBlock {
    
    LDCollocationMakerMultipleTouchEnabledBlock block = ^LDCollocationMaker * (BOOL multipleTouchEnabled){
        self.view.multipleTouchEnabled = multipleTouchEnabled;
        return self;
    };
    return block;
}


- (LDCollocationMakerExclusiveTouchBlock)exclusiveTouchBlock {

    LDCollocationMakerExclusiveTouchBlock block = ^LDCollocationMaker * (BOOL exclusiveTouch){
        self.view.exclusiveTouch = exclusiveTouch;
        return self;
    };
    return block;
}


- (LDCollocationMakerBackgroundColorBlock)backgroundColorBlock {

    LDCollocationMakerBackgroundColorBlock block = ^LDCollocationMaker * (UIColor *color){
        self.view.backgroundColor = color;
        return self;
    };
    return block;
}


- (LDCollocationMaker *)and {
    
    return self;
}

- (LDCollocationMaker *)with {
    
    return self;
}


@end
