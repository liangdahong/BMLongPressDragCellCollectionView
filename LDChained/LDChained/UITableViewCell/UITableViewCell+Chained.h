//
//  UITableViewCell+Chained.h
//  LDChained
//
//  Created by Daredos on 16/7/6.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDDefinition.h"

@interface UITableViewCell (Chained)

kPropertyViewObject(UITableViewCell, UIView, backgroundView);
kPropertyViewObject(UITableViewCell, UIView, selectedBackgroundView);
kPropertyViewObject(UITableViewCell, UIView, multipleSelectionBackgroundView) NS_AVAILABLE_IOS(5_0);

kPropertyView(UITableViewCell, UITableViewCellSelectionStyle, selectionStyle);
kPropertyView(UITableViewCell, BOOL, selected);
kPropertyView(UITableViewCell, BOOL, highlighted);
kPropertyView(UITableViewCell, BOOL, showsReorderControl);
kPropertyView(UITableViewCell, BOOL, shouldIndentWhileEditing);
kPropertyView(UITableViewCell, UITableViewCellAccessoryType, accessoryType);

kPropertyViewObject(UITableViewCell, UIView, accessoryView);

kPropertyView(UITableViewCell, UITableViewCellAccessoryType, editingAccessoryType);

kPropertyViewObject(UITableViewCell, UIView, editingAccessoryView);

kPropertyView(UITableViewCell, NSInteger, indentationLevel);
kPropertyView(UITableViewCell, CGFloat, indentationWidth);
kPropertyView(UITableViewCell, UIEdgeInsets, separatorInset);
kPropertyView(UITableViewCell, BOOL, editing);
kPropertyView(UITableViewCell, BOOL, focusStyle);

kPropertyViewObject(UITableViewCell, NSString, text) NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;
kPropertyViewObject(UITableViewCell, UIFont, font) NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;

kPropertyView(UITableViewCell, NSTextAlignment, textAlignment) NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;
kPropertyView(UITableViewCell, NSLineBreakMode, lineBreakMode) NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;

kPropertyViewObject(UITableViewCell, UIColor, textColor) NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;
kPropertyViewObject(UITableViewCell, UIColor, selectedTextColor) NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;
kPropertyViewObject(UITableViewCell, UIImage, image) NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;
kPropertyViewObject(UITableViewCell, UIImage, selectedImage) NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;

kPropertyView(UITableViewCell, BOOL, hidesAccessoryWhenEditing) NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;
kPropertyView(UITableViewCell, id, target) NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;
kPropertyView(UITableViewCell, SEL, editAction) NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;
kPropertyView(UITableViewCell, SEL, accessoryAction) NS_DEPRECATED_IOS(2_0, 3_0) __TVOS_PROHIBITED;

@end
