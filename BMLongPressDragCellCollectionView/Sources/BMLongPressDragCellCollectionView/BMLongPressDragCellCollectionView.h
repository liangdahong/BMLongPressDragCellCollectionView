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
#import "BMLongPressDragCellCollectionViewDelegate.h"
#import "BMLongPressDragCellCollectionViewDataSource.h"

NS_ASSUME_NONNULL_BEGIN

/**
 可以长按拖拽Cell的UICollectionView
 UICollectionView can grow by drag and drop the Cell
 */
@interface BMLongPressDragCellCollectionView : UICollectionView

@property (nonatomic, weak, nullable) id<BMLongPressDragCellCollectionViewDelegate> delegate; ///< 代理 delegate
@property (nonatomic, weak, nullable) id<BMLongPressDragCellCollectionViewDataSource> dataSource; ///< 数据源代理 dataSource

/**
 长按触发时间，默认是0.5秒，建议根据实际情况设值
 To the triggering time long, the default is 0.5 seconds, set value Suggestions according to the actual situation
 */
@property (nonatomic, assign) NSTimeInterval minimumPressDuration;

/**
 是否可以拖拽 默认为YES,
 If you can drag the default to YES,
 
 如果设置为NO，BMLongPressDragCellCollectionView 将失去长按拖拽功能和UICollectionView一样
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
@property (nonatomic, assign) CGFloat dragCellAlpha;

/**
 拖拽View的背景颜色
 Drag view backgroundColor
 */
@property (nonatomic, strong, nullable) UIColor *dragSnapedViewBackgroundColor;

/**
 移动到指定位置
 To move to the specified location

 @param indexPath 移动到的位置（内部只会处理当前正在拖拽的情况，会把拖拽的Cell 移动到指定位置，建议在停止手势时或者认为适当的时候使用
 ，如：今日头条Demo ）
 */
- (void)dragMoveItemToIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
