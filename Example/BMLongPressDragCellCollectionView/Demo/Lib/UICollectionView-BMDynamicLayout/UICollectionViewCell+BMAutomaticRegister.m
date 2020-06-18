//
// https://github.com/liangdahong/UICollectionView-BMDynamicLayout
//

#import "UICollectionViewCell+BMAutomaticRegister.h"
#import <objc/runtime.h>

@implementation UICollectionViewCell (BMAutomaticRegister)

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
