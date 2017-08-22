//
//  BMAlipayVC.m
//  BMDragCellCollectionViewDemo
//
//  Created by ___liangdahong on 2017/8/22.
//  Copyright © 2017年 http://idhong.com. All rights reserved.
//

#import "BMAlipayVC.h"
#import "BMAlipayCell.h"
#import "BMDragCellCollectionView.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface BMAlipayVC () <BMDragCellCollectionViewDelegate, BMDragCollectionViewDataSource>

@property (weak, nonatomic) IBOutlet BMDragCellCollectionView *dragCellCollectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (strong, nonatomic) NSMutableArray <NSString*>*dataSourceArray;

@end

static NSString *reuseIdentifier = @"reuseIdentifier";

@implementation BMAlipayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    {
        self.dragCellCollectionView.dragCellAlpha = 0.9;
        self.dragCellCollectionView.collectionViewLayout = self.collectionViewFlowLayout;
        self.dragCellCollectionView.alwaysBounceVertical = YES;
        [self.dragCellCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass(BMAlipayCell.class) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    }
}

- (NSMutableArray<NSString *> *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = [@[] mutableCopy];
        int arc = 11;
        while (arc--) {
            [_dataSourceArray addObject:[NSString stringWithFormat:@"功能%d", 9 - arc]];
        }
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
    BMAlipayCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.titleLabel.text = self.dataSourceArray[indexPath.row];
    return cell;
}

- (NSArray *)dataSourceWithDragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView {
    return self.dataSourceArray;
}

- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(NSArray *)newDataArray {
    self.dataSourceArray = [newDataArray mutableCopy];
}
@end
