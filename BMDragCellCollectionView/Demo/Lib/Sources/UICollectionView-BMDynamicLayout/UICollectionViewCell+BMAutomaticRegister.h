//
// https://github.com/liangdahong/UICollectionView-BMDynamicLayout
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionViewCell (BMAutomaticRegister)

+ (instancetype)bm_collectionViewCellWithCollectionView:(UICollectionView *)collectionView
                                           forIndexPath:(NSIndexPath *)indexPath;

@end

NS_ASSUME_NONNULL_END
