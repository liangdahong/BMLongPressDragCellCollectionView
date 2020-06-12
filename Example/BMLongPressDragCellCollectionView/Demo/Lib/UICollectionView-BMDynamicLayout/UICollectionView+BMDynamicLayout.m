//
// https://github.com/liangdahong/UICollectionView-BMDynamicLayout
//

#import "UICollectionView+BMDynamicLayout.h"
#import <objc/runtime.h>

#define maxHeightWidth 888888.0f

@implementation UICollectionView (BMDynamicLayout)

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                                  key:(NSString *)key
                        configuration:(BMCollectionViewCellDynamicLayoutConfigurationBlock)configuration {
    return [self bm_sizeForCellWithCellClass:clas
                                     maxSize:CGSizeMake(maxHeightWidth, maxHeightWidth)
                                         key:key configuration:configuration];
}

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                             maxWidth:(CGFloat)maxWidth
                                  key:(NSString *)key
                        configuration:(BMCollectionViewCellDynamicLayoutConfigurationBlock)configuration {
    return [self bm_sizeForCellWithCellClass:clas
                                     maxSize:CGSizeMake(maxWidth, maxHeightWidth)
                                         key:key
                               configuration:configuration];
}

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                            maxHeight:(CGFloat)maxHeight
                                  key:(NSString *)key
                        configuration:(BMCollectionViewCellDynamicLayoutConfigurationBlock)configuration {
    return [self bm_sizeForCellWithCellClass:clas
                                     maxSize:CGSizeMake(maxHeightWidth, maxHeight)
                                         key:key
                               configuration:configuration];
}

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                              maxSize:(CGSize)maxSize
                                  key:(NSString *)key
                        configuration:(BMCollectionViewCellDynamicLayoutConfigurationBlock)configuration {

    NSMutableDictionary <NSString *, NSValue *> *dict = objc_getAssociatedObject(self, &clas);
    if (!dict) {
        dict = @{}.mutableCopy;
        objc_setAssociatedObject(self, &clas, dict, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }

    if (key && dict[key]) {
#if DEBUG
        NSLog(@"读缓存 { (key: %@) (size: %@) }", key, dict[key]);
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
        NSLog(@"保存缓存 { (key: %@) (size: %@) }", key, [NSValue valueWithCGSize:CGSizeMake(maxX, maxY)]);
#endif
        dict[key] = (NSValue *)[NSValue valueWithCGSize:CGSizeMake(maxX, maxY)];
    }
    return CGSizeMake(maxX, maxY);
}

@end
