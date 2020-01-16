//    MIT License
//
//    Copyright (c) 2019 https://liangdahong.com
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class BMLongPressDragCellCollectionView;

/// BMLongPressDragCellCollectionViewDelegate protocol
@protocol BMLongPressDragCellCollectionViewDelegate <UICollectionViewDelegateFlowLayout>

@required

/**
 Cell 有任何交换时调用
 
 @param dragCellCollectionView dragCellCollectionView
 @param newDataArray 最新的数据源，需要使用者保存，在拖拽的时候 Cell 已经移动，需保存最新的数据源
 
 - (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(nullable NSArray *)newDataArray {
    self.dataArray = [newDataArray copy];
 }
 */
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(nullable NSArray *)newDataArray;

@optional

/**
 将要开始拖拽时，询问此位置的Cell是否可以拖拽
 
 @param dragCellCollectionView dragCellCollectionView
 @param indexPath indexPath
 @return YES: 正常拖拽和移动 NO:此 Cell 不可拖拽，如：增加按钮等。
 */
- (BOOL)dragCellCollectionViewShouldBeginMove:(BMLongPressDragCellCollectionView *)dragCellCollectionView indexPath:(NSIndexPath *)indexPath;

/**
 将要交换时，询问是否可以交换
 Will exchange, asked if they can exchange
 
 @param dragCellCollectionView dragCellCollectionView
 @param sourceIndexPath 原来的IndexPath
 @param destinationIndexPath 将要交换的IndexPath
 @return YES: 正常拖拽和移动 NO:此Cell不可拖拽，如：增加按钮等。
 */
- (BOOL)dragCellCollectionViewShouldBeginExchange:(BMLongPressDragCellCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

/**
 重排完成时
 Rearrangement complete
 
 @param dragCellCollectionView dragCellCollectionView
 */
- (void)dragCellCollectionViewDidEndDrag:(BMLongPressDragCellCollectionView *)dragCellCollectionView;

/**
 开始拖拽时
 Began to drag
 
 @param dragCellCollectionView dragCellCollectionView
 @param point 响应点击
 @param indexPath 响应的indexPath，如果为 nil 说明没有接触到任何 Cell
 */
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView beganDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath;

/**
 拖拽改变时
 Drag and drop to change
 
 @param dragCellCollectionView dragCellCollectionView
 @param point 响应点击
 @param indexPath 响应的indexPath，如果为 nil 说明没有接触到任何 Cell
 */
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView changedDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath;

/**
 结束拖拽时
 End drag
 
 @param dragCellCollectionView dragCellCollectionView
 @param point 响应点
 @param indexPath 响应的indexPath，如果为 nil 说明没有接触到任何 Cell
 */
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView endedDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath;

/**
 结束拖拽时时是否内部自动处理
 If end drag and drop all the internal automatic processing
 
 @param dragCellCollectionView dragCellCollectionView
 @param point 响应点击
 @param section 当前触摸的组，如果是 -1 表示没有接触组
 @param indexPath 响应的indexPath，如果为 nil 说明没有接触到任何 Cell
 @return YES: 内部自动操作 NO:外部处理，内部会保持当前的状态，请注意使用
 */
- (BOOL)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView endedDragAutomaticOperationAtPoint:(CGPoint)point section:(NSInteger)section indexPath:(NSIndexPath *)indexPath;

/**
 开始拖拽时，向外面获取拖拽的View，如果不实现就使用快照功能
 Began to drag and drop, to obtain the drag and drop the View outside, if you don't realize is using the snapshot function
 
 @param dragCellCollectionView dragCellCollectionView
 @param indexPath indexPath
 @return dragView
 */
- (UIView *)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView startDragAtIndexPath:(NSIndexPath *)indexPath;


/**
 让外面的使用者对拖拽的View做额外操作
 To drag the View to do additional operations
 
 @param dragCellCollectionView dragCellCollectionView
 @param dragView dragView
 @param indexPath indexPath
 */
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView dragView:(UIView *)dragView indexPath:(NSIndexPath *)indexPath;

@end
NS_ASSUME_NONNULL_END
