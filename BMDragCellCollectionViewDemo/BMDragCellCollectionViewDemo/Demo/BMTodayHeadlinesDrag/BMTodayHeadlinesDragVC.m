//
//  BMTodayHeadlinesDragVC.m
//  TodayHeadlinesDrag
//
//  Created by __liangdahong on 2017/7/23.
//  Copyright © 2017年 http://idhong.com. All rights reserved.
//

#import "BMTodayHeadlinesDragVC.h"
#import "BMDragCellCollectionView.h"
#import "BMTodayHeadlinesDragModel.h"
#import "BMTodayHeadlinesDragCell.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface BMTodayHeadlinesDragVC () <BMDragCellCollectionViewDelegate, BMDragCollectionViewDataSource>

@property (weak, nonatomic) IBOutlet BMDragCellCollectionView *dragCellCollectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (strong, nonatomic) NSMutableArray <NSMutableArray <BMTodayHeadlinesDragModel *>*>*dataSourceArray;

@end

static NSString *reuseIdentifier = @"reuseIdentifier";

@implementation BMTodayHeadlinesDragVC


- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        _collectionViewFlowLayout = [UICollectionViewFlowLayout new];
        _collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
        _collectionViewFlowLayout.minimumLineSpacing = 15;
        _collectionViewFlowLayout.minimumInteritemSpacing = 1;
        _collectionViewFlowLayout.itemSize = CGSizeMake((WIDTH-4)/4.0, 35);
        _collectionViewFlowLayout.headerReferenceSize = CGSizeMake(100, 40);
    }
    return _collectionViewFlowLayout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"今日头条-频道选择-正在完善中...";
    
    self.dragCellCollectionView.collectionViewLayout = self.collectionViewFlowLayout;
    
    self.dragCellCollectionView.alwaysBounceVertical = YES;
    [self.dragCellCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass(BMTodayHeadlinesDragCell.class) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
}

- (NSMutableArray<NSMutableArray<BMTodayHeadlinesDragModel *> *> *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = [@[] mutableCopy];
        int sec = 2;
        while (sec--) {
            NSMutableArray *muarray = [@[] mutableCopy];
            int row = 55;
            if (sec == 1) {
                row = 66;
            }
            while (row--) {
                BMTodayHeadlinesDragModel *obj = [BMTodayHeadlinesDragModel new];
                if (arc4random_uniform(6) == 1) {
                    obj.title = [NSString stringWithFormat:@"类%d(%d%d)", arc4random_uniform(300), sec, row];
                } else {
                    obj.title = [NSString stringWithFormat:@"类(%d%d)", sec, row];
                }
                [muarray addObject:obj];
            }
            [_dataSourceArray addObject:muarray];
        }
    }
    return _dataSourceArray;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.dataSourceArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataSourceArray[section] count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    BMTodayHeadlinesDragCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.todayHeadlinesDragModel = self.dataSourceArray[indexPath.section][indexPath.row];
    return cell;
}

- (NSArray *)dataSourceWithDragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView {
    return self.dataSourceArray;
}

- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(NSArray *)newDataArray {
    self.dataSourceArray = [newDataArray mutableCopy];
}

- (BOOL)dragCellCollectionViewShouldBeginExchange:(BMDragCellCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (destinationIndexPath.section == 1 || sourceIndexPath.section == 1) {
        return NO;
    }
    return YES;
}

- (BOOL)dragCellCollectionViewShouldBeginMove:(BMDragCellCollectionView *)dragCellCollectionView indexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return NO;
    }
    return YES;
}

@end
