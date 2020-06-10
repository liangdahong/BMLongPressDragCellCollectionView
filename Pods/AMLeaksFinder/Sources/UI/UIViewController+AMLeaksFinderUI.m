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

#import "UIViewController+AMLeaksFinderUI.h"
#import "AMMemoryLeakView.h"
#import "AMDragViewLabel.h"
#import "UIViewController+AMLeaksFinderTools.h"

static AMMemoryLeakView *memoryLeakView;
static AMDragViewLabel *dragViewLabel;

@implementation UIViewController (AMLeaksFinderUI)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dispatch_async(dispatch_get_main_queue(), ^(void) {
            
            NSBundle *bundle = [NSBundle bundleForClass:AMMemoryLeakView.class];
            memoryLeakView = [bundle loadNibNamed:NSStringFromClass(AMMemoryLeakView.class) owner:nil options:nil].firstObject;
            memoryLeakView.frame = CGRectMake(30, 60, 200, 300);
            memoryLeakView.hidden = YES;
            
            dragViewLabel = AMDragViewLabel.new;
            dragViewLabel.frame = CGRectMake(0, 100, 88, 88);
            dragViewLabel.layer.cornerRadius = 30;
            dragViewLabel.layer.masksToBounds = YES;
            dragViewLabel.textAlignment = NSTextAlignmentCenter;
            dragViewLabel.textColor = UIColor.redColor;
            dragViewLabel.font = [UIFont systemFontOfSize:12];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)),dispatch_get_main_queue(), ^{
                UIWindow *window = UIViewController.amleaks_finder_TopWindow;
                [window addSubview:memoryLeakView];
                [window addSubview:dragViewLabel];
                [dragViewLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDragClick)]];
            });
        });
    });
}

+ (void)tapDragClick {
    memoryLeakView.hidden = !memoryLeakView.isHidden;
}

+ (void)udpateUI {

    UIWindow *window = UIViewController.amleaks_finder_TopWindow;
    if (memoryLeakView.superview != window) {
        [window addSubview:memoryLeakView];
        [window addSubview:dragViewLabel];
    }
    
    [UIViewController.memoryLeakModelArray enumerateObjectsWithOptions:(NSEnumerationReverse) usingBlock:^(AMMemoryLeakModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (!obj.memoryLeakDeallocModel.controller) {
            [UIViewController.memoryLeakModelArray removeObjectAtIndex:idx];
        }
    }];
    
    __block int leakCount = 0;
    [UIViewController.memoryLeakModelArray enumerateObjectsUsingBlock:^(AMMemoryLeakModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.memoryLeakDeallocModel.shouldDealloc) {
            leakCount++;
        }
    }];
    NSString *str = [NSString stringWithFormat:@"泄漏:%d\n全部:%lu\n点击可切换\n(供参考)" ,
                     leakCount,
                     (unsigned long)UIViewController.memoryLeakModelArray.count];

    NSArray <NSString *> *strs = [str componentsSeparatedByString:@"\n"];
    NSMutableAttributedString *att = [[NSMutableAttributedString alloc] initWithString:str];

    [att setAttributes:@{
        NSForegroundColorAttributeName : UIColor.redColor,
    } range:NSMakeRange(0, strs.firstObject.length)];

    [att setAttributes:@{
        NSForegroundColorAttributeName : UIColor.orangeColor,
    } range:NSMakeRange(strs.firstObject.length+1, strs[1].length)];

    [att setAttributes:@{
        NSForegroundColorAttributeName : UIColor.greenColor,
    } range:NSMakeRange(strs.firstObject.length+1+strs[1].length+1, strs.lastObject.length)];
    
    dragViewLabel.attributedText = att;
    [memoryLeakView setMemoryLeakModelArray:UIViewController.memoryLeakModelArray];
}

@end
