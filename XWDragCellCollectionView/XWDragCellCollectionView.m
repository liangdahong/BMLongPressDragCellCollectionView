//
//  XWDragCellCollectionView.m
//  PanCollectionView
//
//  Created by YouLoft_MacMini on 16/1/4.
//  Copyright © 2016年 wazrx. All rights reserved.
//

#import "XWDragCellCollectionView.h"
#import <AudioToolbox/AudioToolbox.h>

#define angelToRandian(x)  ((x)/180.0*M_PI)

typedef NS_ENUM(NSUInteger, XWDragCellCollectionViewScrollDirection) {
    XWDragCellCollectionViewScrollDirectionNone = 0,
    XWDragCellCollectionViewScrollDirectionLeft,
    XWDragCellCollectionViewScrollDirectionRight,
    XWDragCellCollectionViewScrollDirectionUp,
    XWDragCellCollectionViewScrollDirectionDown
};

@interface XWDragCellCollectionView ()
@property (nonatomic, strong) NSIndexPath *originalIndexPath;
@property (nonatomic, weak) UICollectionViewCell *orignalCell;
@property (nonatomic, assign) CGPoint orignalCenter;
@property (nonatomic, strong) NSIndexPath *moveIndexPath;
@property (nonatomic, weak) UIView *tempMoveCell;
@property (nonatomic, weak) UILongPressGestureRecognizer *longPressGesture;
@property (nonatomic, strong) CADisplayLink *edgeTimer;
@property (nonatomic, assign) CGPoint lastPoint;
@property (nonatomic, assign) XWDragCellCollectionViewScrollDirection scrollDirection;
@property (nonatomic, assign) CGFloat oldMinimumPressDuration;
@property (nonatomic, assign, getter=isObservering) BOOL observering;
@property (nonatomic) BOOL isPanning;

@end

@implementation XWDragCellCollectionView

@dynamic delegate;
@dynamic dataSource;

#pragma mark - initailize methods

- (void)dealloc{
    [self xwp_removeContentOffsetObserver];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(nonnull UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self xwp_initializeProperty];
        [self xwp_addGesture];
        //添加监听
        [self xwp_addContentOffsetObserver];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self xwp_initializeProperty];
        [self xwp_addGesture];
        //添加监听
        [self xwp_addContentOffsetObserver];
    }
    return self;
}

- (void)xwp_initializeProperty{
    _minimumPressDuration = 1;
    _edgeScrollEable = YES;
    _shakeWhenMoveing = YES;
    _shakeLevel = 4.0f;
}

#pragma mark - longPressGesture methods

/**
 *  添加一个自定义的滑动手势
 */
- (void)xwp_addGesture{
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(xwp_longPressed:)];
    _longPressGesture = longPress;
    longPress.minimumPressDuration = _minimumPressDuration;
    [self addGestureRecognizer:longPress];
}

/**
 *  监听手势的改变
 */
- (void)xwp_longPressed:(UILongPressGestureRecognizer *)longPressGesture{
    if (longPressGesture.state == UIGestureRecognizerStateBegan) {
        [self xwp_gestureBegan:longPressGesture];
    }
    if (longPressGesture.state == UIGestureRecognizerStateChanged) {
        [self xwp_gestureChange:longPressGesture];
    }
    if (longPressGesture.state == UIGestureRecognizerStateCancelled ||
        longPressGesture.state == UIGestureRecognizerStateEnded){
        [self xwp_gestureEndOrCancle:longPressGesture];
    }
}

/**
 *  手势开始
 */
- (void)xwp_gestureBegan:(UILongPressGestureRecognizer *)longPressGesture{
    //获取手指所在的cell
    _originalIndexPath = [self indexPathForItemAtPoint:[longPressGesture locationOfTouch:0 inView:longPressGesture.view]];
    if ([self xwp_indexPathIsExcluded:_originalIndexPath]) {
        return;
    }
    _isPanning = YES;
    UICollectionViewCell *cell = [self cellForItemAtIndexPath:_originalIndexPath];
    UIImage *snap;
    UIGraphicsBeginImageContextWithOptions(cell.bounds.size, 1.0f, 0);
    [cell.layer renderInContext:UIGraphicsGetCurrentContext()];
    snap = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIView *tempMoveCell = [UIView new];
    tempMoveCell.layer.contents = (__bridge id)snap.CGImage;
    cell.hidden = YES;
    //记录cell，不能通过_originalIndexPath,在重用之后原indexpath所对应的cell可能不会是这个cell了
    _orignalCell = cell;
    //记录ceter，同理不能通过_originalIndexPath来获取cell
    _orignalCenter = cell.center;
    _tempMoveCell = tempMoveCell;
    _tempMoveCell.frame = cell.frame;
    [self addSubview:_tempMoveCell];
    //开启边缘滚动定时器
    [self xwp_setEdgeTimer];
    //开启抖动
    if (!_editing) {
        [self xwp_shakeAllCell];
    }
    _lastPoint = [longPressGesture locationOfTouch:0 inView:longPressGesture.view];
    //通知代理
    if ([self.delegate respondsToSelector:@selector(dragCellCollectionView:cellWillBeginMoveAtIndexPath:)]) {
        [self.delegate dragCellCollectionView:self cellWillBeginMoveAtIndexPath:_originalIndexPath];
    }
}
/**
 *  手势拖动
 */
