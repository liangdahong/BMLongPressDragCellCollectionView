//
//  ViewController.m
//  LDChained
//
//  Created by Daredos on 16/7/4.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "UIView+Chained.h"
#import "UILabel+Chained.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *view = [UIView new];
    [view ld_makeCollocation:^(LDCollocationMaker *make) {
        make.frameBlock(CGRectMake(0, 0, 100, 100)).and.with.and.tagBlock(1).backgroundColorBlock([UIColor orangeColor]).centerBlock(CGPointMake(0, 0));
    }];
    [self.view addSubview:view];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_offset(0);
    }];
    
    
    [view ld_makeCollocation:^(LDCollocationMaker *make) {
        
        make.frameBlock(CGRectMake(0, 0, 100, 100)).and.with.and.tagBlock(1).backgroundColorBlock([UIColor redColor]).centerBlock(CGPointMake(0, 0));
    }];
    
    UILabel *label = [UILabel new];
    [label ld_makeCollocationLabel:^(LDCollocationLabelMaker *make) {
        make
        .textBlock(@"123")
        .textColorBlock([UIColor redColor])
        .textAlignmentBlock(NSTextAlignmentCenter)
        .shadowColorBlock([UIColor blueColor])
        .backgroundColorBlock([UIColor orangeColor]);
    }];
    
    
    [label ld_makeCollocationLabel:^(LDCollocationLabelMaker *make) {
        make.textAlignmentBlock(2);
    }];
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_offset(100).and.left.mas_offset(100);
        make.size.mas_offset(CGSizeMake(100, 100));
    }];
}

@end
