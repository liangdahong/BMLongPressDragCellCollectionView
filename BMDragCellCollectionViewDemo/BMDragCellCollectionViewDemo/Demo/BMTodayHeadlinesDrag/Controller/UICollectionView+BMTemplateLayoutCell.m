//
//  UICollectionView+BMTemplateLayoutCell.m
//  BMTemplateLayoutCellDemo
//
//  Created by ___liangdahong on 2017/9/7.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "UICollectionView+BMTemplateLayoutCell.h"
#import <objc/runtime.h>

/**
 交换2个方法的调用
 */
void swizzleMethodUICollectionView(Class class, SEL originalSelector, SEL swizzledSelector) {
    // 1.获取旧 Method
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    // 2.获取新 Method
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    // 3.交换方法
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@interface UICollectionView ()

@property (strong, nonatomic, readonly) NSMutableArray <NSMutableArray <NSNumber *>*> *portraitCacheCellHeightIndexPathMutableArray;     ///< 竖屏模式Cell的缓存 arr 使用 IndexPath
@property (strong, nonatomic, readonly) UIView *tempView; ///< tempView

@end

@implementation UICollectionView (BMTemplateLayoutCell)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            @selector(reloadData)
        };
        for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
            SEL originalSelector = selectors[index];
            SEL swizzledSelector = NSSelectorFromString([@"bm_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
            swizzleMethodUICollectionView(self.class, originalSelector, swizzledSelector);
        }
    });
}

- (NSMutableArray<NSMutableArray<NSNumber *> *> *)portraitCacheCellHeightIndexPathMutableArray {
    NSMutableArray<NSMutableArray<NSNumber *> *> *arr = objc_getAssociatedObject(self, _cmd);
    if (!arr) {
        arr = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, arr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return arr;
}

- (void)bm_reloadData {
    [self.portraitCacheCellHeightIndexPathMutableArray removeAllObjects];
    [self bm_reloadData];
}

- (CGSize)bm_sizeForWithCellIdentifier:(NSString *)identifier cacheByIndexPath:(NSIndexPath *)indexPath configuration:(UICollectionViewTemplateLayoutCellBlock)configuration {
    UIView *tempView = objc_getAssociatedObject(self, _cmd);
    if (!tempView) {
        UICollectionViewCell *cell = [self dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        UIView *tempView = [UIView new];
        tempView.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 0);
        cell.frame = CGRectMake(0, 0, CGRectGetWidth(self.frame), 0);
        [tempView addSubview:cell];
        [cell setValue:@"reuseIdentifier" forKey:@"reuseIdentifier"];
        objc_setAssociatedObject(self, _cmd, tempView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    configuration(tempView.subviews[0]);
    [tempView layoutIfNeeded];
    __block CGFloat maxY = 0;
    [((UICollectionViewCell *)tempView.subviews).contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (maxY <  CGRectGetMaxY(obj.frame)) {
            maxY = CGRectGetMaxY(obj.frame);
        }
    }];
    __block CGFloat maxWidth = 0;
    [((UICollectionViewCell *)tempView.subviews).contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (maxWidth <  CGRectGetMaxX(obj.frame)) {
            maxWidth = CGRectGetMaxX(obj.frame);
        }
    }];
    return CGSizeMake(maxWidth, maxY);
}

@end
