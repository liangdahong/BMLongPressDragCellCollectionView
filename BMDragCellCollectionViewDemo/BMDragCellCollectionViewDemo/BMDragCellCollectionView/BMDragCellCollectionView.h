//
//  BMDragCellCollectionView.h
//  BMDragCellCollectionViewDemo
//
//  Created by ___liangdahong on 2017/7/20.
//  Copyright © 2017年 http://idhong.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BMDragCellCollectionView;

@protocol BMDragCollectionViewDataSource <UICollectionViewDataSource>

@required
- (NSArray *)dataSourceWithDragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView;

@end

@protocol BMDragCellCollectionViewDelegate <UICollectionViewDelegate>

@required
- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(NSArray *)newDataArray;

@optional
- (BOOL)dragCellCollectionViewShouldBeginMove:(BMDragCellCollectionView *)dragCellCollectionView indexPath:(NSIndexPath *)indexPath;
- (BOOL)dragCellCollectionViewShouldBeginExchange:(BMDragCellCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
- (void)dragCellCollectionViewDidEndDrag:(BMDragCellCollectionView *)dragCellCollectionView;

@end


@interface BMDragCellCollectionView : UICollectionView

@property (nonatomic, weak) id<BMDragCellCollectionViewDelegate> delegate;
@property (nonatomic, weak) id<BMDragCollectionViewDataSource> dataSource;
@property (nonatomic, assign) NSTimeInterval minimumPressDuration;
@property (nonatomic, assign, getter=isCanDrag) BOOL canDrag;

@end
