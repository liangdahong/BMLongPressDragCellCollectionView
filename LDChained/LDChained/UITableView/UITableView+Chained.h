//
//  UITableView+Chained.h
//  LDChained
//
//  Created by Daredos on 16/7/5.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LDDefinition.h"

@interface UITableView (Chained)

kPropertyView(UITableView, CGFloat, rowHeight);
kPropertyView(UITableView, CGFloat, sectionHeaderHeight);
kPropertyView(UITableView, CGFloat, sectionFooterHeight);
kPropertyView(UITableView, CGFloat, estimatedRowHeight) NS_AVAILABLE_IOS(7_0);
kPropertyView(UITableView, CGFloat, estimatedSectionHeaderHeight) NS_AVAILABLE_IOS(7_0);
kPropertyView(UITableView, CGFloat, estimatedSectionFooterHeight) NS_AVAILABLE_IOS(7_0);
kPropertyView(UITableView, UIEdgeInsets, separatorInset);

kPropertyView(UITableView, BOOL, editing);
kPropertyView(UITableView, BOOL, allowsSelection);
kPropertyView(UITableView, BOOL, allowsSelectionDuringEditing);
kPropertyView(UITableView, BOOL, allowsMultipleSelection);
kPropertyView(UITableView, BOOL, allowsMultipleSelectionDuringEditing);

kPropertyView(UITableView, NSInteger, sectionIndexMinimumDisplayRowCount);


kPropertyViewObject(UITableView, UIView, backgroundView);

kPropertyViewObject(UITableView, UIColor, sectionIndexColor);
kPropertyViewObject(UITableView, UIColor, sectionIndexBackgroundColor);
kPropertyViewObject(UITableView, UIColor, sectionIndexTrackingBackgroundColor);

kPropertyView(UITableView, UITableViewCellSeparatorStyle, separatorStyle);
kPropertyView(UITableView, BOOL, remembersLastFocusedIndexPath);
kPropertyView(UITableView, BOOL, cellLayoutMarginsFollowReadableWidth);

kPropertyViewObject(UITableView, UIColor, separatorColor);
kPropertyViewObject(UITableView, UIVisualEffect, separatorEffect) NS_AVAILABLE_IOS(8_0) UI_APPEARANCE_SELECTOR __TVOS_PROHIBITED;
kPropertyViewObject(UITableView, UIView, tableHeaderView);
kPropertyViewObject(UITableView, UIView, tableFooterView);

@end
