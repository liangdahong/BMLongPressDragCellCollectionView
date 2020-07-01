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

#import "UICollectionView+BMDynamicLayout.h"
#import "UICollectionView+BMPrivate.h"
#import "UICollectionViewDynamicLayoutCacheSize.h"
#import <objc/runtime.h>

#define kMaxHeightWidth 8888.0f

@interface UICollectionViewCell (BMDynamicLayoutPrivate)

@property (nonatomic, strong) UIView *dynamicLayout_maxXView;
@property (nonatomic, strong) UIView *dynamicLayout_maxYView;

@end

@implementation UICollectionViewCell (BMDynamicLayoutPrivate)

- (UIView *)dynamicLayout_maxXView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDynamicLayout_maxXView:(UIView *)dynamicLayout_maxXView {
    objc_setAssociatedObject(self, @selector(dynamicLayout_maxXView), dynamicLayout_maxXView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)dynamicLayout_maxYView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setDynamicLayout_maxYView:(UIView *)dynamicLayout_maxYView {
    objc_setAssociatedObject(self, @selector(dynamicLayout_maxYView), dynamicLayout_maxYView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end

void dynamicLayoutLayoutIfNeeded(UIView *view);
inline void dynamicLayoutLayoutIfNeeded(UIView *view) {
    // https://juejin.im/post/5a30f24bf265da432e5c0070
    // https://objccn.io/issue-3-5
    // http://tech.gc.com/demystifying-ios-layout
    [view setNeedsLayout];
    [view layoutIfNeeded];
}

@implementation UICollectionView (BMDynamicLayout)

#pragma mark - private

- (CGSize)_sizeWithCellClass:(Class)clas
                 cellMaxSize:(CGSize)size
               configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration {
    if (__builtin_expect((!self.isDynamicLayoutInitializationed), 0)) {
        [self bm_dynamicLayoutInitialization];
    }
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (!dict) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    NSString *selfClassName = NSStringFromClass(clas);

    if ([selfClassName rangeOfString:@"."].location != NSNotFound) {
        selfClassName = [selfClassName componentsSeparatedByString:@"."].lastObject;
    }
    
    UIView *view = dict[selfClassName];
    if (!view) {
        NSBundle *bundle = [NSBundle bundleForClass:clas];
        NSString *path = [bundle pathForResource:selfClassName ofType:@"nib"];
        UIView *cell = nil;
        if (path.length > 0) {
            NSArray <UICollectionViewCell *> *arr = [[UINib nibWithNibName:selfClassName bundle:bundle] instantiateWithOwner:nil options:nil];
            for (UICollectionViewCell *obj in arr) {
                if ([obj isMemberOfClass:clas]) {
                    cell = obj;
                    break;
                }
            }
        }
        // 不是 IB 创建的 cell
        if (!cell) {
            NSAssert(NO, @"Currently only xib is created to create cell (%@)", clas);
            return CGSizeZero;
        }
        view = [UIView new];
        [view addSubview:cell];
        dict[selfClassName] = view;
    }

    view.frame = CGRectMake(0, 0, size.width, size.height);
    UICollectionViewCell *cell = view.subviews.firstObject;
    cell.frame = CGRectMake(0, 0, size.width, size.height);

    !configuration ? : configuration(cell);

    dynamicLayoutLayoutIfNeeded(view);

    __block CGFloat maxX  = 0.0f;
    __block CGFloat maxY  = 0.0f;
    if (cell.bm_maxXViewFixed) {
        if (cell.dynamicLayout_maxXView) {
            maxX = CGRectGetMaxX(cell.dynamicLayout_maxXView.frame);
        } else {
            __block UIView *maxXView = nil;
            [cell.contentView.subviews enumerateObjectsWithOptions:(NSEnumerationReverse) usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CGFloat tempX = CGRectGetMaxX(obj.frame);
                if (tempX > maxX) {
                    maxX = tempX;
                    maxXView = obj;
                }
            }];
            cell.dynamicLayout_maxXView = maxXView;
        }
    } else {
        [cell.contentView.subviews enumerateObjectsWithOptions:(NSEnumerationReverse) usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat tempX = CGRectGetMaxX(obj.frame);
            if (tempX > maxX) {
                maxX = tempX;
            }
        }];
    }

    if (cell.bm_maxYViewFixed) {
        if (cell.dynamicLayout_maxYView) {
            maxY = CGRectGetMaxY(cell.dynamicLayout_maxYView.frame);
        } else {
            __block UIView *maxYView = nil;
            [cell.contentView.subviews enumerateObjectsWithOptions:(NSEnumerationReverse) usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                CGFloat tempY = CGRectGetMaxY(obj.frame);
                if (tempY > maxY) {
                    maxY = tempY;
                    maxYView = obj;
                }
            }];
            cell.dynamicLayout_maxYView = maxYView;
        }
    } else {
        [cell.contentView.subviews enumerateObjectsWithOptions:(NSEnumerationReverse) usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat tempY = CGRectGetMaxY(obj.frame);
            if (tempY > maxY) {
                maxY = tempY;
            }
        }];
    }
    return CGSizeMake(maxX, maxY);
}

