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
        [self.dragCellCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass(BMTodayHeadlinesDragCell.class) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    }
}

- (NSMutableArray<NSMutableArray<BMTodayHeadlinesDragModel *> *> *)dataSourceArray {
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
    BMTodayHeadlinesDragModel *todayHeadlinesDragModel = self.dataSourceArray[indexPath.section][indexPath.row];
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

- (NSArray *)dataSourceWithDragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView {
    return self.dataSourceArray;
}

- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(NSArray *)newDataArray {
    self.dataSourceArray = [newDataArray mutableCopy];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.item == 0) {
        return ;
    }

    if (indexPath.section == 0) {
        // 删除操作
        BMTodayHeadlinesDragModel *todayHeadlinesDragModel = self.dataSourceArray[indexPath.section][indexPath.row];

        BMTodayHeadlinesDragCell *cell = (BMTodayHeadlinesDragCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.removeButton.hidden = YES;
        cell.titleLabel.text = [NSString stringWithFormat:@"＋ %@", todayHeadlinesDragModel.title];
        NSMutableArray *secArray0 = self.dataSourceArray[indexPath.section];
        [secArray0 removeObject:todayHeadlinesDragModel];
        
        NSMutableArray *secArray1 = self.dataSourceArray[1];
        [secArray1 addObject:todayHeadlinesDragModel];
        
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:secArray1.count-1 inSection:1]];
    } else {
        // 添加操作
        BMTodayHeadlinesDragModel *todayHeadlinesDragModel = self.dataSourceArray[indexPath.section][indexPath.row];

        BMTodayHeadlinesDragCell *cell = (BMTodayHeadlinesDragCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.removeButton.hidden = NO;
        cell.titleLabel.text = todayHeadlinesDragModel.title;
        
        NSMutableArray *secArray1 = self.dataSourceArray[1];
        [secArray1 removeObject:todayHeadlinesDragModel];
        
        NSMutableArray *secArray0 = self.dataSourceArray[0];
        [secArray0 addObject:todayHeadlinesDragModel];
        
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:secArray0.count-1 inSection:0]];
    }
}
    
//- (BOOL)dragCellCollectionViewShouldBeginExchange:(BMDragCellCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
//    if (destinationIndexPath.section == 1 || sourceIndexPath.section == 1) {
//        return NO;
//    }
//    if (destinationIndexPath.section == 0 && destinationIndexPath.item == 0) {
//        return NO;
//    }
//    return YES;
//}

- (BOOL)dragCellCollectionViewShouldBeginExchange:(BMDragCellCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (sourceIndexPath.section == destinationIndexPath.section) {
        NSLog(@"===");
        return YES;
    }
    NSLog(@"!!!===");
    return NO;
}

- (BOOL)dragCellCollectionViewShouldBeginMove:(BMDragCellCollectionView *)dragCellCollectionView indexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return NO;
    }
    if (indexPath.section == 0 && indexPath.item == 0) {
        return NO;
    }
    return YES;
}

- (void)dragCellCollectionViewDidEndDrag:(BMDragCellCollectionView *)dragCellCollectionView {
    NSLog(@"dragCellCollectionViewDidEndDrag");
}

- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView beganDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath {
    NSLog(@"beganDragAtPoint %@   - %@", NSStringFromCGPoint(point), indexPath);
}

- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView changedDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath {
    
    NSLog(@"changedDragAtPoint %@   - %@", NSStringFromCGPoint(point), indexPath);
}

- (void)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView endedDragAtPoint:(CGPoint)point indexPath:(NSIndexPath *)indexPath {
    NSLog(@"endedDragAtPoint %@   - %@", NSStringFromCGPoint(point), indexPath);
}

- (BOOL)dragCellCollectionView:(BMDragCellCollectionView *)dragCellCollectionView endedDragAutomaticOperationAtPoint:(CGPoint)point section:(NSInteger)section indexPath:(NSIndexPath *)indexPath {
    if (section == 1) {
        // 如果拖到了第一组松开就移动 而且内部不自动处理
        [dragCellCollectionView dragMoveItemToIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
        return NO;
    }
    return YES;
}




@end
