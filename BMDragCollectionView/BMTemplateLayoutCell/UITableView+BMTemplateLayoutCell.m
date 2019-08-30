//    996 License https://github.com/996icu/996.ICU/blob/master/LICENSE
//
//    Copyright (c) https://github.com/liangdahong/UITableView-BMTemplateLayoutCell
//

#import "UITableView+BMTemplateLayoutCell.h"
#import <objc/runtime.h>

static inline void bm_templateLayout_get_view_subviews_MaxY(UIView *view, CGFloat *maxY, UIView * __autoreleasing *maxYView) {
    if (!view)return;
    __block CGFloat mY = 0.0f;
    if (maxYView) {
        __block UIView *v = nil;
        [view.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat objY = CGRectGetMaxY(obj.frame);
            if (mY < objY) {
                mY = objY;
                v = obj;
            }
        }];
        *maxYView = v;
    } else {
        [view.subviews enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            CGFloat objY = CGRectGetMaxY(obj.frame);
            if (mY < objY) {
                mY = objY;
            }
        }];
    }
    if (maxY) {
        *maxY = mY;
    }
}

static inline BOOL bm_templateLayoutCell_is_portrait_rotating (UITableView *tableView) {
    if (!tableView.isScreenRotating) {
        return YES;
    }
    return (CGRectGetWidth([[UIScreen mainScreen] bounds]) < CGRectGetHeight([[UIScreen mainScreen] bounds]));
}

static inline void bm_templateLayoutCell_swizzleMethod(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

static inline CGFloat bm_templateLayoutCell_height(NSNumber *value) {
#if CGFLOAT_IS_DOUBLE
    return value.doubleValue;
#else
    return value.floatValue;
#endif
}

#ifdef DEBUG
#define BMTemplateLayoutCellLog(...) NSLog(__VA_ARGS__)
#else
#define BMTemplateLayoutCellLog(...)
#endif

@interface UITableView ()

@property (strong, nonatomic, readonly) NSMutableDictionary *portraitCacheCellHeightMutableDictionary;     ///< portraitCacheCellHeightMutableDictionary
@property (strong, nonatomic, readonly) NSMutableDictionary *landscapeCacheCellHeightMutableDictionary;    ///< landscapeCacheCellHeightMutableDictionary
@property (strong, nonatomic, readonly) NSMutableDictionary *portraitCacheKeyCellHeightMutableDictionary;  ///< portraitCacheKeyCellHeightMutableDictionary
@property (strong, nonatomic, readonly) NSMutableDictionary *landscapeCacheKeyCellHeightMutableDictionary; ///< landscapeCacheKeyCellHeightMutableDictionary
@property (strong, nonatomic, readonly) NSMutableDictionary *reusableCellWithIdentifierMutableDictionary;  ///< reusableCellWithIdentifierMutableDictionary

@end

@interface  UITableViewCell ()

@property (nonatomic, strong) UIView *linView; ///< linView

@end

@interface  UITableViewHeaderFooterView ()

@property (nonatomic, strong) UIView *linView; ///< linView

@end

@implementation UITableView (BMTemplateLayoutCell)

- (BOOL)isScreenRotating {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setScreenRotating:(BOOL)screenRotating {
    objc_setAssociatedObject(self, @selector(isScreenRotating), @(screenRotating), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)bm_noDataOpenScroll {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (UIView *)bm_tempViewCellWithCellClass:(Class)clas {
    // 创建新的重用标识
    NSString *noReuseIdentifier = [NSString stringWithFormat:@"noReuse%@", NSStringFromClass(clas.class)];
    
    NSString *noReuseIdentifierChar = self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier];
    if (!noReuseIdentifierChar) {
        noReuseIdentifierChar = noReuseIdentifier;
        self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier] = noReuseIdentifier;
    }
    // 取特定的重用标识是否绑定的Cell
    UIView *tempView = objc_getAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar));
    if (!tempView) {
        // 没有绑定就创建
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(clas.class) ofType:@"nib"];
        UITableViewCell *noCacheCell = nil;
        if (path.length) {
            noCacheCell = [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(clas.class) owner:nil options:nil] firstObject];
            [noCacheCell setValue:noReuseIdentifier forKey:@"reuseIdentifier"];
        } else {
            noCacheCell = [[clas alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:noReuseIdentifier];
        }
        // 绑定起来
        tempView = [UIView new];
        [tempView addSubview:noCacheCell];
        objc_setAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar), tempView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        BMTemplateLayoutCellLog(@"第一次创建 %@ 的布局对象 cell：%@", clas, noCacheCell);
    }
    return tempView;
}

