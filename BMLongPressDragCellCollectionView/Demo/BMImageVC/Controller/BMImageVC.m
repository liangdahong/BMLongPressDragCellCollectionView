//
//  BMImageVC.m
//  BMLongPressDragCellCollectionViewDemo
//
//  Created by __liangdahong on 2017/7/31.
//  Copyright © 2017年 https://liangdahong.com All rights reserved.
//

#import "BMImageVC.h"
#import "BMLongPressDragCellCollectionView.h"
#import "BMImageCell.h"

@interface BMImageVC () <BMLongPressDragCellCollectionViewDelegate, BMLongPressDragCellCollectionViewDataSource>

@property (weak, nonatomic) IBOutlet BMLongPressDragCellCollectionView *imageCollectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (strong, nonatomic) NSMutableArray <NSDictionary *>*dataSourceArray;

@end

static NSString *imageIdentifier = @"imageIdentifier";

@implementation BMImageVC

- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        _collectionViewFlowLayout = ({
            UICollectionViewFlowLayout *collectionViewFlowLayout = [UICollectionViewFlowLayout new];
            collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
            collectionViewFlowLayout.minimumLineSpacing = 1;
            collectionViewFlowLayout.minimumInteritemSpacing = 1;
            collectionViewFlowLayout.headerReferenceSize = CGSizeMake(100, 40);
            collectionViewFlowLayout;
        });
    }
    return _collectionViewFlowLayout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    {
        self.imageCollectionView.dragCellAlpha = 0.9;
        self.imageCollectionView.collectionViewLayout = self.collectionViewFlowLayout;
        self.imageCollectionView.alwaysBounceVertical = YES;
        [self.imageCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass(BMImageCell.class) bundle:nil] forCellWithReuseIdentifier:imageIdentifier];
    }
}

- (NSMutableArray<NSDictionary *> *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = [@[] mutableCopy];
        int sec = 193;
        while (--sec > 0) {
            CGFloat width = arc4random_uniform(60) + 40;
            [_dataSourceArray addObject:@{@"icon" : [NSString stringWithFormat:@"%03d.png", sec], @"size" : [NSValue valueWithCGSize:CGSizeMake(width, width)]}];
        }
    }
    return _dataSourceArray;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSourceArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BMImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageIdentifier forIndexPath:indexPath];
    UIImage *image = [UIImage imageNamed:self.dataSourceArray[indexPath.row][@"icon"]];
    if (!image) {
        image = [UIImage imageNamed:@"001.png"];
    }
    cell.imageView.image = image;
    return cell;
}

- (NSArray *)dataSourceWithDragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView {
    return self.dataSourceArray;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSourceArray[indexPath.row][@"size"] CGSizeValue];
}

- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(NSArray *)newDataArray {
    self.dataSourceArray = [newDataArray mutableCopy];
}

@end
