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
    
    label._._._.ld_tag(1);
    UIButton *button = [UIButton new];
    button.ld_title(@"1",1).ld_titleShadowColor([UIColor redColor],1).ld_attributedTitle(nil,1);
    
    label.ld_x(100);
    label.ld_y(100);
    label.ld_origin(CGPointMake(0, 0));
    label.ld_size(CGSizeMake(100, 100));
    
    
    label.ld_x(100).ld_width(100).ld_height(100);
    label.ld_x(100).ld_y(0).ld_width(100).stop.ld_height(100);
}

@end