- (CGFloat)bm_layoutIfNeededCellWith:(UITableViewCell *)cell configuration:(BMLayoutCellConfigurationBlock)configuration {
    
    if (self.superview) {
        [self.superview layoutIfNeeded];
    }
    
    cell.superview.frame = CGRectMake(0.0f, 0.0f, self.frame.size.width, 0.0f);
    cell.frame           = CGRectMake(0.0f, 0.0f, self.frame.size.width, 0.0f);
    !configuration ? : configuration(cell);
    [cell.superview layoutIfNeeded];
    if (!cell.isDynamicCellBottomView) {
        // cell 的最底部View是固定的
        if (cell.linView) {
            // 如果有关联就可直接取最底部View的MaxY为Cell的高度
            return CGRectGetMaxY(cell.linView.frame);
        } else {
            // 还没有关联就遍历获取最大Y，同时关联
            CGFloat maxY = 0.0f;
            UIView *v = nil;
            bm_templateLayout_get_view_subviews_MaxY(cell.contentView, &maxY, &v);
            cell.linView = v;
            return maxY;
        }
    } else {
        CGFloat maxY = 0.0f;
        bm_templateLayout_get_view_subviews_MaxY(cell.contentView, &maxY, nil);
        return maxY;
    }
}

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas configuration:(BMLayoutCellConfigurationBlock)configuration {
    if (!clas) {
        return 0;
    }
    UIView *tempView = [self bm_tempViewCellWithCellClass:clas];
    return [self bm_layoutIfNeededCellWith:tempView.subviews[0] configuration:configuration];
}

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
                          tableViewWidth:(CGFloat)width
                           configuration:(BMLayoutCellConfigurationBlock)configuration {
    return [self bm_heightForCellWithCellClass:clas tableViewWidth:width configuration:^(__kindof UITableViewCell * _Nonnull cell) {
        cell.superview.frame = CGRectMake(0, 0, width, 0);
        cell.frame = CGRectMake(0, 0, width, 0);
        !configuration ? : configuration(cell);
    }];
}

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
                        cacheByIndexPath:(NSIndexPath *)indexPath
                           configuration:(BMLayoutCellConfigurationBlock)configuration {
    if (!clas) {
        return 0;
    }
    if (!indexPath) {
        return [self bm_heightForCellWithCellClass:clas configuration:configuration];
    }
    NSString *key = [NSString stringWithFormat:@"%ld-%ld", (long)indexPath.section, (long)indexPath.row];
    NSNumber *heightValue = (bm_templateLayoutCell_is_portrait_rotating(self) ? self.portraitCacheCellHeightMutableDictionary :  self.landscapeCacheCellHeightMutableDictionary)[key];
    if (heightValue) {
        BMTemplateLayoutCellLog(@"%@已缓存了 取缓存:%@", indexPath, heightValue);
        return bm_templateLayoutCell_height(heightValue);
    }
    UIView *tempView = [self bm_tempViewCellWithCellClass:clas];
    CGFloat height = [self bm_layoutIfNeededCellWith:tempView.subviews[0] configuration:configuration];
    (bm_templateLayoutCell_is_portrait_rotating(self) ? self.portraitCacheCellHeightMutableDictionary :  self.landscapeCacheCellHeightMutableDictionary)[key] = @(height);
    BMTemplateLayoutCellLog(@"%@没有缓存 布局获取到的高度是:%f", indexPath, height);
    return height;
}

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
                        cacheByIndexPath:(NSIndexPath *)indexPath
                          tableViewWidth:(CGFloat)width
                           configuration:(nonnull BMLayoutCellConfigurationBlock)configuration {
    return [self bm_heightForCellWithCellClass:clas cacheByIndexPath:indexPath configuration:^(__kindof UITableViewCell * _Nonnull cell) {
        cell.superview.frame = CGRectMake(0, 0, width, 0);
        cell.frame = CGRectMake(0, 0, width, 0);
        !configuration ? : configuration(cell);
    }];
}

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
                              cacheByKey:(NSString *)key
                           configuration:(BMLayoutCellConfigurationBlock)configuration {
    if (!clas) {
        return 0.0f;
    }
    if (!key || key.length == 0) {
        return [self bm_heightForCellWithCellClass:clas configuration:configuration];
    }
    NSNumber *heightValue = (bm_templateLayoutCell_is_portrait_rotating(self) ? self.portraitCacheKeyCellHeightMutableDictionary :  self.landscapeCacheKeyCellHeightMutableDictionary)[key];
    if (heightValue) {
        BMTemplateLayoutCellLog(@"cacheByKey:%@ 取缓存:%@", key, heightValue);
        return bm_templateLayoutCell_height(heightValue);
    }
    UIView *tempView = [self bm_tempViewCellWithCellClass:clas];
    CGFloat height = [self bm_layoutIfNeededCellWith:tempView.subviews[0] configuration:configuration];
    (bm_templateLayoutCell_is_portrait_rotating(self) ? self.portraitCacheKeyCellHeightMutableDictionary :  self.landscapeCacheKeyCellHeightMutableDictionary)[key] = @(height);
    return height;
}

