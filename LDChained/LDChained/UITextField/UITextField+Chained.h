//
//  UITextField+Chained.h
//  LDChained
//
//  Created by Daredos on 16/7/5.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDDefinition.h"

@interface UITextField (Chained)

kPropertyView(UITextField, NSTextAlignment, textAlignment);
kPropertyView(UITextField, UITextBorderStyle, borderStyle);
kPropertyView(UITextField, BOOL, clearsOnBeginEditing);
kPropertyView(UITextField, BOOL, adjustsFontSizeToFitWidth);
kPropertyView(UITextField, CGFloat, minimumFontSize);
kPropertyView(UITextField, BOOL, allowsEditingTextAttributes);
kPropertyView(UITextField, UITextFieldViewMode, clearButtonMode);
kPropertyView(UITextField, UITextFieldViewMode, leftViewMode);
kPropertyView(UITextField, UITextFieldViewMode, rightViewMode);
kPropertyView(UITextField, BOOL, clearsOnInsertion);

kPropertyViewObject(UITextField, NSString, text);
kPropertyViewObject(UITextField, NSAttributedString, attributedText);
kPropertyViewObject(UITextField, UIColor, textColor);
kPropertyViewObject(UITextField, UIFont, font);
kPropertyViewObject(UITextField, NSString, placeholder);
kPropertyViewObject(UITextField, NSAttributedString, attributedPlaceholder);
kPropertyViewObject(UITextField, UIImage, background);
kPropertyViewObject(UITextField, UIImage, disabledBackground);
kPropertyViewObject(UITextField, UIView, leftView);
kPropertyViewObject(UITextField, UIView, rightView);
kPropertyViewObject(UITextField, UIView, inputView);
kPropertyViewObject(UITextField, UIView, inputAccessoryView);

@end
