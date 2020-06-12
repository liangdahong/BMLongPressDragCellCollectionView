//
//  BMModel.m
//  BMLongPressDragCellCollectionViewDemo
//
//  Created by ___liangdahong on 2017/8/22.
//  Copyright © 2017年 https://liangdahong.com All rights reserved.
//

#import "BMModel.h"

@implementation BMModel

+ (instancetype)modelWithTitle:(NSString *)title selector:(SEL)selector {
    BMModel *model = [self new];
    model.title = title;
    model.selector = selector;
    return model;
}

@end
