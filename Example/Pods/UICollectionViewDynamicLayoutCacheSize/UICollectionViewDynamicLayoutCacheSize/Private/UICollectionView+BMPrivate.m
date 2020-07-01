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

#import "UICollectionView+BMPrivate.h"
#import <objc/runtime.h>
#import "UICollectionViewDynamicLayoutCacheSize.h"

#define kOBJDefaultSize ([NSValue valueWithCGSize:CGSizeMake(-1.0, -1.0)])

#ifdef DEBUG
    #define kChangedLogCache [self _changedLogCache];
#else
    #define kChangedLogCache
#endif

@interface UICollectionView (__BMPrivate__)

@property (nonatomic, strong, readonly) NSMutableDictionary <id<NSCopying>, NSValue *> *verticalDictionary;
@property (nonatomic, strong, readonly) NSMutableDictionary <id<NSCopying>, NSValue *> *horizontalDictionary;

@property (nonatomic, strong, readonly) NSMutableArray <NSMutableArray <NSValue *> *> *verticalArray;
@property (nonatomic, strong, readonly) NSMutableArray <NSMutableArray <NSValue *> *> *horizontalArray;

@end

@implementation UICollectionView (BMPrivate)

- (NSMutableArray<NSMutableArray<NSValue *> *> *)sizeArray {
    CGFloat width  = UIScreen.mainScreen.bounds.size.width;
    CGFloat height = UIScreen.mainScreen.bounds.size.height;
    return (height > width) ? self.verticalArray : self.horizontalArray;
}

- (NSMutableArray<NSMutableArray<NSValue *> *> *)verticalArray {
    NSMutableArray *arr = objc_getAssociatedObject(self, _cmd);
    if (__builtin_expect((arr == nil), 0)) {
        arr = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, arr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return arr;
}

- (NSMutableArray<NSMutableArray<NSValue *> *> *)horizontalArray {
    NSMutableArray *arr = objc_getAssociatedObject(self, _cmd);
    if (__builtin_expect((arr == nil), 0)) {
        arr = @[].mutableCopy;
        objc_setAssociatedObject(self, _cmd, arr, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return arr;
}

- (NSMutableDictionary<id<NSCopying>, NSValue *> *)sizeDictionary {
    CGFloat width  = UIScreen.mainScreen.bounds.size.width;
    CGFloat height = UIScreen.mainScreen.bounds.size.height;
    return (height > width) ? self.verticalDictionary : self.horizontalDictionary;
}

- (NSMutableDictionary<id<NSCopying>, NSValue *> *)verticalDictionary {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (__builtin_expect((dict == nil), 0)) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (NSMutableDictionary<id<NSCopying>, NSValue *> *)horizontalDictionary {
    NSMutableDictionary *dict = objc_getAssociatedObject(self, _cmd);
    if (__builtin_expect((dict == nil), 0)) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return dict;
}

- (BOOL)isDynamicLayoutInitializationed {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)bm_dynamicLayoutInitialization {
    [self _initCacheArrayWithDataSource:self.dataSource];
    objc_setAssociatedObject(self, @selector(isDynamicLayoutInitializationed), @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark - load

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            @selector(reloadData),

            @selector(insertSections:),
            @selector(deleteSections:),
            @selector(reloadSections:),
            @selector(moveSection:toSection:),

            @selector(insertItemsAtIndexPaths:),
            @selector(deleteItemsAtIndexPaths:),
            @selector(reloadItemsAtIndexPaths:),
            @selector(moveItemAtIndexPath:toIndexPath:)
        };

        for (int i = 0; i < sizeof(selectors) / sizeof(SEL); i++) {
            SEL originalSelector = selectors[i];
            SEL swizzledSelector = NSSelectorFromString([@"collectionView_dynamicLayout_"
                                                         stringByAppendingString:NSStringFromSelector(originalSelector)]);
            Method originalMethod = class_getInstanceMethod(self, originalSelector);
            Method swizzledMethod = class_getInstanceMethod(self, swizzledSelector);
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

- (void)collectionView_dynamicLayout_reloadData {
    if (self.isDynamicLayoutInitializationed) {
        // reloadData 时，清空缓存数据。
        [self _initCacheArrayWithDataSource:self.dataSource];
        kChangedLogCache
    }
    [self collectionView_dynamicLayout_reloadData];
}

- (void)collectionView_dynamicLayout_insertSections:(NSIndexSet *)sections {
    if (self.isDynamicLayoutInitializationed) {
        // 清空缓存数据，这里可以优化，由于需要考虑太多的情况，暂时没有提供全面的测试方法，暂时直接全部刷新。
        [self _initCacheArrayWithDataSource:self.dataSource];
        kChangedLogCache
    }
    [self collectionView_dynamicLayout_insertSections:sections];
}

- (void)collectionView_dynamicLayout_deleteSections:(NSIndexSet *)sections {
    if (self.isDynamicLayoutInitializationed) {
        [sections enumerateIndexesWithOptions:(NSEnumerationReverse) usingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
            [self.verticalArray   removeObjectAtIndex:idx];
            [self.horizontalArray removeObjectAtIndex:idx];
        }];
        kChangedLogCache
    }
    [self collectionView_dynamicLayout_deleteSections:sections];
}

- (void)collectionView_dynamicLayout_reloadSections:(NSIndexSet *)sections {
    if (self.isDynamicLayoutInitializationed) {
        [sections enumerateIndexesUsingBlock:^(NSUInteger section, BOOL * _Nonnull stop) {
            NSInteger sec = [self.dataSource collectionView:self numberOfItemsInSection:section];
            NSMutableArray *arr = [NSMutableArray arrayWithCapacity:sec];
            while (sec-- > 0) {
                [arr addObject:kOBJDefaultSize];
            }
            self.verticalArray[section]   = arr.mutableCopy;
            self.horizontalArray[section] = arr.mutableCopy;
        }];
        kChangedLogCache
    }
    [self collectionView_dynamicLayout_reloadSections:sections];
}

- (void)collectionView_dynamicLayout_moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    if (self.isDynamicLayoutInitializationed) {
        // 清空缓存数据，这里可以优化，由于需要考虑太多的情况，暂时没有提供全面的测试方法，暂时直接全部刷新。
        [self _initCacheArrayWithDataSource:self.dataSource];
        kChangedLogCache
    }
    [self collectionView_dynamicLayout_moveSection:section toSection:newSection];
}

- (void)collectionView_dynamicLayout_insertItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (self.isDynamicLayoutInitializationed) {
        // 清空缓存数据，这里可以优化，由于需要考虑太多的情况，暂时没有提供全面的测试方法，暂时直接全部刷新。
        [self _initCacheArrayWithDataSource:self.dataSource];
        kChangedLogCache
    }
    [self collectionView_dynamicLayout_insertItemsAtIndexPaths:indexPaths];
}

- (void)collectionView_dynamicLayout_deleteItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (self.isDynamicLayoutInitializationed) {
        NSMutableArray *tempIndexPaths = indexPaths.mutableCopy;
        [tempIndexPaths sortUsingComparator:^NSComparisonResult(NSIndexPath *  _Nonnull obj1, NSIndexPath *  _Nonnull obj2) {
            if (obj1.section == obj2.section) {
                return obj1.row < obj2.row;
            } else {
                return obj1.section < obj2.section;
            }
        }];
        [tempIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self.verticalArray[obj.section]   removeObjectAtIndex:obj.item];
            [self.horizontalArray[obj.section] removeObjectAtIndex:obj.item];
        }];
        kChangedLogCache
    }
    [self collectionView_dynamicLayout_deleteItemsAtIndexPaths:indexPaths];
}

