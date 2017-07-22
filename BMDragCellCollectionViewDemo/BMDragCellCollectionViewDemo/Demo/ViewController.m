//
//  ViewController.m
//  BMDragCellCollectionViewDemo
//
//  Created by __liangdahong on 2017/7/21.
//  Copyright © 2017年 http://idhong.com. All rights reserved.
//

#import "ViewController.h"
#import "BMDragCellCollectionViewVC.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = NO;
    self.navigationController.navigationBar.translucent = NO;
}

- (IBAction)identicalSizeSingleGroupButtonClick:(id)sender {
    NSValue *sizeObj = [NSValue valueWithCGSize:CGSizeMake(arc4random_uniform(2) * 30 +50, arc4random_uniform(2) * 30 +50)];
    [self pushWithGroup:1 sizeObj:sizeObj];
}

- (IBAction)didenticalSizeSingleGroupButtonClick:(id)sender {
    [self pushWithGroup:1 sizeObj:nil];
}

- (IBAction)identicalSizeMoreGroupButtonClick:(id)sender {
    NSValue *sizeObj = [NSValue valueWithCGSize:CGSizeMake(arc4random_uniform(2) * 30 +50, arc4random_uniform(2) * 30 +50)];
    [self pushWithGroup:3 sizeObj:sizeObj];
}

- (IBAction)didenticalSizeMoreleGroupButtonClick:(id)sender {
    [self pushWithGroup:3 sizeObj:nil];
}


- (void)pushWithGroup:(int)group sizeObj:(NSValue *)sizeObj {
    NSMutableArray *dataSourceArray = [NSMutableArray array];
    int arc = group;
    while (arc--) {
        NSMutableArray *dataSource = [NSMutableArray array];
        int arcCount = arc4random_uniform(20)+10;
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
    [alert addAction:[UIAlertAction actionWithTitle:@"UICollectionViewScrollDirectionVertical" style:0 handler:^(UIAlertAction * _Nonnull action) {
        vc.title = @"垂直方向";
        vc.collectionViewScrollDirection = UICollectionViewScrollDirectionVertical;
        [self.navigationController pushViewController:vc animated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"UICollectionViewScrollDirectionHorizontal" style:0 handler:^(UIAlertAction * _Nonnull action) {
        vc.title = @"水平方向";
        vc.collectionViewScrollDirection = UICollectionViewScrollDirectionHorizontal;
        [self.navigationController pushViewController:vc animated:YES];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"cancel" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

@end
