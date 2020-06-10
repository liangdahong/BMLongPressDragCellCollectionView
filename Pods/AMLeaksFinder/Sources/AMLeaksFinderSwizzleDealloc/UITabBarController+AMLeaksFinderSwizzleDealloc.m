//    MIT License
//
//    Copyright (c) 2020 梁大红
//
//    Permission is hereby granted, free of charge, to any person obtaining a copy
//    of this software and associated documentation files (the "Software"), to deal
//    in the Software without restriction, including without limitation the rights
//    to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//    copies of the Software, and to permit persons to whom the Software is
//    furnished to do so, subject to the following conditions:
//
//    The above copyright notice and this permission notice shall be included in all
//    copies or substantial portions of the Software.
//
//    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//    AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//    OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//    SOFTWARE.

#import "UITabBarController+AMLeaksFinderSwizzleDealloc.h"
#import "UIViewController+AMLeaksFinderUI.h"
#import "UIViewController+AMLeaksFinderTools.h"

@implementation UITabBarController (AMLeaksFinderSwizzleDealloc)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        amleaks_finder_swizzleInstanceMethod(self.class,
                              @selector(setViewControllers:),
                              @selector(amleaks_finder_setViewControllers:));
        
        amleaks_finder_swizzleInstanceMethod(self.class,
                              @selector(setViewControllers:animated:),
                              @selector(amleaks_finder_setViewControllers:animated:));
    });
}

- (void)amleaks_finder_setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers {
    NSMutableArray <UIViewController *> *muarray = @[].mutableCopy;
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __block BOOL flag = NO;
        [viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            if (obj == obj1) {
                flag = YES;
                *stop1 = YES;
            }
        }];
        if (!flag) {
            [muarray addObject:obj];
        }
    }];
    [muarray enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 设置为将要释放
        [obj amleaks_finder_shouldDealloc];
    }];
    [self amleaks_finder_setViewControllers:viewControllers];
}

- (void)amleaks_finder_setViewControllers:(NSArray<__kindof UIViewController *> *)viewControllers animated:(BOOL)animated {
    NSMutableArray <UIViewController *> *muarray = @[].mutableCopy;
    [self.viewControllers enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        __block BOOL flag = NO;
        [viewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj1, NSUInteger idx1, BOOL * _Nonnull stop1) {
            if (obj == obj1) {
                flag = YES;
                *stop1 = YES;
            }
        }];
        if (!flag) {
            [muarray addObject:obj];
        }
    }];
    [muarray enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 设置为将要释放
        [obj amleaks_finder_shouldDealloc];
    }];
    [self amleaks_finder_setViewControllers:viewControllers animated:animated];
}

@end
