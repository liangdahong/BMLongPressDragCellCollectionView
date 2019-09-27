//
//  BMAlipayModel.h
//  BMLongPressDragCellCollectionViewDemo
//
//  Created by ___liangdahong on 2017/8/23.
//  Copyright © 2017年 https://liangdahong.com All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BMAlipayModel : NSObject

@property (copy, nonatomic) NSString *title; ///< 标题
@property (copy, nonatomic) NSString *iconName; ///< iconName
+ (instancetype)modelWithTitle:(NSString *)title iconName:(NSString *)iconName;

@end