- (CGFloat)bm_heightForCellWithCellClass:(Class)clas
                              cacheByKey:(NSString *)key
                          tableViewWidth:(CGFloat)width
                           configuration:(BMLayoutCellConfigurationBlock)configuration {
    return [self bm_heightForCellWithCellClass:clas cacheByKey:key configuration:^(__kindof UITableViewCell * _Nonnull cell) {
        cell.superview.frame = CGRectMake(0, 0, width, 0);
        cell.frame = CGRectMake(0, 0, width, 0);
        !configuration ? : configuration(cell);
    }];
}

- (NSMutableDictionary *)portraitCacheCellHeightMutableDictionary {
    NSMutableDictionary *portraitCacheCellHeightMutableDictionary = objc_getAssociatedObject(self, _cmd);
    if (!portraitCacheCellHeightMutableDictionary) {
        portraitCacheCellHeightMutableDictionary = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, portraitCacheCellHeightMutableDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return portraitCacheCellHeightMutableDictionary;
}

- (NSMutableDictionary *)landscapeCacheCellHeightMutableDictionary {
    NSMutableDictionary *landscapeCacheCellHeightMutableDictionary = objc_getAssociatedObject(self, _cmd);
    if (!landscapeCacheCellHeightMutableDictionary) {
        landscapeCacheCellHeightMutableDictionary = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, landscapeCacheCellHeightMutableDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return landscapeCacheCellHeightMutableDictionary;
}

- (NSMutableDictionary *)reusableCellWithIdentifierMutableDictionary {
    NSMutableDictionary *reusableCellWithIdentifierMutableDictionary = objc_getAssociatedObject(self, _cmd);
    if (!reusableCellWithIdentifierMutableDictionary) {
        reusableCellWithIdentifierMutableDictionary = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, reusableCellWithIdentifierMutableDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return reusableCellWithIdentifierMutableDictionary;
}

- (NSMutableDictionary *)portraitCacheKeyCellHeightMutableDictionary {
    NSMutableDictionary *portraitCacheKeyCellHeightMutableDictionary = objc_getAssociatedObject(self, _cmd);
    if (!portraitCacheKeyCellHeightMutableDictionary) {
        portraitCacheKeyCellHeightMutableDictionary = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, portraitCacheKeyCellHeightMutableDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return portraitCacheKeyCellHeightMutableDictionary;
}

- (NSMutableDictionary *)landscapeCacheKeyCellHeightMutableDictionary {
    NSMutableDictionary *landscapeCacheKeyCellHeightMutableDictionary = objc_getAssociatedObject(self, _cmd);
    if (!landscapeCacheKeyCellHeightMutableDictionary) {
        landscapeCacheKeyCellHeightMutableDictionary = @{}.mutableCopy;
        objc_setAssociatedObject(self, _cmd, landscapeCacheKeyCellHeightMutableDictionary, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return landscapeCacheKeyCellHeightMutableDictionary;
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        SEL selectors[] = {
            @selector(reloadData),
            @selector(insertSections:withRowAnimation:),
            @selector(deleteSections:withRowAnimation:),
            @selector(reloadSections:withRowAnimation:),
            @selector(moveSection:toSection:),
            @selector(insertRowsAtIndexPaths:withRowAnimation:),
            @selector(deleteRowsAtIndexPaths:withRowAnimation:),
            @selector(reloadRowsAtIndexPaths:withRowAnimation:),
            @selector(moveRowAtIndexPath:toIndexPath:)
        };
        for (NSUInteger index = 0; index < sizeof(selectors) / sizeof(SEL); ++index) {
            SEL originalSelector = selectors[index];
            SEL swizzledSelector = NSSelectorFromString([@"bm_templateLayoutCell_" stringByAppendingString:NSStringFromSelector(originalSelector)]);
            bm_templateLayoutCell_swizzleMethod(self.class, originalSelector, swizzledSelector);
        }
    });
}

- (void)bm_templateLayoutCell_reloadData {
    [self.portraitCacheCellHeightMutableDictionary  removeAllObjects];
    [self.landscapeCacheCellHeightMutableDictionary removeAllObjects];
    [self bm_templateLayoutCell_reloadData];
}

- (void)bm_templateLayoutCell_insertSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    // 待优化
    [self.portraitCacheCellHeightMutableDictionary  removeAllObjects];
    [self.landscapeCacheCellHeightMutableDictionary removeAllObjects];
    [self bm_templateLayoutCell_insertSections:sections withRowAnimation:animation];
}

- (void)bm_templateLayoutCell_deleteSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    // 待优化
    [self.portraitCacheCellHeightMutableDictionary  removeAllObjects];
    [self.landscapeCacheCellHeightMutableDictionary removeAllObjects];
    [self bm_templateLayoutCell_deleteSections:sections withRowAnimation:animation];
}

- (void)bm_templateLayoutCell_reloadSections:(NSIndexSet *)sections withRowAnimation:(UITableViewRowAnimation)animation {
    // 将需要刷新的的 section 的高度缓存清除
    [sections enumerateIndexesUsingBlock:^(NSUInteger idx, BOOL * _Nonnull stop) {
        NSInteger row = [self.dataSource tableView:self numberOfRowsInSection:idx];
        while (row--) {
            NSString *cacheID = [NSString stringWithFormat:@"%ld-%ld", (long)idx, (long)row];
            [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:cacheID];
            [self.landscapeCacheCellHeightMutableDictionary removeObjectForKey:cacheID];
        }
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", (long)idx]];
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", (long)idx]];
        
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", (long)idx]];
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", (long)idx]];
        
    }];
    [self bm_templateLayoutCell_reloadSections:sections withRowAnimation:animation];
}

- (void)bm_templateLayoutCell_moveSection:(NSInteger)section toSection:(NSInteger)newSection {
    // 待优化
    {
        NSInteger row = [self.dataSource tableView:self numberOfRowsInSection:section];
        while (row--) {
            NSString *cacheID = [NSString stringWithFormat:@"%ld-%ld", (long)section, (long)row];
            [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:cacheID];
            [self.landscapeCacheCellHeightMutableDictionary removeObjectForKey:cacheID];
        }
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", (long)section]];
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", (long)section]];
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", (long)section]];
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", (long)section]];
    }
    {
        NSInteger row = [self.dataSource tableView:self numberOfRowsInSection:newSection];
        while (row--) {
            NSString *cacheID = [NSString stringWithFormat:@"%ld-%ld", (long)newSection, (long)row];
            [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:cacheID];
            [self.landscapeCacheCellHeightMutableDictionary removeObjectForKey:cacheID];
        }
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", (long)newSection]];
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Header:%ld", (long)newSection]];
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", (long)newSection]];
        [self.landscapeCacheCellHeightMutableDictionary  removeObjectForKey:[NSString stringWithFormat:@"Footer:%ld", (long)newSection]];
    }
    [self bm_templateLayoutCell_moveSection:section toSection:newSection];
}

- (void)bm_templateLayoutCell_insertRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    // 待优化
    [self.portraitCacheCellHeightMutableDictionary  removeAllObjects];
    [self.landscapeCacheCellHeightMutableDictionary removeAllObjects];
    [self bm_templateLayoutCell_insertRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)bm_templateLayoutCell_deleteRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    // 待优化
    [self.portraitCacheCellHeightMutableDictionary  removeAllObjects];
    [self.landscapeCacheCellHeightMutableDictionary removeAllObjects];
    [self bm_templateLayoutCell_deleteRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)bm_templateLayoutCell_reloadRowsAtIndexPaths:(NSArray<NSIndexPath *> *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation {
    // 将需要刷新的 indexPath 的高度缓存清除
    [indexPaths enumerateObjectsUsingBlock:^(NSIndexPath * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString *cacheID = [NSString stringWithFormat:@"%ld-%ld", (long)obj.section, (long)obj.row];
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:cacheID];
        [self.landscapeCacheCellHeightMutableDictionary removeObjectForKey:cacheID];
    }];
    [self bm_templateLayoutCell_reloadRowsAtIndexPaths:indexPaths withRowAnimation:animation];
}

- (void)bm_templateLayoutCell_moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    // 待优化
    {
        NSString *cacheID = [NSString stringWithFormat:@"%ld-%ld", (long)sourceIndexPath.section, (long)sourceIndexPath.row];
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:cacheID];
        [self.landscapeCacheCellHeightMutableDictionary removeObjectForKey:cacheID];
    }
    {
        NSString *cacheID = [NSString stringWithFormat:@"%ld-%ld", (long)destinationIndexPath.section, (long)destinationIndexPath.row];
        [self.portraitCacheCellHeightMutableDictionary  removeObjectForKey:cacheID];
        [self.landscapeCacheCellHeightMutableDictionary removeObjectForKey:cacheID];
    }
    [self bm_templateLayoutCell_moveRowAtIndexPath:sourceIndexPath toIndexPath:destinationIndexPath];
}

