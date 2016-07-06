//
//  UITableViewCell+Chained.m
//  LDChained
//
//  Created by Daredos on 16/7/6.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "UITableViewCell+Chained.h"

@implementation UITableViewCell (Chained)

kImplementViewObject(UITableViewCell, UIView, backgroundView);
kImplementViewObject(UITableViewCell, UIView, selectedBackgroundView);
kImplementViewObject(UITableViewCell, UIView, multipleSelectionBackgroundView);

kImplementView(UITableViewCell, UITableViewCellSelectionStyle, selectionStyle);
kImplementView(UITableViewCell, BOOL, selected);
kImplementView(UITableViewCell, BOOL, highlighted);
kImplementView(UITableViewCell, BOOL, showsReorderControl);
kImplementView(UITableViewCell, BOOL, shouldIndentWhileEditing);
kImplementView(UITableViewCell, UITableViewCellAccessoryType, accessoryType);

kImplementViewObject(UITableViewCell, UIView, accessoryView);

kImplementView(UITableViewCell, UITableViewCellAccessoryType, editingAccessoryType);

kImplementViewObject(UITableViewCell, UIView, editingAccessoryView);

kImplementView(UITableViewCell, NSInteger, indentationLevel);
kImplementView(UITableViewCell, CGFloat, indentationWidth);
kImplementView(UITableViewCell, UIEdgeInsets, separatorInset);
kImplementView(UITableViewCell, BOOL, editing);
kImplementView(UITableViewCell, BOOL, focusStyle);

kImplementViewObject(UITableViewCell, NSString, text);
kImplementViewObject(UITableViewCell, UIFont, font);

kImplementView(UITableViewCell, NSTextAlignment, textAlignment);
kImplementView(UITableViewCell, NSLineBreakMode, lineBreakMode);

kImplementViewObject(UITableViewCell, UIColor, textColor);
kImplementViewObject(UITableViewCell, UIColor, selectedTextColor);
kImplementViewObject(UITableViewCell, UIImage, image);
kImplementViewObject(UITableViewCell, UIImage, selectedImage);

kImplementView(UITableViewCell, BOOL, hidesAccessoryWhenEditing);
kImplementView(UITableViewCell, id, target);
kImplementView(UITableViewCell, SEL, editAction);
kImplementView(UITableViewCell, SEL, accessoryAction);


@end
