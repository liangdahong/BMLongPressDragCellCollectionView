//
//  RootViewController.m
//  Test
//
//  Created by Denny on 2018/5/17.
//  Copyright © 2018年 Denny. All rights reserved.
//
#define SCREEN_BOUNDS       ([[UIScreen mainScreen] bounds])
#define SCREEN_WIDTH        CGRectGetWidth(SCREEN_BOUNDS)

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.addPhotoView];
    self.view.backgroundColor = [UIColor redColor];
}

- (AddPhotoView *)addPhotoView {
    if (!_addPhotoView) {
        _addPhotoView = [[AddPhotoView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 300)];
        _addPhotoView.dataSourceArray = [@[@"http://h.pz.com/u/7633/122/2/152652120213.png",
                                               @"http://h.pz.com/u/7633/123/5/15265229756.png",
                                               @"http://h.pz.com/u/7633/123/5/15265229755.png",
                                               @"http://h.pz.com/u/7633/124/1/152652305831.png",
                                               @"http://h.pz.com/u/7633/124/1/152652315975.png",
                                               @"http://h.pz.com/u/7633/124/1/152652315991.png"
                                               ] mutableCopy];
    }
    return _addPhotoView;
}


@end