@end

@implementation UITableView (BMTemplateLayoutHeaderFooterView)

- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration {
    if (!clas) {
        return 0.0f;
    }
    // 没有缓存创建临时View来布局获取高度
    UIView *tempView = [self bm_tempViewHeaderFooterViewWithHeaderFooterViewClass:clas];
    // 布局获取高度
    return [self bm_layoutIfNeededHeaderFooterViewWith:tempView.subviews[0] configuration:configuration];
}

- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas tableViewWidth:(CGFloat)width configuration:(nonnull BMLayoutHeaderFooterConfigurationBlock)configuration {
    return [self bm_heightForHeaderFooterViewWithHeaderFooterViewClass:clas configuration:^(__kindof UITableViewHeaderFooterView * _Nonnull headerFooterView) {
        headerFooterView.superview.frame = CGRectMake(0, 0, width, 0);
        headerFooterView.frame = CGRectMake(0, 0, width, 0);
        !configuration ? : configuration(headerFooterView);
    }];
}


- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas isHeaderView:(BOOL)isHeaderView section:(NSInteger)section configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration {
    if (!clas) {
        return 0.0f;
    }
    NSString *key = [NSString stringWithFormat:@"%@:%ld", isHeaderView ? @"Header" : @ "Footer" ,(long)section];
    NSNumber *heightValue = (bm_templateLayoutCell_is_portrait_rotating(self) ? self.portraitCacheCellHeightMutableDictionary :  self.landscapeCacheCellHeightMutableDictionary)[key];
    // 有缓存就直接返回
    if (heightValue) {
        BMTemplateLayoutCellLog(@"组头部%ld已缓存了 取缓存:%@", (long)section, heightValue);
        return bm_templateLayoutCell_height(heightValue);
    }
    // 没有缓存创建临时View来布局获取高度
    UIView *tempView = [self bm_tempViewHeaderFooterViewWithHeaderFooterViewClass:clas];
    // 布局获取高度
    CGFloat height = [self bm_layoutIfNeededHeaderFooterViewWith:tempView.subviews[0] configuration:configuration];
    // 缓存起来
    (bm_templateLayoutCell_is_portrait_rotating(self) ? self.portraitCacheCellHeightMutableDictionary :  self.landscapeCacheCellHeightMutableDictionary)[key] = @(height);
    BMTemplateLayoutCellLog(@"组头部%ld没有缓存 布局获取到的高度是:%f", (long)section, height);
    return height;
}

- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas isHeaderView:(BOOL)isHeaderView section:(NSInteger)section tableViewWidth:(CGFloat)width configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration {
    return [self bm_heightForHeaderFooterViewWithHeaderFooterViewClass:clas isHeaderView:isHeaderView section:section configuration:^(__kindof UITableViewHeaderFooterView * _Nonnull headerFooterView) {
        headerFooterView.superview.frame = CGRectMake(0, 0, width, 0);
        headerFooterView.frame = CGRectMake(0, 0, width, 0);
        !configuration ? : configuration(headerFooterView);
    }];
}

- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas cacheByKey:(NSString *)key configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration {
    if (!clas) {
        return 0.0f;
    }
    if (!key || key.length == 0) {
        return [self bm_heightForHeaderFooterViewWithHeaderFooterViewClass:clas configuration:configuration];
    }
    
    NSNumber *heightValue = ((bm_templateLayoutCell_is_portrait_rotating(self)) ? self.portraitCacheKeyCellHeightMutableDictionary :  self.landscapeCacheKeyCellHeightMutableDictionary)[key];
    // 有缓存就直接返回
    if (heightValue) {
        return bm_templateLayoutCell_height(heightValue);
    }
    // 没有缓存创建临时View来布局获取高度
    UIView *tempView = [self bm_tempViewHeaderFooterViewWithHeaderFooterViewClass:clas];
    // 布局获取高度
    CGFloat height = [self bm_layoutIfNeededHeaderFooterViewWith:tempView.subviews[0] configuration:configuration];
    // 缓存起来
    (bm_templateLayoutCell_is_portrait_rotating(self) ? self.portraitCacheKeyCellHeightMutableDictionary :  self.landscapeCacheKeyCellHeightMutableDictionary)[key] = @(height);
    return height;
}

