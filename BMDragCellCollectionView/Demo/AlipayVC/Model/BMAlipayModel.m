//
//  BMAlipayModel.m
//  BMDragCellCollectionViewDemo
//
//  Created by ___liangdahong on 2017/8/23.
//  Copyright © 2017年 https://liangdahong.com All rights reserved.
//

#import "BMAlipayModel.h"

@implementation BMAlipayModel

+ (instancetype)modelWithTitle:(NSString *)title iconName:(NSString *)iconName {
    BMAlipayModel *model = [self new];
    model.title = title;
    model.iconName = iconName;
    return model;
}

@end
