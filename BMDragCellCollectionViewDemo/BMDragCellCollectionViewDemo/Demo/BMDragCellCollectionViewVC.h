//
//  BMDragCellCollectionViewVC.h
//  BMDragCellCollectionViewDemo
//
//  Created by __liangdahong on 2017/7/21.
//  Copyright © 2017年 http://idhong.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BMDragCellCollectionViewVC : UIViewController

@property (strong, nonatomic) NSMutableArray *dataSource;
@property (nonatomic, assign) UICollectionViewScrollDirection collectionViewScrollDirection;

@end
