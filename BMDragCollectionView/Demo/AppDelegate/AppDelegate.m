//
//  AppDelegate.m
//  BMDragCellCollectionViewDemo
//
//  Created by __liangdahong on 2017/7/17.
//  Copyright © 2017年 https://liangdahong.com All rights reserved.
//

#import "AppDelegate.h"
#import "BMRootVC.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:[BMRootVC new]];
    nav.navigationBar.translucent = NO;
    nav.navigationBar.hidden = NO;
    self.window.rootViewController = nav;
    return YES;
}

@end
