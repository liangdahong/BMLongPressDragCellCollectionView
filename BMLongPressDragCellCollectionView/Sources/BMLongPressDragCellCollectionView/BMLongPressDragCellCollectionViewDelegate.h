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

@protocol BMLongPressDragCellCollectionViewDelegate <UICollectionViewDelegateFlowLayout>

@required

/**
 Cell 有交换时调用
 
 @param dragCellCollectionView dragCellCollectionView
 @param newDataArray 最新的数据源，需要使用者保存，在拖拽的时候 Cell 已经移动，需保存最新的数据源

 - (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(nullable NSArray *)newDataArray {
    self.dataArray = [newDataArray copy];
 }
 */
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(nullable NSArray *)newDataArray;

@optional

/**
 将要开始拖拽时，询问此位置的 Cell 是否能拖拽
 
 @param dragCellCollectionView dragCellCollectionView
 @param indexPath indexPath
 @return YES: 正常拖拽和移动 NO:此 Cell 不可拖拽，如：增加按钮等。
 */
- (BOOL)dragCellCollectionViewShouldBeginMove:(BMLongPressDragCellCollectionView *)dragCellCollectionView indexPath:(NSIndexPath *)indexPath;

/**
 将要开始拖拽时，向外面获取需要拖拽的 View，如果不实现就内部自动处理。

 @param dragCellCollectionView dragCellCollectionView
 @param indexPath indexPath
 @return dragView
 */
- (UIView *)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView startDragAtIndexPath:(NSIndexPath *)indexPath;

/// 开始拖拽时，让外面的使用者可以对拖拽的 View 做额外操作
/// @param dragCellCollectionView dragCellCollectionView
/// @param dragView dragView
/// @param indexPath indexPath
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView dragView:(UIView *)dragView indexPath:(NSIndexPath *)indexPath;

/// 正在拖拽时
/// @param dragCellCollectionView dragCellCollectionView
/// @param point 手指触摸点对于 collectionView 的位置
/// 可以参考 https://github.com/liangdahong/ToutiaoDemo/blob/master/ToutiaoDemo/Classes/Edit/Controller/BMChannelEditVC.m 的使用
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView changedDragAtPoint:(CGPoint)point;

/// cell 将要交换时，询问是否能交换
/// @param dragCellCollectionView dragCellCollectionView
/// @param sourceIndexPath 原来的 IndexPath
/// @param destinationIndexPath 将要交换的 IndexPath
/// YES: 正常拖拽和移动 NO:此Cell不可拖拽，如：增加按钮等。
- (BOOL)dragCellCollectionViewShouldBeginExchange:(BMLongPressDragCellCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

/// 结束交换时
/// @param dragCellCollectionView dragCellCollectionView
/// @param sourceIndexPath 原来的 IndexPath
/// @param destinationIndexPath 将要交换的 IndexPath
- (void)dragCellCollectionViewShouldEndExchange:(BMLongPressDragCellCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

/// 结束拖拽时
/// @param dragCellCollectionView dragCellCollectionView
/// @param point 手指触摸点对于 collectionView 的位置
/// 可以参考 https://github.com/liangdahong/ToutiaoDemo/blob/master/ToutiaoDemo/Classes/Edit/Controller/BMChannelEditVC.m 的使用
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView endedDragAtPoint:(CGPoint)point;

@end
NS_ASSUME_NONNULL_END
