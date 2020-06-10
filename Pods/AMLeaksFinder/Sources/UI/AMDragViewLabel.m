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

#import "AMDragViewLabel.h"

@interface AMDragViewLabel ()

@property (nonatomic, assign) CGPoint oldPoint; ///< oldPoint

@end

@implementation AMDragViewLabel

#pragma mark -

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

#pragma mark - 私有方法

- (void)initUI {
    self.numberOfLines = 0;
    self.userInteractionEnabled = YES;
    self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3];
    self.font = [UIFont boldSystemFontOfSize:20];
    self.adjustsFontSizeToFitWidth = YES;
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
