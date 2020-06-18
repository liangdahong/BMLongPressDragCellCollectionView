//    MIT License
//
//    Copyright (c) 2019 https://liangdahong.com
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

#import "UICollectionView+BMRect.h"

@implementation UICollectionView (BMRect)

- (CGRect)bm_rectForSection:(NSInteger)section {
    NSInteger sectionNum = [self.dataSource collectionView:self numberOfItemsInSection:section];
    if (sectionNum <= 0) {
        return CGRectZero;
    };

    CGRect firstRect = [self bm_rectForRowAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:section]];
    CGRect lastRect  = [self bm_rectForRowAtIndexPath:[NSIndexPath indexPathForItem:sectionNum-1 inSection:section]];
    if (((UICollectionViewFlowLayout *)self.collectionViewLayout).scrollDirection == UICollectionViewScrollDirectionHorizontal) {
        return CGRectMake(CGRectGetMinX(firstRect),
                          0.0f,
                          CGRectGetMaxX(lastRect) - CGRectGetMinX(firstRect),
                          CGRectGetHeight(self.frame));
    } else {
        return CGRectMake(0.0f,
                          CGRectGetMinY(firstRect),
                          CGRectGetWidth(self.frame),
                          CGRectGetMaxY(lastRect) - CGRectGetMidY(firstRect));
    }
}

- (CGRect)bm_rectForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self layoutAttributesForItemAtIndexPath:indexPath].frame;
}

@end
