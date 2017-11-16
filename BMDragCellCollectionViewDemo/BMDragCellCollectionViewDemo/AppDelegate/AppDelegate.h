//
//  AppDelegate.h
//  BMDragCellCollectionViewDemo
//
//  Created by __liangdahong on 2017/7/17.
//  Copyright © 2017年 http://idhong.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

// nullable 属性 可nil
// nonnull  属性 非nil

// __nullable 变量 可nil
// __nonnull  变量 非nil

// null_resettable setter nullable  、 getter nonnull

// 全部加上
// NS_ASSUME_NONNULL_BEGIN
// NS_ASSUME_NONNULL_END
@property (strong, nonatomic, nullable) UIWindow *window;
@property (strong, null_resettable) NSArray  *a; // 默认：nonnull


@end

