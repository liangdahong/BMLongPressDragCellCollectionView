//    996 License https://github.com/996icu/996.ICU/blob/master/LICENSE
//
//    Copyright (c) https://github.com/liangdahong/UITableView-BMTemplateLayoutCell
//

#import "UICollectionView+BMTemplateLayoutCell.h"
#import <objc/runtime.h>

#define maxHeightWidth 88888.0f

@implementation UICollectionView (BMTemplateLayoutCell)

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                                  key:(NSString *)key
                        configuration:(UICollectionViewLayoutCellConfigurationBlock)configuration {
    return [self bm_sizeForCellWithCellClass:clas
                                     maxSize:CGSizeMake(maxHeightWidth, maxHeightWidth)
                                         key:key configuration:configuration];
}

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                             maxWidth:(CGFloat)maxWidth
                                  key:(NSString *)key
                        configuration:(UICollectionViewLayoutCellConfigurationBlock)configuration {
    return [self bm_sizeForCellWithCellClass:clas
                                     maxSize:CGSizeMake(maxWidth, maxHeightWidth)
                                         key:key
                               configuration:configuration];
}

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                            maxHeight:(CGFloat)maxHeight
                                  key:(NSString *)key
                        configuration:(UICollectionViewLayoutCellConfigurationBlock)configuration {
    return [self bm_sizeForCellWithCellClass:clas
                                     maxSize:CGSizeMake(maxHeightWidth, maxHeight)
                                         key:key
                               configuration:configuration];
}

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                              maxSize:(CGSize)maxSize
                                  key:(NSString *)key
                        configuration:(UICollectionViewLayoutCellConfigurationBlock)configuration {

    NSMutableDictionary <NSString *, NSValue *> *dict = objc_getAssociatedObject(self, &clas);
    if (!dict) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, &clas, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    if (key && dict[key]) {
#if DEBUG
        NSLog(@"取缓存 %@ size %@", key, dict[key]);
#endif
        return dict[key].CGSizeValue;
    }

    UICollectionViewCell *cell = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass(clas) owner:nil options:nil].firstObject;

    UIView *sview = [UIView new];
    sview.frame = CGRectMake(0, 0, maxSize.width, maxSize.height);

    [sview addSubview:cell];
    cell.frame = CGRectMake(0, 0, maxSize.width, maxSize.height);

    !configuration ? :configuration(cell);

    [sview layoutIfNeeded];

    __block CGFloat maxX  = 0.0f;
    __block CGFloat maxY  = 0.0f;
    [cell.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat tempX = CGRectGetMaxX(obj.frame);
        CGFloat tempY = CGRectGetMaxY(obj.frame);
        if (tempX > maxX) {
            maxX = tempX;
        }
        if (tempY > maxY) {
            maxY = tempY;
        }
    }];
    if (key) {
#if DEBUG
        NSLog(@"保存 %@ size %@", key, [NSValue valueWithCGSize:CGSizeMake(maxX, maxY)]);
#endif
        dict[key] = (NSValue *)[NSValue valueWithCGSize:CGSizeMake(maxX, maxY)];
    }
    return CGSizeMake(maxX, maxY);
}

@end

@implementation UICollectionViewCell (UICollectionViewCellRegister)

+ (instancetype)bm_collectionViewCellWithCollectionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath *)indexPath {
    NSString *selfClassName = NSStringFromClass(self.class);
    BOOL registerCell = [objc_getAssociatedObject(collectionView, (__bridge const void * _Nonnull)(self)) boolValue];
    if (registerCell) {
        return [collectionView dequeueReusableCellWithReuseIdentifier:selfClassName forIndexPath:indexPath];
    }
    objc_setAssociatedObject(collectionView, (__bridge const void * _Nonnull)(self), @(YES) , OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:selfClassName ofType:@"nib"];
    if (path.length) {
        [collectionView registerNib:[UINib nibWithNibName:selfClassName bundle:nil] forCellWithReuseIdentifier:selfClassName];
    } else {
        [collectionView registerClass:self.class forCellWithReuseIdentifier:selfClassName];
    }
    return [self bm_collectionViewCellWithCollectionView:collectionView forIndexPath:indexPath];
}

@end

@implementation UICollectionReusableView (UICollectionReusableViewRegister)

+ (instancetype)bm_collectionReusableViewWithCollectionReusableView:(UICollectionView *)collectionView
                                                           isHeader:(BOOL)isHeader
                                                       forIndexPath:(NSIndexPath *)indexPath {
    
    NSString *kind = isHeader ? UICollectionElementKindSectionHeader : UICollectionElementKindSectionFooter;
    
    NSString *selfClassName = NSStringFromClass(self.class);
    
    BOOL registerFooter = [objc_getAssociatedObject(collectionView, (__bridge const void * _Nonnull)(self)) boolValue];
    
    if (registerFooter) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:selfClassName forIndexPath:indexPath];
    }
    
    // 绑定
    objc_setAssociatedObject(collectionView, (__bridge const void * _Nonnull)(self), @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:selfClassName ofType:@"nib"];
    if (path.length) {
        [collectionView registerNib:[UINib nibWithNibName:selfClassName bundle:nil] forSupplementaryViewOfKind:kind withReuseIdentifier:selfClassName];
    } else {
        [collectionView registerClass:self.class forSupplementaryViewOfKind:kind withReuseIdentifier:selfClassName];
    }
    return [self bm_collectionReusableViewWithCollectionReusableView:collectionView isHeader:isHeader forIndexPath:indexPath];
}

@end
