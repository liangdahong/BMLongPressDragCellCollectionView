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

#import "UIViewController+AMLeaksFinderSwizzleViewDidLoad.h"
#import "UIViewController+AMLeaksFinderUI.h"
#import "UIViewController+AMLeaksFinderTools.h"
#import "AMMemoryLeakModel.h"
#import <objc/runtime.h>

static const void *associatedKey = &associatedKey;

@implementation UIViewController (AMLeaksFinderSwizzleViewDidLoad)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        amleaks_finder_swizzleInstanceMethod(self.class,
                              @selector(viewDidLoad),
                              @selector(amleaks_finder_viewDidLoad));
        
    });
}

- (void)amleaks_finder_viewDidLoad {
    [self amleaks_finder_viewDidLoad];
    AMMemoryLeakDeallocModel *deallocModel = objc_getAssociatedObject(self, associatedKey);
    if (deallocModel) {
        return;
    }
    deallocModel = AMMemoryLeakDeallocModel.new;
    objc_setAssociatedObject(self, associatedKey, deallocModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    deallocModel.controller = self;

    // memoryLeakModel
    AMMemoryLeakModel *memoryLeakModel = AMMemoryLeakModel.new;
    memoryLeakModel.memoryLeakDeallocModel = deallocModel;
    [UIViewController.memoryLeakModelArray insertObject:memoryLeakModel atIndex:0];

    // update ui
    [UIViewController udpateUI];
    NSLog(@"hook  : %@ %@", self, NSStringFromSelector(_cmd));
}

@end
