//
//  UITableViewCell+BMReusable.h
//  BMTemplateLayoutCellDemo
//
//  Created by __liangdahong on 2017/8/14.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (BMReusable)

+ (instancetype)bm_cellWithTableView:(UITableView *)tableView;

@end