- (CGSize)_sizeWithCellClass:(Class)clas
                 cellMaxSize:(CGSize)size
            cacheByIndexPath:(NSIndexPath *)indexPath
               configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration {
    if (__builtin_expect((!self.isDynamicLayoutInitializationed), 0)) {
        [self bm_dynamicLayoutInitialization];
    }
    // 取值
    NSValue *value = self.sizeArray[indexPath.section][indexPath.item];
    if (value.CGSizeValue.width >= 0.0) {
        BM_UICollectionView_LOG(@"✅✅读缓存✅✅ get cache size { (indexPath: %@  %@ ) (size: %@) }", @(indexPath.section), @(indexPath.item), value);
        return value.CGSizeValue;
    }
    // 没有缓存
    CGSize cellSize = [self _sizeWithCellClass:clas cellMaxSize:size configuration:configuration];
    self.sizeArray[indexPath.section][indexPath.item] = [NSValue valueWithCGSize:cellSize];
    BM_UICollectionView_LOG(@"⚠️计算尺寸⚠️ save size { (indexPath: %@  %@ ) (size: %@) }", @(indexPath.section), @(indexPath.item), [NSValue valueWithCGSize:cellSize]);
    return cellSize;
}

- (CGSize)_sizeWithCellClass:(Class)clas
                 cellMaxSize:(CGSize)size
                  cacheByKey:(id<NSCopying>)key
               configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration {
    if (__builtin_expect((!self.isDynamicLayoutInitializationed), 0)) {
        [self bm_dynamicLayoutInitialization];
    }
    if (key && self.sizeDictionary[key]) {
        BM_UICollectionView_LOG(@"✅✅读缓存✅✅ get cache size { (key: %@) (size: %@) }", key, self.sizeDictionary[key]);
        return self.sizeDictionary[key].CGSizeValue;
    }
    CGSize cellSize = [self _sizeWithCellClass:clas cellMaxSize:size configuration:configuration];
    if (key) {
        BM_UICollectionView_LOG(@"⚠️计算尺寸⚠️ save size { (key: %@) (size: %@) }", key, [NSValue valueWithCGSize:cellSize]);
        self.sizeDictionary[key] = (NSValue *)[NSValue valueWithCGSize:cellSize];
    }
    return cellSize;
}

#pragma mark - no cache

- (CGSize)bm_sizeWithCellClass:(Class)clas
                  cellMaxWidth:(CGFloat)width
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration {
    return [self _sizeWithCellClass:clas
                        cellMaxSize:CGSizeMake(width, kMaxHeightWidth)
                      configuration:configuration];
}

- (CGSize)bm_sizeWithCellClass:(Class)clas
                 cellMaxHeight:(CGFloat)height
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration {
    return [self _sizeWithCellClass:clas
                        cellMaxSize:CGSizeMake(kMaxHeightWidth, height)
                      configuration:configuration];
}

- (CGSize)bm_sizeWithCellClass:(Class)clas
                   cellMaxSize:(CGSize)size
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration {
    return [self _sizeWithCellClass:clas
                        cellMaxSize:size
                      configuration:configuration];
}

- (CGSize)bm_sizeWithCellClass:(Class)clas
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration {
    return [self _sizeWithCellClass:clas
                        cellMaxSize:CGSizeMake(kMaxHeightWidth, kMaxHeightWidth)
                      configuration:configuration];
}

#pragma mark - indexPath cache

- (CGSize)bm_sizeWithCellClass:(Class)clas
                  cellMaxWidth:(CGFloat)width
              cacheByIndexPath:(NSIndexPath *)indexPath
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration {
    return [self _sizeWithCellClass:clas
                        cellMaxSize:CGSizeMake(width, kMaxHeightWidth)
                   cacheByIndexPath:indexPath
                      configuration:configuration];
}

- (CGSize)bm_sizeWithCellClass:(Class)clas
                 cellMaxHeight:(CGFloat)height
              cacheByIndexPath:(NSIndexPath *)indexPath
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration {
    return [self _sizeWithCellClass:clas
                        cellMaxSize:CGSizeMake(kMaxHeightWidth, height)
                   cacheByIndexPath:indexPath
                      configuration:configuration];
}

- (CGSize)bm_sizeWithCellClass:(Class)clas
                   cellMaxSize:(CGSize)size
              cacheByIndexPath:(NSIndexPath *)indexPath
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration {
    return [self _sizeWithCellClass:clas
                        cellMaxSize:size
                   cacheByIndexPath:indexPath
                      configuration:configuration];
}

- (CGSize)bm_sizeWithCellClass:(Class)clas
              cacheByIndexPath:(NSIndexPath *)indexPath
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration {
    return [self _sizeWithCellClass:clas
                        cellMaxSize:CGSizeMake(kMaxHeightWidth, kMaxHeightWidth)
                   cacheByIndexPath:indexPath
                      configuration:configuration];
}

#pragma mark - key cache

- (CGSize)bm_sizeWithCellClass:(Class)clas
                  cellMaxWidth:(CGFloat)width
                    cacheByKey:(id<NSCopying>)key
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration {
    return [self _sizeWithCellClass:clas
                        cellMaxSize:CGSizeMake(width, kMaxHeightWidth)
                         cacheByKey:key
                      configuration:configuration];
}

- (CGSize)bm_sizeWithCellClass:(Class)clas
                 cellMaxHeight:(CGFloat)height
                    cacheByKey:(id<NSCopying>)key
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration {
    return [self _sizeWithCellClass:clas
                        cellMaxSize:CGSizeMake(kMaxHeightWidth, height)
                         cacheByKey:key
                      configuration:configuration];
}

- (CGSize)bm_sizeWithCellClass:(Class)clas
                   cellMaxSize:(CGSize)size
                    cacheByKey:(id<NSCopying>)key
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration {
    return [self _sizeWithCellClass:clas
                        cellMaxSize:size
                         cacheByKey:key
                      configuration:configuration];
}

- (CGSize)bm_sizeWithCellClass:(Class)clas
                    cacheByKey:(id<NSCopying>)key
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration {
    return [self _sizeWithCellClass:clas
                        cellMaxSize:CGSizeMake(kMaxHeightWidth, kMaxHeightWidth)
                         cacheByKey:key
                      configuration:configuration];
}

@end

