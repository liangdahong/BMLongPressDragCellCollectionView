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

#import <UIKit/UIKit.h>
#import "AMMemoryLeakModel.h"

void amleaks_finder_swizzleInstanceMethod(Class class, SEL originalSelector, SEL swizzledSelector);

@interface UIViewController (AMLeaksFinderTools)

/// 全局管理控制器的 Array
@property (class, readonly) NSMutableArray <AMMemoryLeakModel *> *memoryLeakModelArray;
@property (class, readonly) __kindof UIViewController *amleaks_finder_TopViewController;
@property (class, readonly) __kindof UIWindow *amleaks_finder_TopWindow;

/// 控制器标记准备释放
- (void)amleaks_finder_shouldDealloc;
/// UIWindow 所有控制器标记为准备释放
+ (void)amleaks_finder_shouldAllDeallocBesidesController:(UIViewController *)controller window:(UIWindow *)window;

@end
