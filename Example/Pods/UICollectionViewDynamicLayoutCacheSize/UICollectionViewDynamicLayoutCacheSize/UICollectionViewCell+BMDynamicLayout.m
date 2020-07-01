//    MIT License
//
//    Copyright (c) 2019 https://github.com/liangdahong
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

#import "UICollectionViewCell+BMDynamicLayout.h"
#import <objc/runtime.h>

static const void *cellRegisteredKey = &cellRegisteredKey;

@implementation UICollectionViewCell (BMDynamicLayout)

- (BOOL)bm_maxXViewFixed {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setBm_maxXViewFixed:(BOOL)bm_maxXViewFixed {
    objc_setAssociatedObject(self, @selector(bm_maxXViewFixed), @(bm_maxXViewFixed), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)bm_maxYViewFixed {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setBm_maxYViewFixed:(BOOL)bm_maxYViewFixed {
    objc_setAssociatedObject(self, @selector(bm_maxYViewFixed), @(bm_maxYViewFixed), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


+ (instancetype)bm_collectionViewCellFromNibWithCollectionView:(UICollectionView *)collectionView
                                                  forIndexPath:(NSIndexPath *)indexPath {
    return [self bm_collectionViewCellWithCollectionView:collectionView isNib:YES forIndexPath:indexPath];
}

+ (instancetype)bm_collectionViewCellFromAllocWithCollectionView:(UICollectionView *)collectionView
                                                    forIndexPath:(NSIndexPath *)indexPath {
    return [self bm_collectionViewCellWithCollectionView:collectionView isNib:NO forIndexPath:indexPath];
}

+ (instancetype)bm_collectionViewCellWithCollectionView:(UICollectionView *)collectionView
                                                  isNib:(BOOL)isNib
                                           forIndexPath:(NSIndexPath *)indexPath {
    NSString *selfClassName = NSStringFromClass(self.class);
    NSString *reuseIdentifier = [selfClassName stringByAppendingString:@"CellViewReuseIdentifier"];
    BOOL registerCell = [objc_getAssociatedObject(collectionView, cellRegisteredKey) boolValue];
    if (registerCell) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    }
    objc_setAssociatedObject(collectionView, cellRegisteredKey, @(YES) , OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (!isNib) {
        // 注册
        [collectionView registerClass:self.class forCellWithReuseIdentifier:reuseIdentifier];
        // 取 cell
        return [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    }

    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSString *path = [bundle pathForResource:selfClassName ofType:@"nib"];
    if (path.length == 0) {
        NSAssert(NO, @"你的 UICollectionViewCell 不是 IB 创建的");
        return nil;
    }
    // 注册
    [collectionView registerNib:[UINib nibWithNibName:selfClassName bundle:bundle] forCellWithReuseIdentifier:reuseIdentifier];
    // 取 cell
    return [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
}
@end
