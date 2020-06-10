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

#import "UINavigationController+AMLeaksFinderSwizzleDealloc.h"
#import "UIViewController+AMLeaksFinderUI.h"
#import "UIViewController+AMLeaksFinderTools.h"

@implementation UINavigationController (AMLeaksFinderSwizzleDealloc)

+ (void)load {
    static dispatch_once_t onceToken; 
    dispatch_once(&onceToken, ^{
        amleaks_finder_swizzleInstanceMethod(self.class,
                              @selector(popViewControllerAnimated:),
                              @selector(amleaks_finder_popViewControllerAnimated:));

        amleaks_finder_swizzleInstanceMethod(self.class,
                              @selector(popToViewController:animated:),
                              @selector(amleaks_finder_popToViewController:animated:));

        amleaks_finder_swizzleInstanceMethod(self.class,
                              @selector(popToRootViewControllerAnimated:),
                              @selector(amleaks_finder_popToRootViewControllerAnimated:));

        amleaks_finder_swizzleInstanceMethod(self.class,
                              @selector(setViewControllers:),
                              @selector(amleaks_finder_setViewControllers:));
        
        amleaks_finder_swizzleInstanceMethod(self.class,
                              @selector(setViewControllers:animated:),
                              @selector(amleaks_finder_setViewControllers:animated:));
    });
}

- (void)amleaks_finder_setViewControllers:(NSArray<UIViewController *> *)viewControllers animated:(BOOL)animated {
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

- (UIViewController *)amleaks_finder_popViewControllerAnimated:(BOOL)animated {
    UIViewController *vc = [self amleaks_finder_popViewControllerAnimated:YES];
    // 设置为将要释放
    [vc amleaks_finder_shouldDealloc];
    return vc;
}

- (NSArray<UIViewController *> *)amleaks_finder_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
    NSArray *vcs = [self amleaks_finder_popToViewController:viewController animated:animated];
    [vcs enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 设置为将要释放
        [obj amleaks_finder_shouldDealloc];
    }];
    return vcs;
}

- (NSArray<UIViewController *> *)amleaks_finder_popToRootViewControllerAnimated:(BOOL)animated {
    NSArray <UIViewController *> *vcs = [self amleaks_finder_popToRootViewControllerAnimated:animated];
    [vcs enumerateObjectsUsingBlock:^(UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        // 设置为将要释放
        [obj amleaks_finder_shouldDealloc];
    }];
    return vcs;
}

@end
