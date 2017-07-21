//
//  XWDragCellCollectionView.h
//  PanCollectionView
//
//  Created by YouLoft_MacMini on 16/1/4.
//  Copyright © 2016年 wazrx. All rights reserved.
// 可拖动cell重新排布的collectionView
/**如何使用：
    1、继承与XWDragCellCollectionView；
    2、实现必须实现的DataSouce代理方法：（在该方法中返回整个CollectionView的数据数组用于重排）
    - (NSArray *)dataSourceArrayOfCollectionView:(XWDragCellCollectionView *)collectionView;
    3、实现必须实现的一个Delegate代理方法：（在该方法中将重拍好的新数据源设为当前数据源）(例如 :_data = newDataArray)
    - (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray;
 */



#import <UIKit/UIKit.h>
@class XWDragCellCollectionView;

@protocol  XWDragCellCollectionViewDelegate<UICollectionViewDelegate>

@required
/**
 *  当数据源更新的到时候调用，必须实现，需将新的数据源设置为当前tableView的数据源(例如 :_data = newDataArray)
 *  @param newDataArray   更新后的数据源
 */
- (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray;

@optional

/**
 *  某些indexPaths是不需要交换和晃动的，常见的比如添加按钮等，传入这些indexPaths数组排出交换和抖动操作
 *  @param return   需要排除的indexPath数组，该数组中的indexPath无法长按抖动和交换
 */
- (NSArray<NSIndexPath *> *)excludeIndexPathsWhenMoveDragCellCollectionView:(XWDragCellCollectionView *)collectionView;

/**
 *  某个cell将要开始移动的时候调用
 *  @param indexPath      该cell当前的indexPath
 */
- (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView cellWillBeginMoveAtIndexPath:(NSIndexPath *)indexPath;
/**
 *  某个cell正在移动的时候
 */
- (void)dragCellCollectionViewCellisMoving:(XWDragCellCollectionView *)collectionView;
/**
 *  cell移动完毕，并成功移动到新位置的时候调用
 */
- (void)dragCellCollectionViewCellEndMoving:(XWDragCellCollectionView *)collectionView;
/**
 *  成功交换了位置的时候调用
 *  @param fromIndexPath    交换cell的起始位置
 *  @param toIndexPath      交换cell的新位置
 */
- (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView moveCellFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath;

@end

@protocol  XWDragCellCollectionViewDataSource<UICollectionViewDataSource>


@required
/**
 *  返回整个CollectionView的数据，必须实现，需根据数据进行移动后的数据重排
 */
- (NSArray *)dataSourceArrayOfCollectionView:(XWDragCellCollectionView *)collectionView;

@end

@interface XWDragCellCollectionView : UICollectionView

@property (nonatomic, assign) id<XWDragCellCollectionViewDelegate> delegate;
@property (nonatomic, assign) id<XWDragCellCollectionViewDataSource> dataSource;

/**长按多少秒触发拖动手势，默认1秒，如果设置为0，表示手指按下去立刻就触发拖动*/
@property (nonatomic, assign) NSTimeInterval minimumPressDuration;
/**是否开启拖动到边缘滚动CollectionView的功能，默认YES*/
@property (nonatomic, assign) BOOL edgeScrollEable;
/**是否开启拖动的时候所有cell抖动的效果，默认YES*/
@property (nonatomic, assign) BOOL shakeWhenMoveing;
/**抖动的等级(1.0f~10.0f)，默认4*/
@property (nonatomic, assign) CGFloat shakeLevel;
/**是否正在编辑模式，调用xwp_enterEditingModel和xw_stopEditingModel会修改该方法的值*/
@property (nonatomic, assign, readonly, getter=isEditing) BOOL editing;

/**进入编辑模式，如果开启抖动会自动持续抖动，且不用长按就能出发拖动*/
- (void)xw_enterEditingModel;

/**退出编辑模式*/
- (void)xw_stopEditingModel;

@end