- (void)xwp_gestureChange:(UILongPressGestureRecognizer *)longPressGesture{
    //通知代理
    if ([self.delegate respondsToSelector:@selector(dragCellCollectionViewCellisMoving:)]) {
        [self.delegate dragCellCollectionViewCellisMoving:self];
    }
    CGFloat tranX = [longPressGesture locationOfTouch:0 inView:longPressGesture.view].x - _lastPoint.x;
    CGFloat tranY = [longPressGesture locationOfTouch:0 inView:longPressGesture.view].y - _lastPoint.y;
    _tempMoveCell.center = CGPointApplyAffineTransform(_tempMoveCell.center, CGAffineTransformMakeTranslation(tranX, tranY));
    _lastPoint = [longPressGesture locationOfTouch:0 inView:longPressGesture.view];
    [self xwp_moveCell];
}

/**
 *  手势取消或者结束
 */
- (void)xwp_gestureEndOrCancle:(UILongPressGestureRecognizer *)longPressGesture{
    UICollectionViewCell *cell = [self cellForItemAtIndexPath:_originalIndexPath];
    self.userInteractionEnabled = NO;
    _isPanning = NO;
    [self xwp_stopEdgeTimer];
    //通知代理
    if ([self.delegate respondsToSelector:@selector(dragCellCollectionViewCellEndMoving:)]) {
        [self.delegate dragCellCollectionViewCellEndMoving:self];
    }
    [UIView animateWithDuration:0.25 animations:^{
        _tempMoveCell.center = _orignalCenter;
    } completion:^(BOOL finished) {
        [self xwp_stopShakeAllCell];
        [_tempMoveCell removeFromSuperview];
        cell.hidden = NO;
        _orignalCell.hidden = NO;
        self.userInteractionEnabled = YES;
        _originalIndexPath = nil;
    }];
}

#pragma mark - setter methods

- (void)setMinimumPressDuration:(NSTimeInterval)minimumPressDuration{
    _minimumPressDuration = minimumPressDuration;
    _longPressGesture.minimumPressDuration = minimumPressDuration;
}

- (void)setShakeLevel:(CGFloat)shakeLevel{
    CGFloat level = MAX(1.0f, shakeLevel);
    _shakeLevel = MIN(level, 10.0f);
}

#pragma mark - timer methods

