//
//  UITableView+Chained.m
//  LDChained
//
//  Created by Daredos on 16/7/5.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "UITableView+Chained.h"

@implementation UITableView (Chained)

kImplementView(UITableView, CGFloat, rowHeight);
kImplementView(UITableView, CGFloat, sectionHeaderHeight);
kImplementView(UITableView, CGFloat, sectionFooterHeight);
kImplementView(UITableView, CGFloat, estimatedRowHeight);
kImplementView(UITableView, CGFloat, estimatedSectionHeaderHeight);
kImplementView(UITableView, CGFloat, estimatedSectionFooterHeight);
kImplementView(UITableView, UIEdgeInsets, separatorInset);
kImplementView(UITableView, BOOL, editing);
kImplementView(UITableView, BOOL, allowsSelection);
kImplementView(UITableView, BOOL, allowsSelectionDuringEditing);
kImplementView(UITableView, BOOL, allowsMultipleSelection);
kImplementView(UITableView, BOOL, allowsMultipleSelectionDuringEditing);
kImplementView(UITableView, NSInteger, sectionIndexMinimumDisplayRowCount);
kImplementView(UITableView, UITableViewCellSeparatorStyle, separatorStyle);
kImplementView(UITableView, BOOL, remembersLastFocusedIndexPath);
kImplementView(UITableView, BOOL, cellLayoutMarginsFollowReadableWidth);

kImplementViewObject(UITableView, UIView, backgroundView);
kImplementViewObject(UITableView, UIColor, sectionIndexColor);
kImplementViewObject(UITableView, UIColor, sectionIndexBackgroundColor);
kImplementViewObject(UITableView, UIColor, sectionIndexTrackingBackgroundColor);
kImplementViewObject(UITableView, UIColor, separatorColor);
kImplementViewObject(UITableView, UIVisualEffect, separatorEffect);
kImplementViewObject(UITableView, UIView, tableHeaderView);
kImplementViewObject(UITableView, UIView, tableFooterView);

@end
