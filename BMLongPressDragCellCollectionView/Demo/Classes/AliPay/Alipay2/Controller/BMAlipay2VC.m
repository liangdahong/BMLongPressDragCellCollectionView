//
//  BMAlipayVC.m
//  BMLongPressDragCellCollectionViewDemo
//
//  Created by ___liangdahong on 2017/8/22.
//  Copyright © 2017年 https://liangdahong.com All rights reserved.
//

#import "BMAlipay2VC.h"
#import "BMAlipayCell.h"
#import "BMLongPressDragCellCollectionView.h"
#import "BMAlipayModel.h"
#import "UICollectionView+BMDynamicLayout.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface BMAlipay2VC () <BMLongPressDragCellCollectionViewDelegate, BMLongPressDragCellCollectionViewDataSource>

@property (weak, nonatomic) IBOutlet BMLongPressDragCellCollectionView *dragCellCollectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (strong, nonatomic) NSMutableArray <NSArray <BMAlipayModel *>*>*dataSourceArray;

@end

static NSString *reuseIdentifier = @"reuseIdentifier";

@implementation BMAlipay2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dragCellCollectionView.dragCellAlpha = 0.9;
    self.dragCellCollectionView.collectionViewLayout = self.collectionViewFlowLayout;
    self.dragCellCollectionView.alwaysBounceVertical = YES;
    [self.dragCellCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass(BMAlipayCell.class) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

- (NSMutableArray<NSArray <BMAlipayModel *>*> *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = [@[] mutableCopy];

        [_dataSourceArray addObject:@[
                                     [BMAlipayModel modelWithTitle:@"转账" iconName:@"转账"],
                                     ]];
        
        [_dataSourceArray addObject:@[
                                      [BMAlipayModel modelWithTitle:@"来分期1" iconName:@"分期"],
                                      [BMAlipayModel modelWithTitle:@"来分期2" iconName:@"分期"],
                                      [BMAlipayModel modelWithTitle:@"来分期3" iconName:@"分期"],

                                      ]];
        [_dataSourceArray addObject:@[
                                      [BMAlipayModel modelWithTitle:@"来分期4" iconName:@"分期"],
                                      [BMAlipayModel modelWithTitle:@"来分期5" iconName:@"分期"],
                                      ]];
        [_dataSourceArray addObject:@[
                                      [BMAlipayModel modelWithTitle:@"来分期6" iconName:@"分期"],
                                      ]];
        [_dataSourceArray addObject:@[
                                      [BMAlipayModel modelWithTitle:@"来分期7" iconName:@"分期"],
                                      ]];
        [_dataSourceArray addObject:@[
                                      [BMAlipayModel modelWithTitle:@"来分期8" iconName:@"分期"],
                                      ]];
        [_dataSourceArray addObject:@[
                                      [BMAlipayModel modelWithTitle:@"来分期9" iconName:@"分期"],
                                      ]];
        [_dataSourceArray addObject:@[
                                      [BMAlipayModel modelWithTitle:@"来分期10" iconName:@"分期"],
                                      ]];
        [_dataSourceArray addObject:@[
                                      [BMAlipayModel modelWithTitle:@"来分期11" iconName:@"分期"],
                                      ]];
        [_dataSourceArray addObject:@[
                                      [BMAlipayModel modelWithTitle:@"来分期12" iconName:@"分期"],
                                      ]];
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

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSourceArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceArray[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    return [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(BMAlipayCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    cell.model = self.dataSourceArray[indexPath.section][indexPath.item];
}

- (NSArray *)dataSourceWithDragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView {
    return self.dataSourceArray;
}

- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(nullable NSArray *)newDataArray {
    self.dataSourceArray = [newDataArray mutableCopy];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeMake(100, 50);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(100, 50);
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    if (kind == UICollectionElementKindSectionHeader) {
        return [BMAlipay2HeaderView bm_collectionReusableViewWithCollectionReusableView:collectionView isHeader:YES forIndexPath:indexPath];
    } else {
        return [BMAlipay2FooterView bm_collectionReusableViewWithCollectionReusableView:collectionView isHeader:NO forIndexPath:indexPath];
    }
}

@end