- (CGFloat)bm_heightForHeaderFooterViewWithHeaderFooterViewClass:(Class)clas cacheByKey:(NSString *)key tableViewWidth:(CGFloat)width configuration:(nonnull BMLayoutHeaderFooterConfigurationBlock)configuration {
    return [self bm_heightForHeaderFooterViewWithHeaderFooterViewClass:clas cacheByKey:key configuration:^(__kindof UITableViewHeaderFooterView * _Nonnull headerFooterView) {
        headerFooterView.superview.frame = CGRectMake(0, 0, width, 0);
        headerFooterView.frame = CGRectMake(0, 0, width, 0);
        !configuration ? : configuration(headerFooterView);
    }];
}

- (UIView *)bm_tempViewHeaderFooterViewWithHeaderFooterViewClass:(Class)clas {
    NSString *noReuseIdentifier = [NSString stringWithFormat:@"noReuse%@", NSStringFromClass(clas.class)];
    NSString *noReuseIdentifierChar = self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier];
    if (!noReuseIdentifierChar) {
        noReuseIdentifierChar = noReuseIdentifier;
        self.reusableCellWithIdentifierMutableDictionary[noReuseIdentifier] = noReuseIdentifier;
    }
    UIView *tempView = objc_getAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar));
    if (!tempView) {
        // 没有绑定就创建
        NSString *path = [[NSBundle mainBundle] pathForResource:NSStringFromClass(clas.class) ofType:@"nib"];
        UITableViewHeaderFooterView *noCachetableViewHeaderFooterView = nil;
        if (path.length) {
            noCachetableViewHeaderFooterView = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(clas) owner:nil options:nil][0];
        } else {
            noCachetableViewHeaderFooterView = [[clas alloc] initWithReuseIdentifier:noReuseIdentifier];
        }
        
        // 绑定起来
        tempView = UIView.new;
        [tempView addSubview:noCachetableViewHeaderFooterView];
        objc_setAssociatedObject(self, (__bridge const void *)(noReuseIdentifierChar), tempView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        BMTemplateLayoutCellLog(@"第一次创建 %@ 的布局对象 HeaderFooterView：%@", clas, noCachetableViewHeaderFooterView);
    }
    return tempView;
}

