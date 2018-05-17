//
//  AddPhotoView.m
//  DatingCloud
//
//  Created by Denny on 2018/5/16.
//  Copyright © 2018年 Denny. All rights reserved.
//
#define SCREEN_BOUNDS       ([[UIScreen mainScreen] bounds])
#define SCREEN_WIDTH        CGRectGetWidth(SCREEN_BOUNDS)
#import "AddPhotoView.h"
static NSString *reuseIdentifier = @"reuseIdentifier";

@implementation AddPhotoView
- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.dragCellCollectionView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.dragCellCollectionView.frame = self.bounds;
}


- (BMDragCellCollectionView *)dragCellCollectionView {
    if (!_dragCellCollectionView) {
        _dragCellCollectionView = [[BMDragCellCollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.collectionViewFlowLayout];
        _dragCellCollectionView.dragCellAlpha = 0.9;
        _dragCellCollectionView.dataSource = self;
        _dragCellCollectionView.delegate = self;
        _dragCellCollectionView.collectionViewLayout = self.collectionViewFlowLayout;
        _dragCellCollectionView.alwaysBounceVertical = YES;
        [_dragCellCollectionView registerClass:[AddPhotoCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
        _dragCellCollectionView.backgroundColor = [UIColor whiteColor];
    }
    return _dragCellCollectionView;
}

- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        _collectionViewFlowLayout = ({
            UICollectionViewFlowLayout *collectionViewFlowLayout = [UICollectionViewFlowLayout new];
            collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
            collectionViewFlowLayout.minimumLineSpacing = 1;
            collectionViewFlowLayout.minimumInteritemSpacing = 1;
            collectionViewFlowLayout.itemSize = CGSizeMake((SCREEN_WIDTH-4)/4.0, (SCREEN_WIDTH-4)/4.0);
            collectionViewFlowLayout;
        });
    }
    return _collectionViewFlowLayout;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    AddPhotoCollectionViewCell *cell = (AddPhotoCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.url = self.dataSourceArray[indexPath.row];
    return cell;
}

- (NSArray *)dataSourceWithDragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView {
    return self.dataSourceArray;
}

- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(nullable NSArray *)newDataArray {
    self.dataSourceArray = [newDataArray mutableCopy];
    NSLog(@"____%ld",self.dataSourceArray.count);
}

@end
