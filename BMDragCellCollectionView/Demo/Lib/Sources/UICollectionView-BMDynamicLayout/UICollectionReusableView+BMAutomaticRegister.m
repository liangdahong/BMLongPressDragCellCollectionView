//
// https://github.com/liangdahong/UICollectionView-BMDynamicLayout
//

#import "UICollectionReusableView+BMAutomaticRegister.h"
#import <objc/runtime.h>

@implementation UICollectionReusableView (BMAutomaticRegister)

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
