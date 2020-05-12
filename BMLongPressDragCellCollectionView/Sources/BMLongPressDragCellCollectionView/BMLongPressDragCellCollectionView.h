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

//    v3.0.6

#import <UIKit/UIKit.h>
#import "BMLongPressDragCellCollectionViewDelegate.h"
#import "BMLongPressDragCellCollectionViewDataSource.h"

NS_ASSUME_NONNULL_BEGIN

/*
 - (NSArray *)dataSourceWithDragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView {
     return self.dataSourceArray;
     // 此协议方法里返回数据源
 }

 - (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(nullable NSArray *)newDataArray {
     self.dataSourceArray = [newDataArray mutableCopy];
     // 此协议方法里保存数据源
 }
 */
/// 可以长按拖拽的 UICollectionView
@interface BMLongPressDragCellCollectionView : UICollectionView

@property (nonatomic, weak, nullable) id<BMLongPressDragCellCollectionViewDelegate> delegate;
@property (nonatomic, weak, nullable) id<BMLongPressDragCellCollectionViewDataSource> dataSource;

/// 长按触发拖拽所需时间，默认是 0.5 秒。
@property (nonatomic, assign) NSTimeInterval minimumPressDuration;
/// 是否可以拖拽 默认为 YES。
@property (nonatomic, assign, getter=isCanDrag) BOOL canDrag;
///  长按拖拽时拖拽中的的 Cell 缩放比例，默认是 1.2 倍。
@property (nonatomic, assign) CGFloat dragZoomScale;
/// 拖拽的 Cell 在拖拽移动时的透明度 默认是： 1.0 不透明。
@property (nonatomic, assign) CGFloat dragCellAlpha;
/// 拖拽到 UICollectionView 边缘时 UICollectionView 的滚动速度
/// 默认为: 8.0f ，建议设置 5.0f 到 15.0f 之间。
@property (nonatomic, assign) CGFloat dragSpeed;
/// 拖拽 View 的背景颜色，默认和被拖拽的 Cell 一样。
@property (nonatomic, strong, nullable) UIColor *dragSnapedViewBackgroundColor;

/// 移动到指定位置
/// @param indexPath 移动到的位置
/// 内部只会处理当前正在拖拽的情况，会把拖拽的 Cell 移动到指定位置，建议在停止手势时或者认为适当的时候使用。
- (void)dragMoveItemToIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
