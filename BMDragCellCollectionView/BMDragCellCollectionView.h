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

/**
 BMDragCollectionViewDataSource 协议
 */
@protocol BMDragCollectionViewDataSource <UICollectionViewDataSource>

@required

/**
 获取数据源（内部会做合适的更新数据源处理，必须实现）

 @param dragCellCollectionView dragCellCollectionView
 @return 返回数据源
 */
- (NSArray *)dataSourceWithDragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView;

@end

/**
 BMDragCellCollectionViewDelegate 协议
 */
@protocol BMDragCellCollectionViewDelegate <UICollectionViewDelegate>

@required

/**
 动画和移动完成时（这里会返回更新后的数据源，请在此代理保存数据源，必须实现）

 @param dragCellCollectionView dragCellCollectionView
 @param newDataArray 新的数据源，建议保存。
 */
- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(NSArray *)newDataArray;

@optional

/**
 将要开始拖拽时，询问此cell是否可以拖拽

 @param dragCellCollectionView dragCellCollectionView
 @param indexPath indexPath
 @return YES: 正常拖拽和移动 NO:此cell无法移动，如：增加按钮等
 */
- (BOOL)dragCellCollectionViewShouldBeginMove:(BMDragCellCollectionView *)dragCellCollectionView indexPath:(NSIndexPath *)indexPath;

/**
 将要交换时，询问是否可以交换

 @param dragCellCollectionView dragCellCollectionView
 @param sourceIndexPath 源IndexPath
 @param destinationIndexPath 新位置IndexPath
 @return YES: 正常拖拽和移动 NO:此cell无法移动，如：增加按钮等
 */
- (BOOL)dragCellCollectionViewShouldBeginExchange:(BMDragCellCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;

/**
 拖拽结束（已经停止移动时调用）

 @param dragCellCollectionView dragCellCollectionView
 */
- (void)dragCellCollectionViewDidEndDrag:(BMDragCellCollectionView *)dragCellCollectionView;

@end

/**
 可以长按拖拽Cell的UICollectionView
 */
@interface BMDragCellCollectionView : UICollectionView

@property (nonatomic, weak) id<BMDragCellCollectionViewDelegate> delegate; ///< 代理

@property (nonatomic, weak) id<BMDragCollectionViewDataSource> dataSource; ///< 数据源代理

/**
 长按触发时间，默认是0.5秒，建议根据实际情况设值
 */
@property (nonatomic, assign) NSTimeInterval minimumPressDuration;

/**
 是否可以拖拽 默认为YES,
 如果设置为NO，BMDragCellCollectionView 将失去长按拖拽功能和UICollectionView一样
 */
@property (nonatomic, assign, getter=isCanDrag) BOOL canDrag;

@end
