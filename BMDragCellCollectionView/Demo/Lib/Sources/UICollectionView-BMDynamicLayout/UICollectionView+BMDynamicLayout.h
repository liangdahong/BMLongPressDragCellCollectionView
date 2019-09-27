//
// https://github.com/liangdahong/UICollectionView-BMDynamicLayout
//

#import <UIKit/UIKit.h>
#import "UICollectionViewCell+BMAutomaticRegister.h"
#import "UICollectionReusableView+BMAutomaticRegister.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^BMCollectionViewCellDynamicLayoutConfigurationBlock)(__kindof UICollectionViewCell *cell);

@interface UICollectionView (BMDynamicLayout)

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                                  key:(NSString *)key
                        configuration:(BMCollectionViewCellDynamicLayoutConfigurationBlock)configuration;

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                             maxWidth:(CGFloat)maxWidth
                                  key:(NSString *)key
                        configuration:(BMCollectionViewCellDynamicLayoutConfigurationBlock)configuration;

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                            maxHeight:(CGFloat)maxHeight
                                  key:(NSString *)key
                        configuration:(BMCollectionViewCellDynamicLayoutConfigurationBlock)configuration;

- (CGSize)bm_sizeForCellWithCellClass:(Class)clas
                              maxSize:(CGSize)maxSize
                                  key:(NSString *)key
                        configuration:(BMCollectionViewCellDynamicLayoutConfigurationBlock)configuration;

@end

NS_ASSUME_NONNULL_END
