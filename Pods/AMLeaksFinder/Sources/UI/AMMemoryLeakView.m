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

#import "AMMemoryLeakView.h"
#import "UIViewController+AMLeaksFinderUI.h"
#import "UIViewController+AMLeaksFinderTools.h"

#if __has_include(<FBRetainCycleDetector/FBRetainCycleDetector.h>)
    #import <FBRetainCycleDetector/FBRetainCycleDetector.h>
#elif __has_include("FBRetainCycleDetector")
    #import "FBRetainCycleDetector.h"
#endif

@interface AMMemoryLeakView () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) IBOutlet UIButton *leaksButton;
@property (nonatomic, copy) NSArray <AMMemoryLeakModel *> *dataSourceArray;
@property (nonatomic, assign, getter=isShowAll) BOOL showAll; ///< 是否选中全部控制器
@property (nonatomic, assign) CGPoint oldPoint; ///< oldPoint

@end

@implementation AMMemoryLeakView

- (void)awakeFromNib {
    [super awakeFromNib];
    [self initUI];
}

#pragma mark - init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (IBAction)showAllButtonClick {
    self.showAll = YES;
    self.dataSourceArray = self.memoryLeakModelArray;
}

- (IBAction)showLeakButtonClick {
    self.showAll = NO;
    NSMutableArray <AMMemoryLeakModel *> *arr = @[].mutableCopy;
    [self.memoryLeakModelArray enumerateObjectsUsingBlock:^(AMMemoryLeakModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.memoryLeakDeallocModel.shouldDealloc) {
            [arr addObject:obj];
        }
    }];
    self.dataSourceArray = arr;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSourceArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [UITableViewCell new];
    cell.textLabel.text = NSStringFromClass(self.dataSourceArray[indexPath.row].memoryLeakDeallocModel.controller.class);
    AMMemoryLeakDeallocModel *model = self.dataSourceArray[indexPath.row].memoryLeakDeallocModel;
    if (model.shouldDealloc) {
        cell.textLabel.textColor = [UIColor redColor];
        [cell setAccessoryType:(UITableViewCellAccessoryDisclosureIndicator)];
    } else {
        cell.textLabel.textColor = [UIColor blackColor];
        [cell setAccessoryType:(UITableViewCellAccessoryNone)];
    }
    cell.textLabel.font = [UIFont systemFontOfSize:10];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 20;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    AMMemoryLeakDeallocModel *model = self.dataSourceArray[indexPath.row].memoryLeakDeallocModel;
    if (model.shouldDealloc) {
        UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"是否忽略此控制器" message:[NSString stringWithFormat:@"如果控制器是特意长驻内存的，可以点击忽略 \n\n[%@]", model.controller] preferredStyle:UIAlertControllerStyleAlert];
        [alertVC addAction:[UIAlertAction actionWithTitle:@"忽略此控制器" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [UIViewController.memoryLeakModelArray enumerateObjectsUsingBlock:^(AMMemoryLeakModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                if (obj.memoryLeakDeallocModel == model) {
                    [UIViewController.memoryLeakModelArray removeObjectAtIndex:idx];
                    [UIViewController udpateUI];
                    *stop = YES;
                }
            }];
        }]];
        
#if __has_include(<FBRetainCycleDetector/FBRetainCycleDetector.h>)
        
        [alertVC addAction:[UIAlertAction actionWithTitle:@"查看控制器的【所有强引用的对象】" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
            [detector addCandidate:model.controller];
            NSSet *retainCycles = [detector findRetainCyclesWithMaxCycleLength:100];
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:retainCycles.debugDescription preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"拷贝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIPasteboard generalPasteboard] setString:retainCycles.debugDescription];
            }]];
            NSLog(@"%@", retainCycles.debugDescription);
            [UIViewController.amleaks_finder_TopViewController presentViewController:alertVC animated:YES completion:nil];
        }]];
        
#elif __has_include("FBRetainCycleDetector")
        
        [alertVC addAction:[UIAlertAction actionWithTitle:@"查看控制器的【所有强引用的对象】" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            FBRetainCycleDetector *detector = [FBRetainCycleDetector new];
            [detector addCandidate:model.controller];
            NSSet *retainCycles = [detector findRetainCyclesWithMaxCycleLength:100];
            UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:nil message:retainCycles.debugDescription preferredStyle:UIAlertControllerStyleAlert];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
            [alertVC addAction:[UIAlertAction actionWithTitle:@"拷贝" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIPasteboard generalPasteboard] setString:retainCycles.debugDescription];
            }]];
            NSLog(@"%@", retainCycles.debugDescription);
            [UIViewController.amleaks_finder_TopViewController presentViewController:alertVC animated:YES completion:nil];
        }]];
        
#else
        
        [alertVC addAction:[UIAlertAction actionWithTitle:@"查看强引用的对象【需导入 FBRetainCycleDetector】" style:UIAlertActionStyleDefault handler:nil]];
        
#endif
        [alertVC addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [UIViewController.amleaks_finder_TopViewController presentViewController:alertVC animated:YES completion:nil];
    }
}

- (void)setMemoryLeakModelArray:(NSArray<AMMemoryLeakView *> *)memoryLeakModelArray {
    _memoryLeakModelArray = memoryLeakModelArray.copy;
    self.dataSourceArray = memoryLeakModelArray.copy;
    [self.tableView reloadData];
}

- (void)setDataSourceArray:(NSArray<AMMemoryLeakModel *> *)dataSourceArray {
    if (self.isShowAll) {
        _dataSourceArray = dataSourceArray.copy;
    } else {
        NSMutableArray <AMMemoryLeakModel *> *arr = @[].mutableCopy;
        [self.memoryLeakModelArray enumerateObjectsUsingBlock:^(AMMemoryLeakModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.memoryLeakDeallocModel.shouldDealloc) {
                [arr addObject:obj];
            }
        }];
        _dataSourceArray = arr.copy;
    }
    [self.tableView reloadData];
}

#pragma mark - 私有方法

- (void)initUI {
    
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSURL *url = [bundle URLForResource:@"AMLeaksFinder" withExtension:@"bundle"];
    NSBundle *targetBundle = [NSBundle bundleWithURL:url];
    UIImage *allImage = [UIImage imageNamed:@"all"
                                inBundle:targetBundle
           compatibleWithTraitCollection:nil];
    [self.allButton setImage:allImage forState:(UIControlStateNormal)];
    
    UIImage *leaksImage = [UIImage imageNamed:@"leaks"
                                     inBundle:targetBundle
                compatibleWithTraitCollection:nil];
    [self.leaksButton setImage:leaksImage forState:(UIControlStateNormal)];

    self.layer.cornerRadius = 30;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    self.layer.masksToBounds = YES;
    self.tableView.layer.cornerRadius = 30;
    self.tableView.layer.masksToBounds = YES;
    [self addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureRecognizer:)]];
}

#pragma mark - 事件响应

- (void)panGestureRecognizer:(UIPanGestureRecognizer *)panGestureRecognizer {
    CGPoint point = [panGestureRecognizer locationInView:self.superview];
    switch (panGestureRecognizer.state) {
        case UIGestureRecognizerStateBegan:
            self.oldPoint = point;
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGRect frame = self.frame;
            frame.origin.y = (self.frame.origin.y + (point.y - self.oldPoint.y));
            frame.origin.x = (self.frame.origin.x + (point.x - self.oldPoint.x));
            self.oldPoint = point;
            self.frame = frame;
        }
            break;
        case UIGestureRecognizerStateEnded:
            break;
        default:
            break;
    }
}

@end
