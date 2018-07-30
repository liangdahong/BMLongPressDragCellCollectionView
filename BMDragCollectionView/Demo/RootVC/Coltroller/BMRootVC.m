//
//  BMRootVC.m
//  BMDragCellCollectionViewDemo
//
//  Created by ___liangdahong on 2017/8/22.
//  Copyright © 2017年 https://liangdahong.com All rights reserved.
//

#import "BMRootVC.h"
#import "BMModel.h"
#import "UITableViewCell+BMReusable.h"
#import "BMTodayHeadlinesDragVC.h"
#import "BMDragCellCollectionViewVC.h"
#import "BMAlipayVC.h"
#import "BMImageVC.h"

@interface BMRootVC () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray <NSArray<BMModel *>*> *modelArray; ///< modelArray

@end

@implementation BMRootVC

#pragma mark -

#pragma mark - 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"拖拽重排";
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
}

#pragma mark - getters setters

- (NSArray<NSArray<BMModel *> *> *)modelArray {
    if (!_modelArray) {
        _modelArray = @[
                        @[
                            [BMModel modelWithTitle:@"支付宝" selector:@selector(alipayDragMoreScreenWithModel:)]
                            ],
                        @[
                            [BMModel modelWithTitle:@"今日头条（超过一屏）" selector:@selector(todayHeadlinesDragMoreScreenWithModel:)],
                            [BMModel modelWithTitle:@"今日头条（不足一屏）" selector:@selector(todayHeadlinesDragWithModel:)]
                          ],
                        @[
                            [BMModel modelWithTitle:@"腾讯新闻（超过一屏）" selector:nil],
                            [BMModel modelWithTitle:@"腾讯新闻（不足一屏）" selector:nil]
                            ],
                        @[
                            [BMModel modelWithTitle:@"看荐（超过一屏）" selector:nil],
                            [BMModel modelWithTitle:@"看荐（不足一屏）" selector:nil]
                            ],
                        @[
                            [BMModel modelWithTitle:@"QQ表情" selector:@selector(imageDragWithModel:)]
                            ],
                        @[
                            [BMModel modelWithTitle:@"size相同，单组" selector:@selector(etcSizeSingleWithModel:)],
                            [BMModel modelWithTitle:@"size相同，多组" selector:@selector(etcSizeMultipleWithModel:)],
                            ],
                        @[
                            [BMModel modelWithTitle:@"size不同，单组" selector:@selector(noEtcSizeSingleWithModel:)],
                            [BMModel modelWithTitle:@"size不同，多组" selector:@selector(noEtcSizeMultipleWithModel:)]
                            ]
                        ];
    }
    return _modelArray;
}

#pragma mark - 系统delegate

#pragma mark - UITableViewDataSource UITableViewDelegate
#pragma mark - UITableViewDataSource UITableViewDelegate

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.modelArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.modelArray[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell bm_cellWithTableView:tableView];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    BMModel *model = self.modelArray[indexPath.section][indexPath.row];
    cell.textLabel.text = model.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    BMModel *model = self.modelArray[indexPath.section][indexPath.row];
    if (!model.selector) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Demo 未完成" message:nil preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
    [self performSelector:model.selector withObject:model];
#pragma clang diagnostic pop
}

#pragma mark - UITableViewDelegate

#pragma mark - 自定义delegate

#pragma mark - 公有方法

#pragma mark - 私有方法

#pragma mark - 支付宝

- (void)alipayDragMoreScreenWithModel:(BMModel *)mdoel {
    BMAlipayVC *vc = [BMAlipayVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 今日头条

- (void)todayHeadlinesDragMoreScreenWithModel:(BMModel *)mdoel {
    BMTodayHeadlinesDragVC *vc = [BMTodayHeadlinesDragVC new];
    vc.count = 30;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)todayHeadlinesDragWithModel:(BMModel *)mdoel {
    BMTodayHeadlinesDragVC *vc = [BMTodayHeadlinesDragVC new];
    vc.count = 10;
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 腾讯新闻

#pragma mark - 看荐

#pragma mark - 表情

- (void)imageDragWithModel:(BMModel *)mdoel {
    BMImageVC *vc = [BMImageVC new];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - size相同

- (void)etcSizeSingleWithModel:(BMModel *)mdoel {
    NSValue *sizeObj = [NSValue valueWithCGSize:CGSizeMake(arc4random_uniform(2) * 30 +50, arc4random_uniform(2) * 30 +50)];
    [self pushWithGroup:1 sizeObj:sizeObj];
}

- (void)etcSizeMultipleWithModel:(BMModel *)mdoel {
    NSValue *sizeObj = [NSValue valueWithCGSize:CGSizeMake(arc4random_uniform(2) * 30 +50, arc4random_uniform(2) * 30 +50)];
    [self pushWithGroup:5 sizeObj:sizeObj];
}

#pragma mark - size不同

- (void)noEtcSizeSingleWithModel:(BMModel *)mdoel {
    [self pushWithGroup:1 sizeObj:nil];
}

- (void)noEtcSizeMultipleWithModel:(BMModel *)mdoel {
    [self pushWithGroup:5 sizeObj:nil];
}

#pragma mark - size相同 size不同 的其他方法

- (void)pushWithGroup:(int)group sizeObj:(NSValue *)sizeObj {
    NSMutableArray *dataSourceArray = [NSMutableArray array];
    int arc = group;
    while (arc--) {
        NSMutableArray *dataSource = [NSMutableArray array];
        int arcCount = arc4random_uniform(40)+40;
        for (int i = 1; i <= arcCount; i++) {
            UIColor *color = [UIColor colorWithHue:arc4random_uniform(128)/255.0 + 0.5 saturation:arc4random_uniform(128)/255.0 + 0.5  brightness:arc4random_uniform(128)/255.0 + 0.5  alpha:1];
            [dataSource addObject:@{@"color" : color,
                                    @"title" : [NSString stringWithFormat:@"%d", i],
                                    @"size" : sizeObj ? sizeObj : [NSValue valueWithCGSize:CGSizeMake(arc4random_uniform(5) * 30 +50, arc4random_uniform(5) * 30 +50)]}];
        }
        [dataSourceArray addObject:dataSource];
    }
    [self pushVCWithArray:dataSourceArray];
}

- (void)pushVCWithArray:(NSArray *)array {
    BMDragCellCollectionViewVC *vc = [BMDragCellCollectionViewVC new];
    vc.dataSource = [array mutableCopy];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"请选择布局方向" message:nil preferredStyle:0];
    [alert addAction:[UIAlertAction actionWithTitle:@"垂直方向" style:0 handler:^(UIAlertAction * _Nonnull action) {
        vc.title = @"垂直方向";
        vc.collectionViewScrollDirection = UICollectionViewScrollDirectionVertical;
        [self.navigationController pushViewController:vc animated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"水平方向" style:0 handler:^(UIAlertAction * _Nonnull action) {
        vc.title = @"水平方向";
        vc.collectionViewScrollDirection = UICollectionViewScrollDirectionHorizontal;
        [self.navigationController pushViewController:vc animated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:YES];
    }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 事件响应

@end
