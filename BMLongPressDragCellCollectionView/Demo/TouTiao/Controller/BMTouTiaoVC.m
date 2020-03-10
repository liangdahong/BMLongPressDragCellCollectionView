//
//  BMTouTiaoVC.m
//  TodayHeadlinesDrag
//
//  Created by __liangdahong on 2017/7/23.
//  Copyright © 2017年 https://liangdahong.com All rights reserved.
//

#import "BMTouTiaoVC.h"
#import "BMLongPressDragCellCollectionView.h"
#import "BMTouTiaoModel.h"
#import "BMTouTiaoCell.h"

#define WIDTH  [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface BMTouTiaoVC () <BMLongPressDragCellCollectionViewDelegate, BMLongPressDragCellCollectionViewDataSource>

@property (weak, nonatomic) IBOutlet BMLongPressDragCellCollectionView *dragCellCollectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *collectionViewFlowLayout;
@property (strong, nonatomic) NSMutableArray <NSMutableArray <BMTouTiaoModel *>*>*dataSourceArray;

@end

static NSString *reuseIdentifier = @"reuseIdentifier";

@implementation BMTouTiaoVC


- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        _collectionViewFlowLayout = ({
            UICollectionViewFlowLayout *collectionViewFlowLayout = [UICollectionViewFlowLayout new];
            collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
            collectionViewFlowLayout.minimumLineSpacing = 1;
            collectionViewFlowLayout.minimumInteritemSpacing = 1;
            collectionViewFlowLayout.itemSize = CGSizeMake((WIDTH-4)/4.0, 55);
            collectionViewFlowLayout.headerReferenceSize = CGSizeMake(100, 40);
            collectionViewFlowLayout;
        });
    }
    return _collectionViewFlowLayout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    {
        self.dragCellCollectionView.dragCellAlpha = 0.9;
        self.dragCellCollectionView.collectionViewLayout = self.collectionViewFlowLayout;
        self.dragCellCollectionView.alwaysBounceVertical = YES;
        [self.dragCellCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass(BMTouTiaoCell.class) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    }
}

- (NSMutableArray<NSMutableArray<BMTouTiaoModel *> *> *)dataSourceArray {
    if (!_dataSourceArray) {
        _dataSourceArray = [@[] mutableCopy];
        int sec = 2;
        while (sec--) {
            NSMutableArray *muarray = [@[] mutableCopy];
            int row = self.count + 10;
            if (sec == 1) {
                row = self.count;
            }
            while (row--) {
                BMTouTiaoModel *obj = [BMTouTiaoModel new];
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
    BMTouTiaoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    BMTouTiaoModel *todayHeadlinesDragModel = self.dataSourceArray[indexPath.section][indexPath.row];
    if (indexPath.section == 0) {
        if (indexPath.item == 0) {
            cell.removeButton.hidden = YES;
            cell.titleLabel.text = @"推荐(无)";
            cell.titleLabel.textColor = [UIColor lightGrayColor];
        } else {
            cell.removeButton.hidden = NO;
            cell.titleLabel.text = todayHeadlinesDragModel.title;
            cell.titleLabel.textColor = [UIColor blackColor];
        }
    } else {
        cell.removeButton.hidden = YES;
        cell.titleLabel.textColor = [UIColor blackColor];
        cell.titleLabel.text = [NSString stringWithFormat:@"＋ %@", todayHeadlinesDragModel.title];
    }
    cell.block = ^(UICollectionViewCell *cell) {
        [self collectionView:collectionView didSelectItemAtIndexPath:[collectionView indexPathForCell:cell]];
    };
    return cell;
}

- (NSArray *)dataSourceWithDragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView {
    return self.dataSourceArray;
}

- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(NSArray *)newDataArray {
    self.dataSourceArray = [newDataArray mutableCopy];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.item == 0) {
        return ;
    }

    if (indexPath.section == 0) {
        // 删除操作
        BMTouTiaoModel *todayHeadlinesDragModel = self.dataSourceArray[indexPath.section][indexPath.row];

        BMTouTiaoCell *cell = (BMTouTiaoCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.removeButton.hidden = YES;
        cell.titleLabel.text = [NSString stringWithFormat:@"＋ %@", todayHeadlinesDragModel.title];
        NSMutableArray *secArray0 = self.dataSourceArray[indexPath.section];
        [secArray0 removeObject:todayHeadlinesDragModel];
        
        NSMutableArray *secArray1 = self.dataSourceArray[1];
        [secArray1 addObject:todayHeadlinesDragModel];
        
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:secArray1.count-1 inSection:1]];
    } else {
        // 添加操作
        BMTouTiaoModel *todayHeadlinesDragModel = self.dataSourceArray[indexPath.section][indexPath.row];

        BMTouTiaoCell *cell = (BMTouTiaoCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.removeButton.hidden = NO;
        cell.titleLabel.text = todayHeadlinesDragModel.title;
        
        NSMutableArray *secArray1 = self.dataSourceArray[1];
        [secArray1 removeObject:todayHeadlinesDragModel];
        
        NSMutableArray *secArray0 = self.dataSourceArray[0];
        [secArray0 addObject:todayHeadlinesDragModel];
        
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:secArray0.count-1 inSection:0]];
    }
}


- (BOOL)dragCellCollectionViewShouldBeginMove:(BMLongPressDragCellCollectionView *)dragCellCollectionView indexPath:(NSIndexPath *)indexPath {
    //  将要开始拖拽时，询问此位置的 Cell 是否能拖拽
    if (indexPath.section == 1) {
        return NO;
    }
    if (indexPath.section == 0 && indexPath.item == 0) {
        return NO;
    }
    return YES;
}

- (BOOL)dragCellCollectionViewShouldBeginExchange:(BMLongPressDragCellCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    //  cell 将要交换时，询问是否能交换
    
    // 如果就要被交换的是 第一组第一个 或者  第二组
    // 就不交换
    if ((destinationIndexPath.item == 0 && destinationIndexPath.section == 0)
        || destinationIndexPath.section == 1) {
        return NO;
    }
    return YES;
}

- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView endedDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath {
    //  结束拖拽时
    if (indexPath.section == 1) {
        // 在结束拖拽时 如果在第二组，就自动移动 cell。
        // 移动到第二组 的第一个位置
        [dragCellCollectionView dragMoveItemToIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
        // 移动到指定组
        // [dragCellCollectionView dragMoveItemToIndexPath:[NSIndexPath indexPathForItem:[self collectionView:dragCellCollectionView numberOfItemsInSection:1] inSection:1]];
    }
}

@end