- (void)collectionView_dynamicLayout_reloadItemsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths {
    if (self.isDynamicLayoutInitializationed) {
        [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            self.verticalArray[obj.section][obj.item]   = kOBJDefaultSize;
            self.horizontalArray[obj.section][obj.item] = kOBJDefaultSize;
        }];
        kChangedLogCache
    }
    [self collectionView_dynamicLayout_reloadItemsAtIndexPaths:indexPaths];
}

- (void)collectionView_dynamicLayout_moveItemAtIndexPath:(NSIndexPath *)indexPath toIndexPath:(NSIndexPath *)newIndexPath {
    if (self.isDynamicLayoutInitializationed) {
        // 清空缓存数据，这里可以优化，由于需要考虑太多的情况，暂时没有提供全面的测试方法，暂时直接全部刷新。
        [self _initCacheArrayWithDataSource:self.dataSource];
        kChangedLogCache
    }
    [self collectionView_dynamicLayout_moveItemAtIndexPath:indexPath toIndexPath:newIndexPath];
}

#pragma mark - Private Method

- (void)_initCacheArrayWithDataSource:(id<UICollectionViewDataSource>)dataSource {
    NSInteger sections = 1;
    if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
        sections = [self.dataSource numberOfSectionsInCollectionView:self];
    }

    NSInteger tempSections = 0;
    NSMutableArray *arr1 = [NSMutableArray arrayWithCapacity:sections];
    NSMutableArray *arr2 = [NSMutableArray arrayWithCapacity:sections];
    while (tempSections < sections) {
        NSInteger rowCount = [self.dataSource collectionView:self numberOfItemsInSection:tempSections];
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:rowCount];
        while (rowCount-- > 0) {
            [arr addObject:kOBJDefaultSize];
        }
        [arr1 addObject:arr];
        [arr2 addObject:arr.mutableCopy];
        tempSections++;
    }
    [self.verticalArray removeAllObjects];
    [self.verticalArray addObjectsFromArray:arr1];

    [self.horizontalArray removeAllObjects];
    [self.horizontalArray addObjectsFromArray:arr2];
    kChangedLogCache
}

- (void)_changedLogCache {
#ifdef DEBUG
    if (UICollectionViewDynamicLayoutCacheSize.isDebugLog) {
        [self.verticalArray enumerateObjectsUsingBlock:^(NSMutableArray<NSNumber *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BM_UICollectionView_LOG(@"修改了数据时: 初始化后 cell 竖屏：%ld", obj.count);
        }];
        [self.horizontalArray enumerateObjectsUsingBlock:^(NSMutableArray<NSNumber *> * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            BM_UICollectionView_LOG(@"修改了数据时: 初始化后 cell 横屏：%ld", obj.count);
        }];
    }
#endif
}

@end
