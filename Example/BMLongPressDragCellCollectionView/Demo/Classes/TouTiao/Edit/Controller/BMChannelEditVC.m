//
//  BMChannelEditVC.m
//  ToutiaoDemo
//
//  Created by ___liangdahong on 2017/12/11.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMChannelEditVC.h"
#import "BMChannelEditCell.h"
#import "BMChannelModel.h"
#import <BMLongPressDragCellCollectionView/BMLongPressDragCellCollectionView.h>
#import <BlocksKit/UIBarButtonItem+BlocksKit.h>
#import <SVProgressHUD/SVProgressHUD.h>
#import "UICollectionView+BMRect.h"
#import <Masonry/Masonry.h>

@interface BMChannelEditVC () <BMLongPressDragCellCollectionViewDataSource, BMLongPressDragCellCollectionViewDelegate>

@property (weak, nonatomic) IBOutlet BMLongPressDragCellCollectionView *dragCellCollectionView;
/// collectionViewFlowLayout
@property (nonatomic, strong) UICollectionViewFlowLayout *collectionViewFlowLayout;
/// editButtonItem
@property (nonatomic, strong) UIBarButtonItem *editButtonItem;
/// edit
@property (nonatomic, assign, getter=isEdit) BOOL edit;

@property (nonatomic, strong) UILabel *statusLabel; ///< statusLabel

@end

static NSString *kBMChannelEditCell = @"kBMChannelEditCell";

@implementation BMChannelEditVC

- (instancetype)init {
    if (self = [super init]) {
        _edit = YES;
    }
    return self;
}

- (UICollectionViewFlowLayout *)collectionViewFlowLayout {
    if (!_collectionViewFlowLayout) {
        _collectionViewFlowLayout = ({
            UICollectionViewFlowLayout *collectionViewFlowLayout = [UICollectionViewFlowLayout new];
            collectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionVertical;
            collectionViewFlowLayout.minimumLineSpacing = 1;
            collectionViewFlowLayout.minimumInteritemSpacing = 1;
            collectionViewFlowLayout.itemSize = CGSizeMake((CGRectGetWidth([UIScreen mainScreen].bounds)-4)/4.0, 55);
            collectionViewFlowLayout.headerReferenceSize = CGSizeMake(100, 40);
            collectionViewFlowLayout;
        });
    }
    return _collectionViewFlowLayout;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"频道编辑";
    self.dragCellCollectionView.dragCellAlpha = 0.9;
    self.dragCellCollectionView.collectionViewLayout = self.collectionViewFlowLayout;
    self.dragCellCollectionView.alwaysBounceVertical = YES;
    [self.dragCellCollectionView registerNib:[UINib nibWithNibName:NSStringFromClass(BMChannelEditCell.class) bundle:nil] forCellWithReuseIdentifier:kBMChannelEditCell];
    __weak typeof(self) weakSelf = self;
    self.editButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"编辑" style:UIBarButtonItemStylePlain handler:^(id sender) {
        __strong typeof(weakSelf) self = weakSelf;
        self.edit = !self.edit;
        if (self.isEdit) {
            self.dragCellCollectionView.canDrag = YES;
            self.editButtonItem.title = @"编辑";
        } else {
            self.editButtonItem.title = @"退出编辑";
            self.dragCellCollectionView.canDrag = NO;
        }
        [self.dragCellCollectionView reloadData];
    }];
    self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.editButtonItem.title = @"退出编辑";
    self.dragCellCollectionView.canDrag = YES;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"完成" style:UIBarButtonItemStylePlain handler:^(id sender) {
        __strong typeof(weakSelf) self = weakSelf;
        !self.editCompleteBlock ? : self.editCompleteBlock(self.channelModelArray);
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }];

    [self.view addSubview:self.statusLabel];
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    self.statusLabel.hidden = YES;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.channelModelArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channelModelArray[section].count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    BMChannelEditCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kBMChannelEditCell forIndexPath:indexPath];
    BMChannelModel *model = self.channelModelArray[indexPath.section][indexPath.row];
    // 删除按钮点击
    __weak typeof(self) weakSelf = self;
    cell.block = ^(UICollectionViewCell *cell) {
        __strong typeof(self) self = weakSelf;
        [self collectionView:collectionView didSelectItemAtIndexPath:[collectionView indexPathForCell:cell]];
    };

    // 这里需集合业务修改 调整代码
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.removeButton.hidden = YES;
            cell.titleLabel.text = model.title;
        } else {
            cell.removeButton.hidden = !self.isEdit;
            cell.titleLabel.text = model.title;
        }
    } else {
        cell.removeButton.hidden = YES;
        if (self.isEdit) {
            cell.titleLabel.text = [NSString stringWithFormat:@"+ %@", model.title];
        } else {
            cell.titleLabel.text = model.title;
        }
    }
    // 这里需集合业务修改 调整代码
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 && indexPath.item == 0) {
//        [SVProgressHUD showSuccessWithStatus:self.channelModelArray[indexPath.section][indexPath.row].title];
        // 如果点击的是推荐
        return ;
    }
    if (!self.isEdit) {
        // 非编辑状态下
//        [SVProgressHUD showSuccessWithStatus:self.channelModelArray[indexPath.section][indexPath.row].title];
        return;
    }
    
    if (indexPath.section == 0) {
        // 删除操作
        BMChannelModel *model = self.channelModelArray[indexPath.section][indexPath.row];
        BMChannelEditCell *cell = (BMChannelEditCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.removeButton.hidden = YES;
        cell.titleLabel.text = [NSString stringWithFormat:@"+ %@", model.title];
        NSMutableArray *secArray0 = self.channelModelArray[indexPath.section];
        [secArray0 removeObject:model];
        NSMutableArray *secArray1 = self.channelModelArray[1];
        [secArray1 addObject:model];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:secArray1.count-1 inSection:1]];
    } else {
        // 添加操作
        BMChannelModel *model = self.channelModelArray[indexPath.section][indexPath.row];
        BMChannelEditCell *cell = (BMChannelEditCell *)[collectionView cellForItemAtIndexPath:indexPath];
        cell.removeButton.hidden = NO;
        cell.titleLabel.text = model.title;
        NSMutableArray *secArray1 = self.channelModelArray[1];
        [secArray1 removeObject:model];
        NSMutableArray *secArray0 = self.channelModelArray[0];
        [secArray0 addObject:model];
        [collectionView moveItemAtIndexPath:indexPath toIndexPath:[NSIndexPath indexPathForItem:secArray0.count-1 inSection:0]];
    }
}