- (void)xwp_setEdgeTimer{
    if (!_edgeTimer && _edgeScrollEable) {
        _edgeTimer = [CADisplayLink displayLinkWithTarget:self selector:@selector(xwp_edgeScroll)];
        [_edgeTimer addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
}

- (void)xwp_stopEdgeTimer{
    if (_edgeTimer) {
        [_edgeTimer invalidate];
        _edgeTimer = nil;
    }
}


#pragma mark - private methods

- (void)xwp_moveCell{
    for (UICollectionViewCell *cell in [self visibleCells]) {
        if ([self indexPathForCell:cell] == _originalIndexPath || [self xwp_indexPathIsExcluded:[self indexPathForCell:cell]]) {
            continue;
        }
        //计算中心距
        CGFloat spacingX = fabs(_tempMoveCell.center.x - cell.center.x);
        CGFloat spacingY = fabs(_tempMoveCell.center.y - cell.center.y);
        if (spacingX <= _tempMoveCell.bounds.size.width / 2.0f && spacingY <= _tempMoveCell.bounds.size.height / 2.0f) {
            _moveIndexPath = [self indexPathForCell:cell];
            _orignalCell = cell;
            _orignalCenter = cell.center;
            //更新数据源
            [self xwp_updateDataSource];
            //移动
            NSLog(@"%@", [self cellForItemAtIndexPath:_originalIndexPath]);
//            cell.hidden = YES;
            [CATransaction begin];
            [self moveItemAtIndexPath:_originalIndexPath toIndexPath:_moveIndexPath];
            [CATransaction setCompletionBlock:^{
                NSLog(@"动画完成");
            }];
            [CATransaction commit];
            //通知代理
            if ([self.delegate respondsToSelector:@selector(dragCellCollectionView:moveCellFromIndexPath:toIndexPath:)]) {
                [self.delegate dragCellCollectionView:self moveCellFromIndexPath:_originalIndexPath toIndexPath:_moveIndexPath];
            }
            //设置移动后的起始indexPath
            _originalIndexPath = _moveIndexPath;
            break;
        }
    }
}

/**
 *  更新数据源
 */
- (void)xwp_updateDataSource{
    NSMutableArray *temp = @[].mutableCopy;
    //获取数据源
    if ([self.dataSource respondsToSelector:@selector(dataSourceArrayOfCollectionView:)]) {
        [temp addObjectsFromArray:[self.dataSource dataSourceArrayOfCollectionView:self]];
    }
    //判断数据源是单个数组还是数组套数组的多section形式，YES表示数组套数组
    BOOL dataTypeCheck = ([self numberOfSections] != 1 || ([self numberOfSections] == 1 && [temp[0] isKindOfClass:[NSArray class]]));
    if (dataTypeCheck) {
        for (int i = 0; i < temp.count; i ++) {
            [temp replaceObjectAtIndex:i withObject:[temp[i] mutableCopy]];
        }
    }
    if (_moveIndexPath.section == _originalIndexPath.section) {
        NSMutableArray *orignalSection = dataTypeCheck ? temp[_originalIndexPath.section] : temp;
        if (_moveIndexPath.item > _originalIndexPath.item) {
            for (NSUInteger i = _originalIndexPath.item; i < _moveIndexPath.item ; i ++) {
                [orignalSection exchangeObjectAtIndex:i withObjectAtIndex:i + 1];
            }
        }else{
            for (NSUInteger i = _originalIndexPath.item; i > _moveIndexPath.item ; i --) {
                [orignalSection exchangeObjectAtIndex:i withObjectAtIndex:i - 1];
            }
        }
    }else{
        NSMutableArray *orignalSection = temp[_originalIndexPath.section];
        NSMutableArray *currentSection = temp[_moveIndexPath.section];
        [currentSection insertObject:orignalSection[_originalIndexPath.item] atIndex:_moveIndexPath.item];
        [orignalSection removeObject:orignalSection[_originalIndexPath.item]];
    }
    //将重排好的数据传递给外部
    if ([self.delegate respondsToSelector:@selector(dragCellCollectionView:newDataArrayAfterMove:)]) {
        [self.delegate dragCellCollectionView:self newDataArrayAfterMove:temp.copy];
    }
}

- (void)xwp_edgeScroll{
    [self xwp_setScrollDirection];
    switch (_scrollDirection) {
        case XWDragCellCollectionViewScrollDirectionLeft:{
            //这里的动画必须设为NO
            [self setContentOffset:CGPointMake(self.contentOffset.x - 4, self.contentOffset.y) animated:NO];
            _tempMoveCell.center = CGPointMake(_tempMoveCell.center.x - 4, _tempMoveCell.center.y);
            _lastPoint.x -= 4;
            
        }
            break;
        case XWDragCellCollectionViewScrollDirectionRight:{
            [self setContentOffset:CGPointMake(self.contentOffset.x + 4, self.contentOffset.y) animated:NO];
            _tempMoveCell.center = CGPointMake(_tempMoveCell.center.x + 4, _tempMoveCell.center.y);
            _lastPoint.x += 4;
            
        }
            break;
        case XWDragCellCollectionViewScrollDirectionUp:{
            [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y - 4) animated:NO];
            _tempMoveCell.center = CGPointMake(_tempMoveCell.center.x, _tempMoveCell.center.y - 4);
            _lastPoint.y -= 4;
        }
            break;
        case XWDragCellCollectionViewScrollDirectionDown:{
            [self setContentOffset:CGPointMake(self.contentOffset.x, self.contentOffset.y + 4) animated:NO];
            _tempMoveCell.center = CGPointMake(_tempMoveCell.center.x, _tempMoveCell.center.y + 4);
            _lastPoint.y += 4;
        }
            break;
        default:
            break;
    }
    
}

- (void)xwp_shakeAllCell{
    if (!_shakeWhenMoveing) {
        //没有开启抖动只需要遍历设置个cell的hidden属性
        NSArray *cells = [self visibleCells];
        for (UICollectionViewCell *cell in cells) {
            //顺便设置各个cell的hidden属性，由于有cell被hidden，其hidden状态可能被冲用到其他cell上,不能直接利用_originalIndexPath相等判断，这很坑
            BOOL hidden = _originalIndexPath && [self indexPathForCell:cell].item == _originalIndexPath.item && [self indexPathForCell:cell].section == _originalIndexPath.section;
            cell.hidden = hidden;
        }
        return;
    }
    CAKeyframeAnimation* anim=[CAKeyframeAnimation animation];
    anim.keyPath=@"transform.rotation";
    anim.values=@[@(angelToRandian(-_shakeLevel)),@(angelToRandian(_shakeLevel)),@(angelToRandian(-_shakeLevel))];
    anim.repeatCount=MAXFLOAT;
    anim.duration=0.2;
    NSArray *cells = [self visibleCells];
    for (UICollectionViewCell *cell in cells) {
        if ([self xwp_indexPathIsExcluded:[self indexPathForCell:cell]]) {
            continue;
        }
        /**如果加了shake动画就不用再加了*/
        if (![cell.layer animationForKey:@"shake"]) {
            [cell.layer addAnimation:anim forKey:@"shake"];
        }
        //顺便设置各个cell的hidden属性，由于有cell被hidden，其hidden状态可能被冲用到其他cell上
        BOOL hidden = _originalIndexPath && [self indexPathForCell:cell].item == _originalIndexPath.item && [self indexPathForCell:cell].section == _originalIndexPath.section;
        cell.hidden = hidden;
    }
    if (![_tempMoveCell.layer animationForKey:@"shake"]) {
        [_tempMoveCell.layer addAnimation:anim forKey:@"shake"];
    }
}

- (void)xwp_stopShakeAllCell{
    if (!_shakeWhenMoveing || _editing) {
        return;
    }
    NSArray *cells = [self visibleCells];
    for (UICollectionViewCell *cell in cells) {
        [cell.layer removeAllAnimations];
    }
    [_tempMoveCell.layer removeAllAnimations];
}

- (void)xwp_setScrollDirection{
    _scrollDirection = XWDragCellCollectionViewScrollDirectionNone;
    if (self.bounds.size.height + self.contentOffset.y - _tempMoveCell.center.y < _tempMoveCell.bounds.size.height / 2 && self.bounds.size.height + self.contentOffset.y < self.contentSize.height) {
        _scrollDirection = XWDragCellCollectionViewScrollDirectionDown;
    }
    if (_tempMoveCell.center.y - self.contentOffset.y < _tempMoveCell.bounds.size.height / 2 && self.contentOffset.y > 0) {
        _scrollDirection = XWDragCellCollectionViewScrollDirectionUp;
    }
    if (self.bounds.size.width + self.contentOffset.x - _tempMoveCell.center.x < _tempMoveCell.bounds.size.width / 2 && self.bounds.size.width + self.contentOffset.x < self.contentSize.width) {
        _scrollDirection = XWDragCellCollectionViewScrollDirectionRight;
    }
    
    if (_tempMoveCell.center.x - self.contentOffset.x < _tempMoveCell.bounds.size.width / 2 && self.contentOffset.x > 0) {
        _scrollDirection = XWDragCellCollectionViewScrollDirectionLeft;
    }
}

- (void)xwp_addContentOffsetObserver{
    if (_observering) return;
    [self addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    _observering = YES;
}

- (void)xwp_removeContentOffsetObserver{
    if (!_observering) return;
    [self removeObserver:self forKeyPath:@"contentOffset"];
    _observering = NO;
}

- (BOOL)xwp_indexPathIsExcluded:(NSIndexPath *)indexPath{
    if (!indexPath || ![self.delegate respondsToSelector:@selector(excludeIndexPathsWhenMoveDragCellCollectionView:)]) {
        return NO;
    }
    NSArray<NSIndexPath *> *excludeIndexPaths = [self.delegate excludeIndexPathsWhenMoveDragCellCollectionView:self];
    __block BOOL flag = NO;
    [excludeIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.item == indexPath.item && obj.section == indexPath.section) {
            flag = YES;
            *stop = YES;
        }
    }];
    return flag;
}

