## 效果演示

<p align="center">
    <img  width="40%" src="1.gif"/>
<p/>

<p align="center">
<a href="#"><img src="https://img.shields.io/cocoapods/v/UICollectionViewDynamicLayoutCacheSize.svg"></a>
<a href="#"><img src="https://img.shields.io/badge/platform-iOS-red.svg"></a>
<a href="#"><img src="https://img.shields.io/badge/language-Objective--C-orange.svg"></a>
<a href="#"><img src="https://img.shields.io/badge/licenses-MIT-red.svg"></a>
</p>

## 介绍

- 🖖 Template auto layout cell for automatically UICollectionViewCell calculating and cache size framework, Only applicable to cells created by xib.

## CocoaPods

```ruby
pod 'UICollectionViewDynamicLayoutCacheSize'
```

```ruby
pod install
```

```objective-c
#import "UICollectionViewDynamicLayoutCacheSize.h"
```

## 使用说明

if your cell use autolayout , all you need just to do like this:

### Xib create cell

<p align="center">
    <img width="60%" src="1-1.png"/>
<p/>

### If `max x view` or `max y view`  fixed 

```objective-c
@property (nonatomic, assign) IBInspectable BOOL bm_maxXViewFixed; ///< maxX view whether fixed, default NO.
@property (nonatomic, assign) IBInspectable BOOL bm_maxYViewFixed; ///< maxY view whether fixed, default NO.
```

### Cell 最大宽度是固定的

```objective-c
/**
 get cell size with class width cacheIndexPath configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                  cellMaxWidth:(CGFloat)width
              cacheByIndexPath:(NSIndexPath *)indexPath
                 configuration:(BMCollectionViewCellDynamicLayoutConfigurationBlock)configuration;

/**
 get cell size with class width cacheKey configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                  cellMaxWidth:(CGFloat)width
                    cacheByKey:(id<NSCopying>)key
                 configuration:(BMCollectionViewCellDynamicLayoutConfigurationBlock)configuration;
```

### Cell 最大高度是固定的

```objective-c
/**
 get cell size with class height cacheIndexPath configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                 cellMaxHeight:(CGFloat)height
              cacheByIndexPath:(NSIndexPath *)indexPath
                 configuration:(BMCollectionViewCellDynamicLayoutConfigurationBlock)configuration;

/**
 get cell size with class height cacheKey configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                 cellMaxHeight:(CGFloat)height
                    cacheByKey:(id<NSCopying>)key
                 configuration:(BMCollectionViewCellDynamicLayoutConfigurationBlock)configuration;
```

### Cell 的最大 Size 是固定的

```objective-c
/**
 get cell size with class size cacheIndexPath configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                   cellMaxSize:(CGSize)size
              cacheByIndexPath:(NSIndexPath *)indexPath
                 configuration:(BMCollectionViewCellDynamicLayoutConfigurationBlock)configuration;

/**
 get cell size with class size cacheKey configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                   cellMaxSize:(CGSize)size
                    cacheByKey:(id<NSCopying>)key
                 configuration:(BMCollectionViewCellDynamicLayoutConfigurationBlock)configuration;
```

### Cell Size 是无限制的

```objective-c
/**
 get cell size with class cacheIndexPath configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
              cacheByIndexPath:(NSIndexPath *)indexPath
                 configuration:(BMCollectionViewCellDynamicLayoutConfigurationBlock)configuration;

/**
 get cell size with class cacheKey configuration
 */
- (CGSize)bm_sizeWithCellClass:(Class)clas
                    cacheByKey:(id<NSCopying>)key
                 configuration:(BMCollectionViewCellDynamicLayoutConfigurationBlock)configuration;

```

## License    

[UICollectionViewDynamicLayoutCacheSize](https://github.com/liangdahong/UICollectionViewDynamicLayoutCacheSize) is released under the [MIT license](LICENSE). See LICENSE for details.