- (CGFloat)bm_layoutIfNeededHeaderFooterViewWith:(UITableViewHeaderFooterView *)tableViewHeaderFooterView configuration:(BMLayoutHeaderFooterConfigurationBlock)configuration {
    if (self.superview) {
        [self.superview layoutIfNeeded];
    }
    
    tableViewHeaderFooterView.superview.frame = CGRectMake(0, 0, self.frame.size.width, 0);
    tableViewHeaderFooterView.frame = CGRectMake(0, 0, self.frame.size.width, 0);
    !configuration ? : configuration(tableViewHeaderFooterView);
    [tableViewHeaderFooterView.superview layoutIfNeeded];
    if (!tableViewHeaderFooterView.isDynamicHeaderFooterBottomView) {
        // UITableViewHeaderFooterView 的最底部 View 是固定的
        if (tableViewHeaderFooterView.linView) {
            // 如果有关联就可直接取最底部 View 的 MaxY 为 UITableViewHeaderFooterView 的高度
            return CGRectGetMaxY(tableViewHeaderFooterView.linView.frame);
        } else {
            // 还没有关联就遍历获取 MaxY，同时关联
            CGFloat maxY = 0.0f;
            UIView *v    = nil;
            UIView *temp = tableViewHeaderFooterView.contentView.subviews.count ? tableViewHeaderFooterView.contentView : tableViewHeaderFooterView;
            bm_templateLayout_get_view_subviews_MaxY(temp, &maxY, &v);
            tableViewHeaderFooterView.linView = v;
            return maxY;
        }
    } else {
        CGFloat maxY = 0.0f;
        UIView *temp = tableViewHeaderFooterView.contentView.subviews.count ? tableViewHeaderFooterView.contentView : tableViewHeaderFooterView;
        bm_templateLayout_get_view_subviews_MaxY(temp, &maxY, nil);
        return maxY;
    }
}

@end

@implementation UITableViewCell (BMTemplateLayoutCell)

- (BOOL)isDynamicCellBottomView {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setDynamicCellBottomView:(BOOL)dynamicCellBottomView {
    objc_setAssociatedObject(self, @selector(isDynamicCellBottomView), @(dynamicCellBottomView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)linView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLinView:(UIView *)linView {
    objc_setAssociatedObject(self, @selector(linView), linView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (instancetype)bm_tableViewCellWithTableView:(UITableView *)tableView {
    return [self bm_tableViewCellWithTableView:tableView style:UITableViewCellStyleDefault];
}

+ (instancetype)bm_tableViewCellWithTableView:(UITableView *)tableView style:(UITableViewCellStyle)style {
    NSString *selfClassName = NSStringFromClass(self.class);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selfClassName];
    if (cell) {
        return cell;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:selfClassName ofType:@"nib"];
    if (path.length) {
        cell = [[[UINib nibWithNibName:selfClassName bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
        [cell setValue:selfClassName forKey:@"reuseIdentifier"];
    } else {
        cell = [[self alloc] initWithStyle:style reuseIdentifier:selfClassName];
    }
    return cell;
}

@end

#pragma mark - UITableViewHeaderFooterView BMTemplateLayoutCell

@implementation UITableViewHeaderFooterView (BMTemplateLayoutCell)

- (BOOL)isDynamicHeaderFooterBottomView {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

- (void)setDynamicHeaderFooterBottomView:(BOOL)dynamicHeaderFooterBottomView {
    objc_setAssociatedObject(self, @selector(isDynamicHeaderFooterBottomView), @(dynamicHeaderFooterBottomView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIView *)linView {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setLinView:(UIView *)linView {
    objc_setAssociatedObject(self, @selector(linView), linView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

+ (instancetype)bm_tableViewHeaderFooterViewWithTableView:(UITableView *)tableView {
    NSString *selfClassName = NSStringFromClass(self.class);
    UITableViewHeaderFooterView *headerFooterView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:selfClassName];
    if (headerFooterView) {
        return headerFooterView;
    }
    NSString *path = [[NSBundle mainBundle] pathForResource:selfClassName ofType:@"nib"];
    if (path.length) {
        headerFooterView = [[[UINib nibWithNibName:selfClassName bundle:nil] instantiateWithOwner:nil options:nil] firstObject];
        [headerFooterView setValue:selfClassName forKey:@"reuseIdentifier"];
    } else {
        headerFooterView = [[self alloc] initWithReuseIdentifier:selfClassName];
    }
    return headerFooterView;
}

@end
