
//
//  BMDragCellCollectionViewVC.m
//  BMDragCellCollectionViewDemo
//
//  Created by __liangdahong on 2017/7/21.
//  Copyright © 2017年 https://liangdahong.com All rights reserved.
//

#import "BMDragCellCollectionViewVC.h"
#import "BMDragCollectionViewCell.h"
#import "BMDragCellCollectionView.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface BMDragCellCollectionViewVC () <UICollectionViewDelegateFlowLayout,BMDragCellCollectionViewDelegate, BMDragCollectionViewDataSource>

@property (nonatomic, strong) BMDragCellCollectionView *collectionView; // collectionView
@property (strong, nonatomic) NSMutableArray *dataSourceArray;

@end

static NSString *reuseIdentifier = @"forCellWithReuseIdentifier";

@implementation BMDragCellCollectionViewVC

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
}

#pragma mark - getters setters

- (BMDragCellCollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = self.collectionViewScrollDirection;
        _collectionView = [[BMDragCellCollectionView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, HEIGHT) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        layout.minimumLineSpacing = arc4random_uniform(20)+1;
        layout.minimumInteritemSpacing = arc4random_uniform(20)+1;
        if (self.dataSource.count > 1) {
            layout.headerReferenceSize = CGSizeMake(100, 100);
        }
        if (self.collectionViewScrollDirection == UICollectionViewScrollDirectionVertical) {
            _collectionView.alwaysBounceVertical = YES;
        } else {
            _collectionView.alwaysBounceHorizontal = YES;
        }
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass(BMDragCollectionViewCell.class) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
        _collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    }
    return _collectionView;
}

#pragma mark - 系统delegate

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSource.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSource[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BMDragCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.label.text = _dataSource[indexPath.section][indexPath.item][@"title"];
    cell.label.backgroundColor = _dataSource[indexPath.section][indexPath.item][@"color"];
    return cell;
}

- (NSArray *)dataSourceWithDragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView {
    return self.dataSource;
}

- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(NSArray *)newDataArray {
    self.dataSource = [newDataArray mutableCopy];
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [self.dataSource[indexPath.section][indexPath.item][@"size"] CGSizeValue];
}

@end
