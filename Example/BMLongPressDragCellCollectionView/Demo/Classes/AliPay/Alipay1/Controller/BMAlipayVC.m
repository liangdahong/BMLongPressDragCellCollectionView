//
//  BMAlipayVC.m
//  BMLongPressDragCellCollectionViewDemo
//
//  Created by ___liangdahong on 2017/8/22.
//  Copyright © 2017年 https://liangdahong.com All rights reserved.
//

#import "BMAlipayVC.h"
#import "BMAlipayCell.h"
#import "BMLongPressDragCellCollectionView.h"
#import "BMAlipayModel.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface BMAlipayVC () <BMLongPressDragCellCollectionViewDelegate, BMLongPressDragCellCollectionViewDataSource>

@property (weak, nonatomic) IBOutlet BMLongPressDragCellCollectionView *dragCellCollectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (strong, nonatomic) NSMutableArray <BMAlipayModel *> *dataSourceArray;

@end

static NSString *reuseIdentifier = @"reuseIdentifier";

@implementation BMAlipayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dragCellCollectionView.dragCellAlpha        = 0.9;
    self.dragCellCollectionView.collectionViewLayout = self.collectionViewFlowLayout;
    self.dragCellCollectionView.alwaysBounceVertical = YES;
    [self.dragCellCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass(BMAlipayCell.class) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"配置" style:(UIBarButtonItemStylePlain) target:self action:@selector(settingClick)];
}

- (void)settingClick {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"配置" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"调整拖拽 cell 的缩放比例" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dragZoomScale];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"拖拽的 Cell 在拖拽移动时的透明度例" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self dragCellAlpha];
    }]];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)dragZoomScale {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"调整拖拽 cell 的缩放比例" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [@[@"0.5", @"0.7", @"1.0", @"1.2", @"1.5", @"2.0", @"3.0", @"4.0",] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alertVC addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.dragCellCollectionView.dragZoomScale = action.title.floatValue;
        }]];
    }];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (void)dragCellAlpha {
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"拖拽的 Cell 在拖拽移动时的透明度" message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    [@[@"0.4", @"0.5", @"0.6", @"0.7", @"1.0"] enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [alertVC addAction:[UIAlertAction actionWithTitle:obj style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.dragCellCollectionView.dragCellAlpha = action.title.floatValue;
        }]];
    }];
    [alertVC addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alertVC animated:YES completion:nil];
}

- (NSMutableArray<BMAlipayModel *> *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = [@[] mutableCopy];
        
        [_dataSourceArray addObject:[BMAlipayModel modelWithTitle:@"转账" iconName:@"转账"]];
        [_dataSourceArray addObject:[BMAlipayModel modelWithTitle:@"信用卡还款" iconName:@"信用卡"]];
        [_dataSourceArray addObject:[BMAlipayModel modelWithTitle:@"充值中心" iconName:@"充值中心"]];
        [_dataSourceArray addObject:[BMAlipayModel modelWithTitle:@"芝麻信用" iconName:@"芝麻信用"]];
        
        [_dataSourceArray addObject:[BMAlipayModel modelWithTitle:@"共享单车" iconName:@"091共享单车 copy"]];
        [_dataSourceArray addObject:[BMAlipayModel modelWithTitle:@"花呗" iconName:@"花呗"]];
        [_dataSourceArray addObject:[BMAlipayModel modelWithTitle:@"滴滴出行" iconName:@"滴滴出行"]];
        [_dataSourceArray addObject:[BMAlipayModel modelWithTitle:@"火车票机票" iconName:@"火车票"]];
        
        [_dataSourceArray addObject:[BMAlipayModel modelWithTitle:@"来分期" iconName:@"分期"]];
        [_dataSourceArray addObject:[BMAlipayModel modelWithTitle:@"商家服务" iconName:@"商家服务2"]];
        [_dataSourceArray addObject:[BMAlipayModel modelWithTitle:@"ofo小黄车" iconName:@"ofo共享单车"]];
    }
    return _dataSourceArray;
}

- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        _collectionViewFlowLayout = ({
            UICollectionViewFlowLayout *collectionViewFlowLayout = [UICollectionViewFlowLayout new];
            collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
            collectionViewFlowLayout.minimumLineSpacing = 1;
            collectionViewFlowLayout.minimumInteritemSpacing = 1;
            collectionViewFlowLayout.itemSize = CGSizeMake((WIDTH-4)/4.0, (WIDTH-4)/4.0);
            collectionViewFlowLayout;
        });
    }
    return _collectionViewFlowLayout;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(BMAlipayCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.model = self.dataSourceArray[indexPath.row];
}

// === BMLongPressDragCellCollectionView 的核心方法 ↓

- (NSArray *)dataSourceWithDragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView {
    return self.dataSourceArray;
}

- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(nullable NSArray *)newDataArray {
    self.dataSourceArray = [newDataArray mutableCopy];
}

// === BMLongPressDragCellCollectionView 的核心方法 ↑

- (void)dragCellCollectionViewShouldEndExchange:(BMLongPressDragCellCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSLog(@"结束交换时:（%ld %ld） -> ( %ld %ld)",
          sourceIndexPath.section,
          sourceIndexPath.item,
          destinationIndexPath.section,
          destinationIndexPath.item);
}

/**
 将要开始拖拽时，询问此位置的 Cell 是否能拖拽

 @param dragCellCollectionView dragCellCollectionView
 @param indexPath indexPath
 @return YES: 正常拖拽和移动 NO:此 Cell 不可拖拽，如：增加按钮等。
 */
- (BOOL)dragCellCollectionViewShouldBeginMove:(BMLongPressDragCellCollectionView *)dragCellCollectionView indexPath:(NSIndexPath *)indexPath {
    NSLog(@"将要开始拖拽时，询问此位置的 Cell 是否能拖拽");
    return YES;
}

/**
 将要开始拖拽时，向外面获取需要拖拽的 View，如果不实现就内部自动处理。

 @param dragCellCollectionView dragCellCollectionView
 @param indexPath indexPath
 @return dragView
 */
//- (UIView *)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView startDragAtIndexPath:(NSIndexPath *)indexPath {
//    UIView *view = UIView.new;
//    view.backgroundColor = UIColor.yellowColor;
//    view.frame = CGRectMake(0, 0, 100, 100);
//    return view;
//}

/// 开始拖拽时，让外面的使用者可以对拖拽的 View 做额外操作
/// @param dragCellCollectionView dragCellCollectionView
/// @param dragView dragView
/// @param indexPath indexPath
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView dragView:(UIView *)dragView indexPath:(NSIndexPath *)indexPath {
    NSLog(@"开始拖拽时，让外面的使用者可以对拖拽的 View 做额外操作 %@", dragView);
//    dragView.layer.cornerRadius  = 100;
//    dragView.layer.masksToBounds = YES;
}

/// 正在拖拽时
/// @param dragCellCollectionView dragCellCollectionView
/// @param point 手指触摸点对于 collectionView 的位置
/// 可以参考 https://github.com/liangdahong/ToutiaoDemo/blob/master/ToutiaoDemo/Classes/Edit/Controller/BMChannelEditVC.m 的使用
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView changedDragAtPoint:(CGPoint)point {
    NSLog(@"正在拖拽时");
}

/// cell 将要交换时，询问是否能交换
/// @param dragCellCollectionView dragCellCollectionView
/// @param sourceIndexPath 原来的 IndexPath
/// @param destinationIndexPath 将要交换的 IndexPath
/// YES: 正常拖拽和移动 NO:此Cell不可拖拽，如：增加按钮等。
- (BOOL)dragCellCollectionViewShouldBeginExchange:(BMLongPressDragCellCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSLog(@"将要交换时，询问是否能交换");
    return YES;
}

/// 结束拖拽时
/// @param dragCellCollectionView dragCellCollectionView
/// @param point 手指触摸点对于 collectionView 的位置
/// 可以参考 https://github.com/liangdahong/ToutiaoDemo/blob/master/ToutiaoDemo/Classes/Edit/Controller/BMChannelEditVC.m 的使用
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView endedDragAtPoint:(CGPoint)point {
    NSLog(@"结束拖拽时");
}

- (void)dealloc {
    NSLog(@"BMAlipayVC dealloc");
}

@end
