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

#import "UICollectionReusableView+BMDynamicLayout.h"
#import <objc/runtime.h>

static const void *headerRegisteredKey = &headerRegisteredKey;
static const void *footerRegisteredKey = &footerRegisteredKey;

@implementation UICollectionReusableView (BMDynamicLayout)

+ (instancetype)bm_collectionReusableViewFromNibWithCollectionView:(UICollectionView *)collectionView
                                                           kind:(NSString *)elementKind
                                                   forIndexPath:(NSIndexPath *)indexPath {
    if (elementKind == UICollectionElementKindSectionHeader) {
        NSString *reuseIdentifier = [NSStringFromClass(self.class) stringByAppendingString:@"HeaderViewreuseIdentifier"];
        return [self bm_collectionReusableViewWithCollectionView:collectionView
                                                           isNib:YES
                                                            kind:UICollectionElementKindSectionHeader
                                                    forIndexPath:indexPath
                                                 reuseIdentifier:reuseIdentifier
                                                             key:headerRegisteredKey];
    }
    NSString *reuseIdentifier = [NSStringFromClass(self.class) stringByAppendingString:@"FooterViewreuseIdentifier"];
    return [self bm_collectionReusableViewWithCollectionView:collectionView
                                                       isNib:YES
                                                        kind:UICollectionElementKindSectionFooter
                                                forIndexPath:indexPath
                                             reuseIdentifier:reuseIdentifier
                                                         key:footerRegisteredKey];
}

+ (instancetype)bm_collectionReusableViewFromAllocWithCollectionView:(UICollectionView *)collectionView
                                                          kind:(NSString *)elementKind
                                                  forIndexPath:(NSIndexPath *)indexPath {
    if (elementKind == UICollectionElementKindSectionHeader) {
        NSString *reuseIdentifier = [NSStringFromClass(self.class) stringByAppendingString:@"HeaderViewreuseIdentifier"];
        return [self bm_collectionReusableViewWithCollectionView:collectionView
                                                           isNib:NO
                                                            kind:UICollectionElementKindSectionHeader
                                                    forIndexPath:indexPath
                                                 reuseIdentifier:reuseIdentifier
                                                             key:headerRegisteredKey];
    }
    NSString *reuseIdentifier = [NSStringFromClass(self.class) stringByAppendingString:@"FooterViewreuseIdentifier"];
    return [self bm_collectionReusableViewWithCollectionView:collectionView
                                                       isNib:NO
                                                        kind:UICollectionElementKindSectionFooter
                                                forIndexPath:indexPath
                                             reuseIdentifier:reuseIdentifier
                                                         key:footerRegisteredKey];
}


+ (instancetype)bm_collectionReusableViewWithCollectionView:(UICollectionView *)collectionView
                                                      isNib:(BOOL)isNib
                                                       kind:(NSString *)elementKind
                                               forIndexPath:(NSIndexPath *)indexPath
                                            reuseIdentifier:(NSString *)reuseIdentifier
                                                        key:(const void *)key {
    NSString *selfClassName = NSStringFromClass(self.class);
    BOOL registered = [objc_getAssociatedObject(collectionView, key) boolValue];
    if (registered) {
        return [collectionView dequeueReusableSupplementaryViewOfKind:elementKind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    }

    // 绑定
    objc_setAssociatedObject(collectionView, key, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

    if (!isNib) {
        [collectionView registerClass:self.class forSupplementaryViewOfKind:elementKind withReuseIdentifier:reuseIdentifier];
        return [collectionView dequeueReusableSupplementaryViewOfKind:elementKind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    }
    
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    NSString *path = [bundle pathForResource:selfClassName ofType:@"nib"];
    if (path.length == 0) {
        NSAssert(NO, @"你的 UICollectionReusableView 不是 IB 创建的");
        return nil;
    }
    [collectionView registerNib:[UINib nibWithNibName:selfClassName bundle:bundle] forSupplementaryViewOfKind:elementKind withReuseIdentifier:reuseIdentifier];
    return [collectionView dequeueReusableSupplementaryViewOfKind:elementKind withReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
}

@end
