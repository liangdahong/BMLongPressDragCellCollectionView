//
//  UITextField+Chained.m
//  LDChained
//
//  Created by Daredos on 16/7/5.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "UITextField+Chained.h"


@implementation UITextField (Chained)

kImplementView(UITextField, NSTextAlignment, textAlignment);
kImplementView(UITextField, UITextBorderStyle, borderStyle);
kImplementView(UITextField, BOOL, clearsOnBeginEditing);
kImplementView(UITextField, BOOL, adjustsFontSizeToFitWidth);
kImplementView(UITextField, CGFloat, minimumFontSize);
kImplementView(UITextField, BOOL, allowsEditingTextAttributes);
kImplementView(UITextField, UITextFieldViewMode, clearButtonMode);
kImplementView(UITextField, UITextFieldViewMode, leftViewMode);
kImplementView(UITextField, UITextFieldViewMode, rightViewMode);
kImplementView(UITextField, BOOL, clearsOnInsertion);

kImplementViewObject(UITextField, NSString, text);
kImplementViewObject(UITextField, NSAttributedString, attributedText);
kImplementViewObject(UITextField, UIColor, textColor);
kImplementViewObject(UITextField, UIFont, font);
kImplementViewObject(UITextField, NSString, placeholder);
kImplementViewObject(UITextField, NSAttributedString, attributedPlaceholder);
kImplementViewObject(UITextField, UIImage, background);
kImplementViewObject(UITextField, UIImage, disabledBackground);
kImplementViewObject(UITextField, UIView, leftView);
kImplementViewObject(UITextField, UIView, rightView);
kImplementViewObject(UITextField, UIView, inputView);
kImplementViewObject(UITextField, UIView, inputAccessoryView);

@end
