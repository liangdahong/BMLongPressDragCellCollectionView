<p align="center">
    <img  width="22%" src="https://user-images.githubusercontent.com/12118567/89103527-18ac5300-d445-11ea-9d33-9581e1cde40d.gif"/>
    <img  width="22%" src="https://user-images.githubusercontent.com/12118567/89103536-1c3fda00-d445-11ea-9814-32e78c067548.gif"/>
    <img  width="22%" src="https://user-images.githubusercontent.com/12118567/89103541-1fd36100-d445-11ea-90e3-4e8f955476a3.gif">
    <img  width="22%" src="https://user-images.githubusercontent.com/12118567/89103543-2235bb00-d445-11ea-81d5-0ebe5f95ab8c.gif"/>
<p/>

<p align="center">
<a href="https://en.wikipedia.org/wiki/IOS"><img src="https://img.shields.io/badge/platform-iOS-red.svg"></a>
<a href="https://en.wikipedia.org/wiki/IOS_8"><img src="https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat"></a>
<a href="https://github.com/liangdahong/BMLongPressDragCellCollectionView/releases"><img src="https://img.shields.io/cocoapods/v/BMLongPressDragCellCollectionView.svg"></a>
<a href="https://github.com/liangdahong/BMLongPressDragCellCollectionView/stargazers"><img src="https://img.shields.io/github/stars/liangdahong/BMLongPressDragCellCollectionView.svg"></a>
<a href="https://en.wikipedia.org/wiki/Objective-C"><img src="https://img.shields.io/badge/language-Objective--C-orange.svg"></a>
<a href="https://github.com/liangdahong/BMLongPressDragCellCollectionView/blob/master/LICENSE"><img src="https://img.shields.io/badge/licenses-MIT-red.svg"></a>
</p>

## Introduction

- This framework lets you easily add drag-and-drop rearrangement functionality similar to the Alipay app. It supports customization - check out the code for details. (`iOS 8+`)

## Installation (CocoaPods)

```ruby
pod 'BMLongPressDragCellCollectionView'
pod install
#import "BMLongPressDragCellCollectionView.h"
```

## Installation (Manual)
- Download the project `git clone https://github.com/liangdahong/BMLongPressDragCellCollectionView.git`
- Drag and drop all the contents of the `BMLongPressDragCellCollectionView` folder to your project

## Usage
1. `BMLongPressDragCellCollectionView` is a subclass of `UICollectionView`, so usage is the exact same as `UICollectionView`. Just replace `UICollectionView` with `BMLongPressDragCellCollectionView` in your Xib or StoryBoard.
2. Replace your `UICollectionViewDataSource` with `MLongPressDragCellCollectionViewDataSource`
3. Replace your `UICollectionViewDelegateFlowLayout` with `BMLongPressDragCellCollectionViewDelegate`
4. Implement the data source method, which will be used internally to obtain the data source. **This is required.** The data structure of `NSArray< NSArray<id> *> *` is for the internal `cell` data source's sort processing.

```
- (NSArray< NSArray<id> *> *)dataSourceWithDragCellCollectionView:(__kindof BMLongPressDragCellCollectionView *)dragCellCollectionView;
```

Implementation:

```
- (NSArray<NSArray<id> *> *)dataSourceWithDragCellCollectionView:(__kindof BMLongPressDragCellCollectionView *)dragCellCollectionView {
    return self.dataSourceArray;
}
```

5. Implement the proxy method, which is called when a `cell` is swapped with another `cell`. The latest data source needs to be saved outside (If there is an exchange, the data source is updated). **This is also required.**

```
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(nullable NSArray< NSArray<id> *> *)newDataArray;
```

Implementation:

```
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(nullable NSArray< NSArray<id> *> *)newDataArray {
    self.dataSourceArray = [newDataArray mutableCopy];
}
```

## Usage screenshots

### Xib or StoryBoard
<img  width="80%" src="https://user-images.githubusercontent.com/12118567/104813292-421a3900-5843-11eb-9bd9-13a46ebcf015.png"/>
<img  width="80%" src="https://user-images.githubusercontent.com/12118567/104813294-447c9300-5843-11eb-9b31-29046218b913.png"/>
<img  width="80%" src="https://user-images.githubusercontent.com/12118567/104813295-45adc000-5843-11eb-8fa3-b8300a0ae03a.png"/>

In a Xib or StoryBoard, you only need the above 3 steps to make your `UICollectionView` support drag and drop rearrangement perfectly.


### Programmatically

<img  width="80%" src="https://user-images.githubusercontent.com/12118567/104813262-0d0de680-5843-11eb-97d2-145527ffa90b.png"/>
<img  width="80%" src="https://user-images.githubusercontent.com/12118567/104813264-0f704080-5843-11eb-80c2-3e7a5e59bf65.png"/>
<img  width="80%" src="https://user-images.githubusercontent.com/12118567/104813266-113a0400-5843-11eb-9df7-4fb3ad14c752.png"/>
<img  width="22%" src="https://user-images.githubusercontent.com/12118567/89103546-28c43280-d445-11ea-95ab-d599a0e5b41e.gif"/>

Programmatically, you only need the above 3 steps to make your `UICollectionView` support drag and drop rearrangement perfectly.

## Customization

If you want to add custom behavior, you can set the relevant properties of `BMLongPressDragCellCollectionView` or implement some specific protocol methods (find them in the header file of `BMLongPressDragCellCollectionView` and the protocol of `BMLongPressDragCellCollectionViewDelegate` and `BMLongPressDragCellCollectionViewDataSource`)

## Contact
- Please raise an [issue](https://github.com/liangdahong/BMLongPressDragCellCollectionView/issues) or make a [PR](https://github.com/liangdahong/BMLongPressDragCellCollectionView/pulls)
- Check out our WeChat group <img width="20%" src="https://user-images.githubusercontent.com/12118567/86319172-72fb9d80-bc66-11ea-8c6e-8127f9e5535f.jpg"/>

## Other

- A pure Swift rewrite is planned for August 5, 2020...

## Credits

- The core implementation is based off [XWDragCellCollectionView](https://github.com/wazrx/XWDragCellCollectionView). Special thanks!

## Tips

- 🖖 Use a high-performance auto-height for `UITableViewCell` and `UITableViewHeaderFooterView`. An [internal height cache](https://github.com/liangdahong/UITableViewDynamicLayoutCacheHeight) is also automatically managed.

## License    
BMLongPressDragCellCollectionView is released under the [MIT license](LICENSE). See LICENSE for details.

## Self-promo time! Here's some of my other programs. If you're interested, please check them out!

Convenient calendar app, supports holidays, breaks, etc | Convenient payroll tax cut calculator
--- | ---
![rl](https://user-images.githubusercontent.com/12118567/109082668-64a34a00-773f-11eb-93cd-bc83b55fd846.jpg) | ![jsq](https://user-images.githubusercontent.com/12118567/109082681-6836d100-773f-11eb-9700-c8d217ccdbd5.jpg)
