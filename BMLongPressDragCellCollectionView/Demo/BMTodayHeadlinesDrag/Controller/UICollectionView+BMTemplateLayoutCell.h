//
//  UICollectionView+BMTemplateLayoutCell.h
//  BMTemplateLayoutCellDemo
//
//  Created by ___liangdahong on 2017/9/7.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UICollectionViewTemplateLayoutCellBlock)(__kindof UICollectionViewCell *cell);

@interface UICollectionView (BMTemplateLayoutCell)

- (CGSize)bm_sizeForWithCellIdentifier:(NSString *)identifier cacheByIndexPath:(NSIndexPath *)indexPath configuration:(UICollectionViewTemplateLayoutCellBlock)configuration;

@end
