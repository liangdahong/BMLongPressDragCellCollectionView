//
//  BMDragCellCollectionView.m
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

#import "BMDragCellCollectionView.h"

typedef NS_ENUM(NSUInteger, BMDragCellCollectionViewScrollDirection) {
    BMDragCellCollectionViewScrollDirectionNone = 0,
    BMDragCellCollectionViewScrollDirectionLeft,
    BMDragCellCollectionViewScrollDirectionRight,
    BMDragCellCollectionViewScrollDirectionUp,
    BMDragCellCollectionViewScrollDirectionDown
};

@interface BMDragCellCollectionView ()

@property (strong, nonatomic) UILongPressGestureRecognizer *longGesture; ///< 长按手势
@property (strong, nonatomic) UIView *snapedView;            ///< 截图快照
@property (strong, nonatomic) CADisplayLink *edgeTimer;      ///< 定时器
@property (strong, nonatomic) NSIndexPath *currentIndexPath; ///< 当前路径
@property (strong, nonatomic) NSIndexPath *oldIndexPath;     ///< 旧的IndexPath
@property (nonatomic, assign) CGPoint oldPoint;              ///< 旧的位置
@property (assign, nonatomic) CGPoint lastPoint;             ///< 最后的触摸点
@property (assign, nonatomic) BOOL isEndDrag;                ///< 是否正在拖动

@end

@implementation BMDragCellCollectionView

@dynamic delegate, dataSource;

#pragma mark -

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initConfiguration];
}

#pragma mark - init

- (instancetype)init {
    if (self = [super init]) {
        [self initConfiguration];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initConfiguration];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (self = [super initWithFrame:frame collectionViewLayout:layout]) {
        [self initConfiguration];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initConfiguration];
    }
    return self;
}

- (void)dealloc {
    [self _stopEdgeTimer];
}

#pragma mark - getters setters

- (void)setCanDrag:(BOOL)canDrag {
    _canDrag = canDrag;
    self.longGesture.enabled = _canDrag;
}

- (void)setMinimumPressDuration:(NSTimeInterval)minimumPressDuration {
    _minimumPressDuration = minimumPressDuration;
    self.longGesture.minimumPressDuration = minimumPressDuration;
}

- (UILongPressGestureRecognizer *)longGesture {
    if (!_longGesture) {
        _longGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handlelongGesture:)];
        _longGesture.minimumPressDuration = _minimumPressDuration;
    }
    return _longGesture;
}

#pragma mark - 私有方法

- (void)initConfiguration {
    _canDrag = YES;
    _minimumPressDuration = .5f;
    [self addGestureRecognizer:self.longGesture];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 10.0) {
        self.prefetchingEnabled = NO;
    }
}

- (UICollectionViewCell *)dequeueReusableCellWithReuseIdentifier:(NSString *)identifier forIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [super dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    // 处理 在间隙间移动的问题
    if (self.isEndDrag) {
        cell.hidden = NO;
    } else {
        if (self.oldIndexPath && self.oldIndexPath.item == indexPath.item && self.oldIndexPath.section == indexPath.section) {
            cell.hidden = YES;
        } else {
            cell.hidden = NO;
        }
    }
    return cell;
}

- (NSIndexPath *)_firstNearlyIndexPath {
    __block CGFloat width = MAXFLOAT;
    __block NSIndexPath *index = nil;
    [[self visibleCells] enumerateObjectsUsingBlock:^(__kindof UICollectionViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGPoint p1 = self.snapedView.center;
        CGPoint p2 = obj.center;
        CGFloat distance = sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2));
        if (distance < width) {
            width = distance;
            index = [self indexPathForCell:obj];
        }
    }];
    if ((index.item == self.oldIndexPath.item) && (index.row == self.oldIndexPath.row)) {
        // 最近的就是隐藏的cell时
        return nil;
    }
    return index;
}

- (BMDragCellCollectionViewScrollDirection)_setScrollDirection {
    if (self.bounds.size.height + self.contentOffset.y - _snapedView.center.y < _snapedView.bounds.size.height / 2 && self.bounds.size.height + self.contentOffset.y < self.contentSize.height) {
        return BMDragCellCollectionViewScrollDirectionDown;
    }
    if (_snapedView.center.y - self.contentOffset.y < _snapedView.bounds.size.height / 2 && self.contentOffset.y > 0) {
        return BMDragCellCollectionViewScrollDirectionUp;
    }
    if (self.bounds.size.width + self.contentOffset.x - _snapedView.center.x < _snapedView.bounds.size.width / 2 && self.bounds.size.width + self.contentOffset.x < self.contentSize.width) {
        return BMDragCellCollectionViewScrollDirectionRight;
    }
    if (_snapedView.center.x - self.contentOffset.x < _snapedView.bounds.size.width / 2 && self.contentOffset.x > 0) {
        return BMDragCellCollectionViewScrollDirectionLeft;
    }
    return BMDragCellCollectionViewScrollDirectionNone;
}

