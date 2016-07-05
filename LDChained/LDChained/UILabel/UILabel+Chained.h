//
//  UILabel+Chained.h
//  LDChained
//
//  Created by Daredos on 16/7/5.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDDefinition.h"

@interface UILabel (Chained)

kPropertyView(UILabel, CGSize, shadowOffset);
kPropertyView(UILabel, NSTextAlignment, textAlignment);
kPropertyView(UILabel, NSLineBreakMode, lineBreakMode);
kPropertyView(UILabel, BOOL, highlighted);
kPropertyView(UILabel, BOOL, userInteractionEnabled);
kPropertyView(UILabel, BOOL, enabled);
kPropertyView(UILabel, NSInteger, numberOfLines);
kPropertyView(UILabel, BOOL, adjustsFontSizeToFitWidth);
kPropertyView(UILabel, UIBaselineAdjustment, baselineAdjustment);
kPropertyView(UILabel, CGFloat, minimumScaleFactor);
kPropertyView(UILabel, BOOL, allowsDefaultTighteningForTruncation);
kPropertyView(UILabel, CGFloat, preferredMaxLayoutWidth);
kPropertyView(UILabel, CGFloat, minimumFontSize)  NS_DEPRECATED_IOS(2_0, 6_0) __TVOS_PROHIBITED;;
kPropertyView(UILabel, BOOL, adjustsLetterSpacingToFitWidth) NS_DEPRECATED_IOS(6_0,7_0) __TVOS_PROHIBITED;

kPropertyViewObject(UILabel, NSString, text);
kPropertyViewObject(UILabel, UIFont,   font);
kPropertyViewObject(UILabel, UIColor,  textColor);
kPropertyViewObject(UILabel, UIColor,  shadowColor);
kPropertyViewObject(UILabel, NSAttributedString, attributedText);
kPropertyViewObject(UILabel, UIColor, highlightedTextColor);

@end
