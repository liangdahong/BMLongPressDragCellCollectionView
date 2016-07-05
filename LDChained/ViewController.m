//
//  ViewController.m
//  LDChained
//
//  Created by Daredos on 16/7/4.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "ViewController.h"
#import "Masonry.h"
#import "LDChained.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *label = [UILabel new];
    [self.view addSubview:label];

    // 这样是可以的.
    label.ld_text(@"123").ld_textAlignment(1).ld_textColor([UIColor orangeColor]).ld_frame(CGRectMake(100, 100, 100, 20)).ld_backgroundColor([UIColor grayColor]);

    //  如果先调 view 的方法就没办法在调label的方法
    //  {{{{{{{ 因为每一个点语法返回他自己 使用先调view时返回view 类型 就不可以调labl 的方法了 想用什么方法处理一下
    label.ld_frame(CGRectMake(100, 100, 100, 20)).ld_backgroundColor([UIColor grayColor]);
    label.ld_text(@"123").ld_textAlignment(1).ld_textColor([UIColor orangeColor]);
}

@end
