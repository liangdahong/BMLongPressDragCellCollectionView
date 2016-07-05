//
//  UILabel+Chained.m
//  LDChained
//
//  Created by Daredos on 16/7/5.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "UILabel+Chained.h"

@implementation UILabel (Chained)

kImplementViewObject(UILabel, NSString, text);
kImplementViewObject(UILabel, UIFont,   font);
kImplementViewObject(UILabel, UIColor,  textColor);
kImplementViewObject(UILabel, UIColor,  shadowColor);
kImplementViewObject(UILabel, NSAttributedString, attributedText);
kImplementViewObject(UILabel, UIColor, highlightedTextColor);

kImplementView(UILabel, CGSize, shadowOffset);
kImplementView(UILabel, NSTextAlignment, textAlignment);
kImplementView(UILabel, NSLineBreakMode, lineBreakMode);
kImplementView(UILabel, BOOL, highlighted);
kImplementView(UILabel, BOOL, userInteractionEnabled);
kImplementView(UILabel, BOOL, enabled);
kImplementView(UILabel, NSInteger, numberOfLines);
kImplementView(UILabel, BOOL, adjustsFontSizeToFitWidth);
kImplementView(UILabel, UIBaselineAdjustment, baselineAdjustment);
kImplementView(UILabel, CGFloat, minimumScaleFactor);
kImplementView(UILabel, BOOL, allowsDefaultTighteningForTruncation);
kImplementView(UILabel, CGFloat, preferredMaxLayoutWidth);
kImplementView(UILabel, CGFloat, minimumFontSize);
kImplementView(UILabel, BOOL, adjustsLetterSpacingToFitWidth);

@end


