//
//  BMHomeVC.m
//  ToutiaoDemo
//
//  Created by ___liangdahong on 2017/12/11.
//  Copyright © 2017年 ___liangdahong. All rights reserved.
//

#import "BMHomeVC.h"
#import "BMChannelEditVC.h"
#import "BMChannelVC.h"
#import "BMChannelModel.h"
#import <BlocksKit/UIBarButtonItem+BlocksKit.h>

@interface BMHomeVC ()

@property (nonatomic, strong) NSMutableArray <NSMutableArray <BMChannelModel *> *> *channelModelArray; ///< channelModelArray

@end

@implementation BMHomeVC

- (instancetype)init {
    if (self = [super init]) {
        self.menuHeight         = 44.0f;
        self.progressWidth      = 40.0f;
        self.progressHeight     = 05.0f;
        self.titleSizeNormal    = 14.0f;
        self.titleSizeSelected  = 14.0f;
        self.menuViewStyle      = WMMenuViewStyleLine;
        self.titleColorNormal   = [UIColor blackColor];
        self.titleColorSelected = [UIColor redColor];
        self.menuBGColor        = [UIColor whiteColor];
        self.progressColor      = [UIColor redColor];
    }
    return self;
}

#pragma mark - Getters Setters

- (NSMutableArray<NSMutableArray<BMChannelModel *> *> *)channelModelArray {
    if (!_channelModelArray) {
        _channelModelArray = [@[] mutableCopy];
        int arc = 0;
        {
            NSMutableArray *quickArr = @[].mutableCopy;
            BMChannelModel *model = [BMChannelModel new];
            model.title = @"推荐";
            model.clas  = [BMChannelVC class];
            [quickArr addObject:model];
            while (arc < 10) {
                BMChannelModel *model = [BMChannelModel new];
                model.title = [NSString stringWithFormat:@"功能%d", arc];
                model.clas  = [BMChannelVC class];
                [quickArr addObject:model];
                arc++;
            }
            [_channelModelArray addObject:quickArr];
        }
        {
            NSMutableArray *quickArr = @[].mutableCopy;
            while (arc < 50) {
                BMChannelModel *model = [BMChannelModel new];
                model.title = [NSString stringWithFormat:@"功能%d", arc];
                model.clas  = [BMChannelVC class];
                [quickArr addObject:model];
                arc++;
            }
            [_channelModelArray addObject:quickArr];
        }
    }
    return _channelModelArray;
}

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"今日头条";
    __weak typeof(self) weakSelf = self;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] bk_initWithTitle:@"去编辑" style:UIBarButtonItemStylePlain handler:^(id sender) {
        __strong typeof(weakSelf) self = weakSelf;
        BMChannelEditVC *vc = [BMChannelEditVC new];
        vc.editCompleteBlock = ^(NSMutableArray<NSMutableArray<BMChannelModel *> *> *channelModelArray) {
            __strong typeof(weakSelf) self = weakSelf;
            self.channelModelArray = channelModelArray;
            [self reloadData];
        };
        vc.channelModelArray = self.channelModelArray.mutableCopy;
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:vc];
        navigationController.navigationBar.hidden = NO;
        navigationController.navigationBar.translucent = NO;
        navigationController.modalPresentationStyle = UIModalPresentationFullScreen;
        [self.navigationController presentViewController:navigationController animated:YES completion:nil];
    }];
}

#pragma mark - WMPageControllerDataSource

- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.channelModelArray[0].count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    return self.channelModelArray[0][index].title;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    return self.channelModelArray[0][index].clas.new;
}

@end
