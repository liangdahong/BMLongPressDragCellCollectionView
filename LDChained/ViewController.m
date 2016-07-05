//
//  ViewController.m
//  LDChained
//
//  Created by Daredos on 16/7/4.
//  Copyright © 2016年 LiangDahong. All rights reserved.
//

#import "ViewController.h"
#import "LDChained.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel *label = [UILabel new];
    [self.view addSubview:label];
#if 0
    label.text = @"123";
    label.textAlignment = 1;
    label.textColor = [UIColor orangeColor];
    label.font = [UIFont systemFontOfSize:15];
    label.frame = CGRectMake(100, 100, 100, 20);
    label.backgroundColor = [UIColor grayColor];
#else
    // 这样是可以的.
    label.ld_text(@"123").ld_textAlignment(1).ld_textColor([UIColor orangeColor]).ld_font([UIFont systemFontOfSize:15]).ld_frame(CGRectMake(100, 100, 100, 20)).ld_backgroundColor([UIColor grayColor]);
#endif


}

@end
