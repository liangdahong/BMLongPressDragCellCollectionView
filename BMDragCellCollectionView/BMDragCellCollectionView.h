//
//  BMDragCellCollectionView.h
//
//  Copyright © 2017年 https://github.com/asiosldh/BMDragCellCollectionView/ All rights reserved.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <UIKit/UIKit.h>

@class BMDragCellCollectionView;

#pragma mark - BMDragCollectionViewDataSource

/**
 BMDragCollectionViewDataSource 协议
 */
@protocol BMDragCollectionViewDataSource <UICollectionViewDataSource>

@required

/**
 获取数据源（内部会做合适的更新数据源处理，必须实现）
 
 @param dragCellCollectionView dragCellCollectionView
 @return 返回数据源  return self.dataArray;
 */
- (NSArray *)dataSourceWithDragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView;

@end

#pragma mark - BMDragCellCollectionViewDelegate

/**
 BMDragCellCollectionViewDelegate 协议
 */
@protocol BMDragCellCollectionViewDelegate <UICollectionViewDelegateFlowLayout>

@required

/**
 动画和移动完成时（这里会返回更新后的数据源，请在此代理保存数据源，必须实现）
 
 @param dragCellCollectionView dragCellCollectionView
 @param newDataArray 新的数据源，必须保存。 self.dataArray = [newDataArray copy];
 */
- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(NSArray *)newDataArray;

@optional

/**
 将要开始拖拽时，询问此位置的Cell是否可以拖拽
 
 @param dragCellCollectionView dragCellCollectionView
 @param indexPath indexPath
 @return YES: 正常拖拽和移动 NO:此Cell不可拖拽，如：增加按钮等。
 */
- (BOOL)dragCellCollectionViewShouldBeginMove:(BMDragCellCollectionView *)dragCellCollectionView indexPath:(NSIndexPath *)indexPath;

/**
 将要交换时，询问是否可以交换
 
 @param dragCellCollectionView dragCellCollectionView
 @param sourceIndexPath 原来的IndexPath
 @param destinationIndexPath 将要交换的IndexPath
 @return YES: 正常拖拽和移动 NO:此Cell不可拖拽，如：增加按钮等。
 */
- (BOOL)dragCellCollectionViewShouldBeginExchange:(BMDragCellCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

/**
 BMDragCellCollectionView重排完成时
 
 @param dragCellCollectionView dragCellCollectionView
 */
- (void)dragCellCollectionViewDidEndDrag:(BMDragCellCollectionView *)dragCellCollectionView;

/**
 开始拖拽时

 @param dragCellCollectionView dragCellCollectionView
 @param point 响应点击
 @param indexPath 响应的indexPath，如果为 nil 说明没有接触到任何 Cell
 */
- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView beganDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath;

/**
 拖拽改变时

 @param dragCellCollectionView dragCellCollectionView
 @param point 响应点击
 @param indexPath 响应的indexPath，如果为 nil 说明没有接触到任何 Cell
 */
- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView changedDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath;

/**
 结束拖拽时

 @param dragCellCollectionView dragCellCollectionView
 @param point 响应点击
 @param indexPath 响应的indexPath，如果为 nil 说明没有接触到任何 Cell
 */
- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView endedDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath;

/**
 结束拖拽时时是否内部自动处理

 @param dragCellCollectionView dragCellCollectionView
 @param point 响应点击
 @param indexPath 响应的indexPath，如果为 nil 说明没有接触到任何 Cell
 @return YES: 内部自动操作 NO:外部处理，内部会保持当前的状态，请注意使用
 */
- (BOOL)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView endedDragAutomaticOperationAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath;;

@end

#pragma mark - BMDragCellCollectionView

/**
 可以长按拖拽Cell的UICollectionView
 UICollectionView can grow by drag and drop the Cell
 */
@interface BMDragCellCollectionView : UICollectionView

@property (nonatomic, weak) id<BMDragCellCollectionViewDelegate> delegate; ///< 代理 delegate
@property (nonatomic, weak) id<BMDragCollectionViewDataSource> dataSource; ///< 数据源代理 dataSource

/**
 长按触发时间，默认是0.5秒，建议根据实际情况设值
 */
@property (nonatomic, assign) NSTimeInterval minimumPressDuration;

/**
 是否可以拖拽 默认为YES,
 If you can drag the default to YES,
 
 如果设置为NO，BMDragCellCollectionView 将失去长按拖拽功能和UICollectionView一样
 */
@property (nonatomic, assign, getter=isCanDrag) BOOL canDrag;

/**
 长按拖拽时Cell缩放比例 默认是：1.2
 Long by drag and drop the Cell scaling default is: 1.2
 */
@property (nonatomic, assign) CGFloat dragZoomScale;

/**
 拖拽的Cell在拖拽移动时的透明度 默认是： 1.0
 Drag and drop the Cell in drag move when the transparency The default is 1.0
 */
@property (assign, nonatomic) CGFloat dragCellAlpha;

#pragma mark - 待增加的功能

/**
 移动到指定位置

 @param indexPath 移动到的位置（内部只会处理当前正在拖拽的情况，会把拖拽的Cell 移动到指定位置，建议在停止手势时或者认为适当的时候使用
 ，如：今日头条）
 */
- (void)dragMoveItemToIndexPath:(NSIndexPath *)indexPath;

/**
 拖拽的Cell在拖拽移动时是否自动调整到手指中心
 Drag and drop the Cell in the drag when the mobile is automatically adjusted to the fingers
 */
// @property (assign, nonatomic) BOOL fingerCenter;

@end