#pragma mark - public methods

- (void)xw_enterEditingModel{
    _editing = YES;
    _oldMinimumPressDuration =  _longPressGesture.minimumPressDuration;
    _longPressGesture.minimumPressDuration = 0;
    if (_shakeWhenMoveing) {
        [self xwp_shakeAllCell];
        [self xwp_addContentOffsetObserver];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xwp_foreground) name:UIApplicationWillEnterForegroundNotification object:nil];
    }
}

- (void)xw_stopEditingModel{
    _editing = NO;
    _longPressGesture.minimumPressDuration = _oldMinimumPressDuration;
    [self xwp_stopShakeAllCell];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
}


#pragma mark - overWrite methods

/**
 *  重写hitTest事件，判断是否应该相应自己的滑动手势，还是系统的滑动手势
 */

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    _longPressGesture.enabled = [self indexPathForItemAtPoint:point];
    return [super hitTest:point withEvent:event];
}

#pragma mark - KVO

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    if (![keyPath isEqualToString:@"contentOffset"]) return;
    if (_editing || _isPanning) {
        [self xwp_shakeAllCell];
    }else if (!_editing && !_isPanning){
        [self xwp_stopShakeAllCell];
    }
}

#pragma mark - notification

- (void)xwp_foreground{
    if (_editing) {
        [self xwp_shakeAllCell];
    }
}



@end