- (void)_updateSourceData {
    // 获取数据源
    NSMutableArray *array = [[self.dataSource dataSourceWithDragCellCollectionView:self] mutableCopy];
    // ==========处理数据
    BOOL dataTypeCheck = ([self numberOfSections] != 1 || ([self  numberOfSections] == 1 && [array[0] isKindOfClass:[NSArray class]]));
    if (dataTypeCheck) {
        for (int i = 0; i < array.count; i ++) {
            [array replaceObjectAtIndex:i withObject:[array[i] mutableCopy]];
        }
    }
    if (_currentIndexPath.section == _oldIndexPath.section) {
        NSMutableArray *orignalSection = dataTypeCheck ? (NSMutableArray *)array[_oldIndexPath.section] : (NSMutableArray *)array;
        if (_currentIndexPath.item > _oldIndexPath.item) {
            for (NSUInteger i = _oldIndexPath.item; i < _currentIndexPath.item ; i ++) {
                [orignalSection exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
            }
        } else {
            for (NSUInteger i = _oldIndexPath.item; i > _currentIndexPath.item ; i --) {
                [orignalSection exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
            }
        }
    } else {
        NSMutableArray *orignalSection = array[_oldIndexPath.section];
        NSMutableArray *currentSection = array[_currentIndexPath.section];
        [currentSection insertObject:orignalSection[_oldIndexPath.item] atIndex:_currentIndexPath.item];
        [orignalSection removeObject:orignalSection[_oldIndexPath.item]];
    }
    // ==========处理数据
    
    // 更新外面的数据源
    [self.delegate dragCellCollectionView:self newDataArrayAfterMove:array];
}

- (void)_setEdgeTimer{
    if (!_edgeTimer) {
        _edgeTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(_edgeScroll)];
        [_edgeTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)_stopEdgeTimer{
    if (_edgeTimer) {
        [_edgeTimer invalidate];
        _edgeTimer = nil;
    }
}

- (void)_edgeScroll {
    BMDragCellCollectionViewScrollDirection scrollDirection = [self _setScrollDirection];
    switch (scrollDirection) {
        case BMDragCellCollectionViewScrollDirectionLeft:{
            //这里的动画必须设为NO
            [self setContentOffset:CGPointMake(self.contentOffset.x - 4, self.contentOffset.y) animated:NO];
            _snapedView.center = CGPointMake(_snapedView.center.x - 4, _snapedView.center.y);
            _lastPoint.x -= 4;
        }
            break;
        case BMDragCellCollectionViewScrollDirectionRight:{
            [self setContentOffset:CGPointMake(self.contentOffset.x + 4, self.contentOffset.y) animated:NO];
            _snapedView.center = CGPointMake(_snapedView.center.x + 4, _snapedView.center.y);
            _lastPoint.x += 4;
        }
            break;
        case BMDragCellCollectionViewScrollDirectionUp:{
            [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y - 4) animated:NO];
            _snapedView.center = CGPointMake(_snapedView.center.x, _snapedView.center.y - 4);
            _lastPoint.y -= 4;
        }
            break;
        case BMDragCellCollectionViewScrollDirectionDown:{
            [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y + 4) animated:NO];
            _snapedView.center = CGPointMake(_snapedView.center.x, _snapedView.center.y + 4);
            _lastPoint.y += 4;
        }
            break;
        default:
            break;
    }
    
    if (scrollDirection != BMDragCellCollectionViewScrollDirectionNone) {
        // 当前手指位置
        _lastPoint = [self.longGesture locationInView:self];
        // 截图视图位置移动
        [UIView animateWithDuration:0.1 animations:^{
            _snapedView.center = _lastPoint;
        }];
        
        NSIndexPath *index = [self _firstNearlyIndexPath];
        if (!index) {
            return;
        }

        if (self.delegate && [self.delegate respondsToSelector:@selector(dragCellCollectionViewShouldBeginExchange:sourceIndexPath:toIndexPath:)]) {
            if (![self.delegate dragCellCollectionViewShouldBeginExchange:self sourceIndexPath:_oldIndexPath toIndexPath:index]) {
                return;
            }
        }
        _currentIndexPath = index;
        self.oldPoint = [self cellForItemAtIndexPath:_currentIndexPath].center;
        [self _updateSourceData];
        
        // 移动 会调用willMoveToIndexPath方法更新数据源
        [self moveItemAtIndexPath:_oldIndexPath toIndexPath:_currentIndexPath];
        
        // 设置移动后的起始indexPath
        _oldIndexPath = _currentIndexPath;
        [self reloadItemsAtIndexPaths:@[_oldIndexPath]];
    }
}

#pragma mark - 事件响应

- (void)handlelongGesture:(UILongPressGestureRecognizer *)longGesture {
    switch (longGesture.state) {
        case UIGestureRecognizerStateBegan:{//手势开始
            // 判断手势落点位置是否在Item上
            _oldIndexPath = [self indexPathForItemAtPoint:[longGesture locationInView:self]];
            // 没有按在cell 上就 break
            if (_oldIndexPath == nil) {
                self.longGesture.enabled = NO;
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    if (_canDrag) {
                        self.longGesture.enabled = YES;
                    }
                });
                break;
            }
            if (self.delegate && [self.delegate respondsToSelector:@selector(dragCellCollectionViewShouldBeginMove:indexPath:)]) {
                if (![self.delegate dragCellCollectionViewShouldBeginMove:self indexPath:_oldIndexPath]) {
                    _oldIndexPath = nil;
                    self.longGesture.enabled = NO;
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        if (_canDrag) {
                            self.longGesture.enabled = YES;
                        }
                    });
                    break;
                }
            }
            self.isEndDrag = NO;
            // 取出正在长按的cell
            UICollectionViewCell *cell = [self cellForItemAtIndexPath:_oldIndexPath];
            self.oldPoint = cell.center;

            // 使用系统截图功能，得到cell的快照view
            _snapedView = [cell snapshotViewAfterScreenUpdates:NO];
            // 设置frame
            _snapedView.frame = cell.frame;
            // 添加到 collectionView 不然无法显示
            [self addSubview:_snapedView];
            
            //截图后隐藏当前cell
            cell.hidden = YES;
            
            // 获取当前触摸的中心点
            CGPoint currentPoint = [longGesture locationInView:self];
            
            // 动画放大和移动到触摸点下面
            [UIView animateWithDuration:0.25 animations:^{
                _snapedView.transform = CGAffineTransformMakeScale(1.2f, 1.2f);
                _snapedView.center = CGPointMake(currentPoint.x, currentPoint.y);
            }];
            // 开启collectionView的边缘自动滚动检测
            [self _setEdgeTimer];
        }
            break;
        case UIGestureRecognizerStateChanged: {
            // 当前手指位置
            _lastPoint = [longGesture locationInView:self];
            // 截图视图位置移动
            [UIView animateWithDuration:0.1 animations:^{
                _snapedView.center = _lastPoint;
            }];
            
            NSIndexPath *index = [self _firstNearlyIndexPath];
            
            // 没有取到或者距离隐藏的最近时就返回
            if (!index) {
                break;
            }
            
            if (self.delegate && [self.delegate respondsToSelector:@selector(dragCellCollectionViewShouldBeginExchange:sourceIndexPath:toIndexPath:)]) {
                if (![self.delegate dragCellCollectionViewShouldBeginExchange:self sourceIndexPath:_oldIndexPath toIndexPath:index]) {
                    break;
                }
            }
            
            _currentIndexPath = index;
            self.oldPoint = [self cellForItemAtIndexPath:_currentIndexPath].center;

            [self _updateSourceData];
            
            // 移动 会调用willMoveToIndexPath方法更新数据源
            [self moveItemAtIndexPath:_oldIndexPath toIndexPath:_currentIndexPath];
            // 设置移动后的起始indexPath
            _oldIndexPath = _currentIndexPath;
            break;
        }
            break;
        default: {
            if (!self.oldIndexPath) {
                return;
            }
            UICollectionViewCell *cell = [self cellForItemAtIndexPath:_oldIndexPath];
            
            //结束动画过程中停止交互，防止出问题
            self.userInteractionEnabled = NO;
            self.isEndDrag = YES;
            //给截图视图一个动画移动到隐藏cell的新位置
            [UIView animateWithDuration:0.25 animations:^{
                _snapedView.center = self.oldPoint;
                _snapedView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
            } completion:^(BOOL finished) {
                //移除截图视图、显示隐藏的cell并开启交互
                [_snapedView removeFromSuperview];
                cell.hidden = NO;
                self.userInteractionEnabled = YES;
                if (self.delegate && [self.delegate respondsToSelector:@selector(dragCellCollectionViewDidEndDrag:)]) {
                    [self.delegate dragCellCollectionViewDidEndDrag:self];
                }
            }];
            // 关闭定时器
            self.oldIndexPath = nil;
            [self _stopEdgeTimer];
        }
            break;
    }
}

@end
