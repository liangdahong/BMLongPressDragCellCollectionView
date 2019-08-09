//
//  BMAlipayVC.m
//  BMDragCellCollectionViewDemo
//
//  Created by ___liangdahong on 2017/8/22.
//  Copyright © 2017年 https://liangdahong.com All rights reserved.
//

#import "BMAlipay2VC.h"
#import "BMAlipayCell.h"
#import "BMDragCellCollectionView.h"
#import "BMAlipayModel.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface BMAlipay2VC () <BMDragCellCollectionViewDelegate, BMDragCollectionViewDataSource>

@property (weak, nonatomic) IBOutlet BMDragCellCollectionView *dragCellCollectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (strong, nonatomic) NSMutableArray <NSArray <BMAlipayModel *>*>*dataSourceArray;

@end

static NSString *reuseIdentifier = @"reuseIdentifier";

@implementation BMAlipay2VC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    {
        self.dragCellCollectionView.dragCellAlpha = 0.9;
        self.dragCellCollectionView.collectionViewLayout = self.collectionViewFlowLayout;
        self.dragCellCollectionView.alwaysBounceVertical = YES;
        [self.dragCellCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass(BMAlipayCell.class) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    }
}

- (NSMutableArray<NSArray <BMAlipayModel *>*> *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = [@[] mutableCopy];

        [_dataSourceArray addObject:@[
                                     [BMAlipayModel modelWithTitle:@"转账" iconName:@"转账"],
                                     [BMAlipayModel modelWithTitle:@"信用卡还款" iconName:@"信用卡"],
                                     [BMAlipayModel modelWithTitle:@"充值中心" iconName:@"充值中心"],
                                     [BMAlipayModel modelWithTitle:@"芝麻信用" iconName:@"芝麻信用"]
                                     ]];

        
        [_dataSourceArray addObject:@[
                                      [BMAlipayModel modelWithTitle:@"共享单车" iconName:@"091共享单车 copy"],
                                      [BMAlipayModel modelWithTitle:@"花呗" iconName:@"花呗"],
                                      [BMAlipayModel modelWithTitle:@"滴滴出行" iconName:@"滴滴出行"],
                                      [BMAlipayModel modelWithTitle:@"火车票机票" iconName:@"火车票"]
                                      ]];
        
        
        [_dataSourceArray addObject:@[
                                      [BMAlipayModel modelWithTitle:@"来分期" iconName:@"分期"],
                                      [BMAlipayModel modelWithTitle:@"商家服务" iconName:@"商家服务2"],
                                      [BMAlipayModel modelWithTitle:@"ofo小黄车" iconName:@"ofo共享单车"],
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

- (NSArray *)dataSourceWithDragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView {
    return self.dataSourceArray;
}

- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(nullable NSArray *)newDataArray {
    self.dataSourceArray = [newDataArray mutableCopy];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
    return CGSizeZero;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}

@end
