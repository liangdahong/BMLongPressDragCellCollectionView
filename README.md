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

## 介绍

- 本框架是一个让你轻松实现类似支付宝的拖拽重排功能，支持自定义，`iOS8+`，具体可查看代码。

##  CocoaPods 安装

```ruby
pod 'BMLongPressDragCellCollectionView'
pod install
#import "BMLongPressDragCellCollectionView.h"
```

##  手动安装
- 下载项目 「 `clone https://github.com/liangdahong/BMLongPressDragCellCollectionView.git` 」
-  将 `BMLongPressDragCellCollectionView`  文件夹下的全部内容拖拽到你的项目。

## 使用说明
1. `BMLongPressDragCellCollectionView` 是继自 `UICollectionView` ，其使用方式和 `UICollectionView` 一致，只需要把 `UICollectionView` 修改为 `BMLongPressDragCellCollectionView` 即可【支持 Xib，StoryBoard】。
2. 原来的 `UICollectionViewDataSource` 换为 B`MLongPressDragCellCollectionViewDataSource` 
3. 原来的 `UICollectionViewDelegateFlowLayout` 换为 `BMLongPressDragCellCollectionViewDelegate`。
4. 实现数据源方法，内部会使用此方法获取数据源，必须实现，之所以设计为  `NSArray< NSArray<id> *> *` 的数据结构是因为内部要对  `cell` 【数据源】做排序处理。

```
- (NSArray< NSArray<id> *> *)dataSourceWithDragCellCollectionView:(__kindof BMLongPressDragCellCollectionView *)dragCellCollectionView;
```

如下：

```
- (NSArray<NSArray<id> *> *)dataSourceWithDragCellCollectionView:(__kindof BMLongPressDragCellCollectionView *)dragCellCollectionView {
    return self.dataSourceArray;
}
```

5. 实现代理方法，当 Cell 有交换时调用，需要外面保存最新的数据源【如果有交换时，数据源已经更新】，必须实现。

```
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(nullable NSArray< NSArray<id> *> *)newDataArray;
```
如下：

```
- (void)dragCellCollectionView:(BMLongPressDragCellCollectionView *)dragCellCollectionView newDataArrayAfterMove:(nullable NSArray< NSArray<id> *> *)newDataArray {
    self.dataSourceArray = [newDataArray mutableCopy];
}
```

## 图文演示

### 在 `Xib`或者 `StoryBoard` 中使用
<img  width="80%" src="https://user-images.githubusercontent.com/12118567/104813292-421a3900-5843-11eb-9bd9-13a46ebcf015.png"/>
<img  width="80%" src="https://user-images.githubusercontent.com/12118567/104813294-447c9300-5843-11eb-9b31-29046218b913.png"/>
<img  width="80%" src="https://user-images.githubusercontent.com/12118567/104813295-45adc000-5843-11eb-8fa3-b8300a0ae03a.png"/>

- 在 `Xib`或者 `StoryBoard` 中只需要上面的 `3 步`就可以让你的 `UICollectionView` 完美支持拖拽重排了。

### 使用纯代码实现

<img  width="80%" src="https://user-images.githubusercontent.com/12118567/104813262-0d0de680-5843-11eb-97d2-145527ffa90b.png"/>
<img  width="80%" src="https://user-images.githubusercontent.com/12118567/104813264-0f704080-5843-11eb-80c2-3e7a5e59bf65.png"/>
<img  width="80%" src="https://user-images.githubusercontent.com/12118567/104813266-113a0400-5843-11eb-9df7-4fb3ad14c752.png"/>
<img  width="22%" src="https://user-images.githubusercontent.com/12118567/89103546-28c43280-d445-11ea-95ab-d599a0e5b41e.gif"/>

- 在纯代码实现中只需要上面的 `3 步` 就可以让你的 `UICollectionView` 完美支持拖拽重排了。

## 更多自定义方案

如果要做一些自定义的操作可以通过设置 `BMLongPressDragCellCollectionView` 的相关属性或者实现一些特定的协议方法来处理，可查看 `BMLongPressDragCellCollectionView` 的头文件和 `BMLongPressDragCellCollectionViewDelegate` 与 `BMLongPressDragCellCollectionViewDataSource` 协议。

## 联系
- 欢迎 [issues](https://github.com/liangdahong/BMLongPressDragCellCollectionView/issues) 和 [PR](https://github.com/liangdahong/BMLongPressDragCellCollectionView/pulls)
- 也可以添加微信<img width="20%" src="https://user-images.githubusercontent.com/12118567/86319172-72fb9d80-bc66-11ea-8c6e-8127f9e5535f.jpg"/> 进微信交流群。

## 其他

- 定个小目标 😂 2020年08月05日 纯 Swift 正在计划中... 

## 感谢

- 核心实现参考自[XWDragCellCollectionView](https://github.com/wazrx/XWDragCellCollectionView) 特别感谢。

## 相关推荐

- 🖖高性能的自动计算采用 Autolayout 布局的 UITableViewCell 和 UITableViewHeaderFooterView 的高度，内部自动管理高度缓存。
[https://github.com/liangdahong/UITableViewDynamicLayoutCacheHeight](https://github.com/liangdahong/UITableViewDynamicLayoutCacheHeight)

## License    
BMLongPressDragCellCollectionView is released under the [MIT license](LICENSE). See LICENSE for details.
