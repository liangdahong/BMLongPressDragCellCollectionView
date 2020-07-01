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

#import <UIKit/UIKit.h>
#import "UICollectionReusableView+BMDynamicLayout.h"
#import "UICollectionViewCell+BMDynamicLayout.h"

@interface UICollectionView (BMDynamicLayout)

#pragma mark - no cache

/**
 get cell size with class width configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                  cellMaxWidth:(CGFloat)width
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration;

/**
 get cell size with class height configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                 cellMaxHeight:(CGFloat)height
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration;

/**
 get cell size with class size configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                   cellMaxSize:(CGSize)size
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration;

/**
 get cell size with class  configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration;

#pragma mark - indexPath cache

/**
 get cell size with class width cacheIndexPath configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                  cellMaxWidth:(CGFloat)width
              cacheByIndexPath:(NSIndexPath *)indexPath
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration;

/**
 get cell size with class height cacheIndexPath configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                 cellMaxHeight:(CGFloat)height
              cacheByIndexPath:(NSIndexPath *)indexPath
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration;

/**
 get cell size with class size cacheIndexPath configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                   cellMaxSize:(CGSize)size
              cacheByIndexPath:(NSIndexPath *)indexPath
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration;

/**
 get cell size with class cacheIndexPath configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
              cacheByIndexPath:(NSIndexPath *)indexPath
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration;

#pragma mark - key cache

/**
 get cell size with class width cacheKey configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                  cellMaxWidth:(CGFloat)width
                    cacheByKey:(id<NSCopying>)key
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration;

/**
 get cell size with class height cacheKey configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                 cellMaxHeight:(CGFloat)height
                    cacheByKey:(id<NSCopying>)key
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration;

/**
 get cell size with class size cacheKey configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                   cellMaxSize:(CGSize)size
                    cacheByKey:(id<NSCopying>)key
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration;

/**
 get cell size with class cacheKey configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                    cacheByKey:(id<NSCopying>)key
                 configuration:(void (^)(__kindof UICollectionViewCell *cell))configuration;

@end