#pragma mark - BMLongPressDragCellCollectionViewDataSource

- (NSArray *)dataSourceWithDragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView {
    return self.channelModelArray;
}

#pragma mark - BMLongPressDragCellCollectionViewDelegate

/// 将要开始拖拽时，询问此位置的 Cell 是否能拖拽
- (BOOL)dragCellCollectionViewShouldBeginMove:(BMLongPressDragCellCollectionView *)dragCellCollectionView indexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        // 如果是第二组  不允许拖拽
        return NO;
    }
    if (indexPath.section == 0 && indexPath.item == 0) {
        // 如果是推荐Cell 不允许拖拽
        return NO;
    }
    return YES;
}

/// 正在拖拽时
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView changedDragAtPoint:(CGPoint)point {
    CGRect rect = [dragCellCollectionView bm_rectForSection:1];
    if (point.y > CGRectGetMinY(rect)) {
        // 松手自动移动到第 2 组
        self.statusLabel.hidden = NO;
    } else {
        self.statusLabel.hidden = YES;
    }
}

/// cell 将要交换时，询问是否能交换
- (BOOL)dragCellCollectionViewShouldBeginExchange:(BMLongPressDragCellCollectionView *)dragCellCollectionView sourceIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    if (destinationIndexPath.row == 0 && destinationIndexPath.section == 0) {
        // 如果拖拽到推荐 cell 不允许交换
        return NO;
    }
    if (sourceIndexPath.section == destinationIndexPath.section) {
        // 如果是相同组才可以交换（第一组的cell之间）
        return YES;
    }
    return NO;
}

///  Cell 有交换时调用
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(NSArray *)newDataArray {
    self.channelModelArray = [newDataArray mutableCopy];
}

/// 结束拖拽时
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView endedDragAtPoint:(CGPoint)point {
    CGRect rect = [dragCellCollectionView bm_rectForSection:1];
    if (point.y > CGRectGetMinY(rect)) {
        [dragCellCollectionView dragMoveItemToIndexPath:[NSIndexPath indexPathForItem:0 inSection:1]];
    }
    self.statusLabel.hidden = YES;
}

- (UILabel *)statusLabel {
    if (!_statusLabel) {
        UILabel *label = [UILabel new];
        label.backgroundColor = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:.88];
        label.text = @"松手自动移动到第 2 组";
        label.textColor = UIColor.whiteColor;
        label.font = [UIFont boldSystemFontOfSize:17];
        [label setTextAlignment:(NSTextAlignmentCenter)];
        _statusLabel = label;
    }
    return _statusLabel;
}

@end
