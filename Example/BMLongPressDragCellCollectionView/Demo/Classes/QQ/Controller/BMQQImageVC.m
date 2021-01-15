//
//  BMQQImageVC.m
//  BMLongPressDragCellCollectionViewDemo
//
//  Created by __liangdahong on 2017/7/31.
//  Copyright © 2017年 https://liangdahong.com All rights reserved.
//

#import "BMQQImageVC.h"
#import "BMLongPressDragCellCollectionView.h"
#import "BMImageCell.h"

@interface BMQQImageVC () <BMLongPressDragCellCollectionViewDelegate, BMLongPressDragCellCollectionViewDataSource>

@property (weak, nonatomic) IBOutlet BMLongPressDragCellCollectionView *imageCollectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (strong, nonatomic) NSMutableArray <NSArray <NSDictionary *> *> *dataSourceArray;

@end

static NSString *imageIdentifier = @"imageIdentifier";

@implementation BMQQImageVC

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
    self.imageCollectionView.dragCellAlpha = 0.9;
    self.imageCollectionView.collectionViewLayout = self.collectionViewFlowLayout;
    self.imageCollectionView.alwaysBounceVertical = YES;
    [self.imageCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass(BMImageCell.class) bundle:nil] forCellWithReuseIdentifier:imageIdentifier];
}

- (NSMutableArray<NSArray<NSDictionary *> *> *)dataSourceArray {
    if (!_dataSourceArray) {
        NSMutableArray <NSDictionary *> *arr = [@[] mutableCopy];
        int sec = 193;
        while (--sec > 0) {
            CGFloat width = arc4random_uniform(60) + 40;
            [arr addObject:@{@"icon" : [NSString stringWithFormat:@"%03d.png", sec], @"size" : [NSValue valueWithCGSize:CGSizeMake(width, width)]}];
        }
        _dataSourceArray = @[arr].mutableCopy;
    }
    return _dataSourceArray;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSourceArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceArray[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BMImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:imageIdentifier forIndexPath:indexPath];
    UIImage *image = [UIImage imageNamed:self.dataSourceArray[indexPath.section][indexPath.item][@"icon"]];
    if (!image) {
        image = [UIImage imageNamed:@"001.png"];
    }
    cell.imageView.image = image;
    return cell;
}

- (NSArray<NSArray<id> *> *)dataSourceWithDragCellCollectionView:(__kindof BMLongPressDragCellCollectionView *)dragCellCollectionView {
    return self.dataSourceArray;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSourceArray[indexPath.section][indexPath.item][@"size"] CGSizeValue];
}

- (void)dragCellCollectionView:(__kindof BMLongPressDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(NSArray<NSArray<id> *> *)newDataArray {
    self.dataSourceArray = [newDataArray mutableCopy];
}

- (void)dragCellCollectionViewShouldEndExchange:(BMLongPressDragCellCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    NSLog(@"结束交换时:（%ld %ld） -> ( %ld %ld)",
          sourceIndexPath.section,
          sourceIndexPath.item,
          destinationIndexPath.section,
          destinationIndexPath.item);
}

@end
