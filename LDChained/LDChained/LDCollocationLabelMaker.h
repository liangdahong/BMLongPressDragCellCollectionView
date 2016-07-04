//
//  LDCollocationLabelMaker.h
//  LDChained
//
//  Created by Daredos on 16/7/4.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "LDCollocationMaker.h"
#import <UIKit/UIKit.h>

@class LDCollocationLabelMaker;

typedef LDCollocationLabelMaker *(^LDCollocationMakerBlockTextBlock)(NSString *text);
typedef LDCollocationLabelMaker *(^LDCollocationMakerFontBlock)(UIFont *font);
typedef LDCollocationLabelMaker *(^LDCollocationMakerTextColorBlock)(UIColor *color);
typedef LDCollocationLabelMaker *(^LDCollocationMakerShadowColorBlock)(UIColor *color);
typedef LDCollocationLabelMaker *(^LDCollocationMakerTextAlignmentBlock)(NSTextAlignment textAlignment);

@interface LDCollocationLabelMaker : LDCollocationMaker

@property (copy, nonatomic, readonly) LDCollocationMakerBlockTextBlock textBlock;
@property (copy, nonatomic, readonly) LDCollocationMakerFontBlock fontBlock;
@property (copy, nonatomic, readonly) LDCollocationMakerTextColorBlock textColorBlock;
@property (copy, nonatomic, readonly) LDCollocationMakerShadowColorBlock shadowColorBlock;
@property (copy, nonatomic, readonly) LDCollocationMakerTextAlignmentBlock textAlignmentBlock;

@end
