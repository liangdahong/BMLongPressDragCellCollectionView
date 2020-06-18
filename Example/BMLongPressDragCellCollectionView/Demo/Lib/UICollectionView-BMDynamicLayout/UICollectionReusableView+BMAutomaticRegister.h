//
// https://github.com/liangdahong/UICollectionView-BMDynamicLayout
//


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionReusableView (BMAutomaticRegister)

+ (instancetype)bm_collectionReusableViewWithCollectionReusableView:(UICollectionView *)collectionView
                                                           isHeader:(BOOL)isHeader
                                                       forIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
