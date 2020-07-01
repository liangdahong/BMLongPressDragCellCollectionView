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

///////////////
///   v3.1.0
///////////////

#ifndef UICollectionViewDynamicLayoutCacheSize_h
#define UICollectionViewDynamicLayoutCacheSize_h

#ifdef DEBUG
    #define BM_UICollectionView_LOG(...) if (UICollectionViewDynamicLayoutCacheSize.isDebugLog) {NSLog(__VA_ARGS__);}
#else
    #define BM_UICollectionView_LOG(...)
#endif

#import "UICollectionReusableView+BMDynamicLayout.h"
#import "UICollectionViewCell+BMDynamicLayout.h"
#import "UICollectionView+BMDynamicLayout.h"

@interface UICollectionViewDynamicLayoutCacheSize : NSObject

/// 是否开启 debug Log，默认 YES 开启。
@property (class, nonatomic, assign, getter=isDebugLog) BOOL debugLog;

@end

#endif
