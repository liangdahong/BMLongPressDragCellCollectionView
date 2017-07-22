
# BMDragCellCollectionView
[![Version](https://img.shields.io/cocoapods/v/BMDragCellCollectionView.svg?style=flat)](http://cocoapods.org/pods/BMDragCellCollectionView) 
![](https://img.shields.io/badge/platform-iOS-red.svg) ![](https://img.shields.io/badge/language-Objective--C-orange.svg) 
![](https://img.shields.io/badge/license-MIT%20License-brightgreen.svg) 
[![Support](https://img.shields.io/badge/support-iOS%206%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/) 
[![Weibo](https://img.shields.io/badge/Sina微博-@梁大红-yellow.svg?style=flat)](http://weibo.com/liangdahong) 
[![GitHub stars](https://img.shields.io/github/stars/asiosldh/BMDragCellCollectionView.svg)](https://github.com/asiosldh/BMDragCellCollectionView/stargazers)
## 写在前面
> 最近公司准备做一个类似支付宝`UICollectionViewCell`拖拽重排的功能，`UICollectionViewCell`的任意拖拽排列，支付宝最新的版本已去掉了任意拖拽功能，而只是对常用功能进行拖拽重排，没有出现超出屏幕的情况。个人感觉应该更好，毕竟太多功能去拖拽重排对用户来说是一个特别大的工作量，只需把常用功能提即可。相应的功能点还是在对应的分组里，至于我们的需求暂时不怎么清楚，使用还是研究下任意拖拽吧。

## 一点说明
> 部分Demo及文档正在完善中。

1. `支付宝`拖拽效果实现。
2. `今日头条`频道拖拽重排效果实现。
3. `看荐`拖拽重排效果实现及优化。ps:`看荐`的拖拽重排发现一个bug，哈哈。
4. ...

## 效果图 
### 效果1
<img src="Resources/2.gif" width="40%">
### 效果1
<img src="Resources/1.gif" width="40%">


## 使用
```Ruby
pod 'BMScan', '~> 0.1.7'
```		

## 使用到的技术
1. UICollectionView 的基本使用
2. CADisplayLink 简单使用
3. 屏幕快照

## 思路分析
### 需求分析
> 以支付宝之前的功能来说，我们长按 `Cell` 时进入可拖拽模式，长按下的`Cell`放大同时根着手指移动，当移动的`Cell`中心点移动到另外的`Cell`时与之交换，当移到接近屏幕`UICollectionView`边缘时滚动`UICollectionView`使用其自动显示出其他的`Cell`。

### 技术分析
1. 为`UICollectionView`增加长按手势
2. 在`Cell` 上触发手势时，使用系统截图快照生成一个和`Cell`一样的`View`，同时把`Cell`隐藏
3. 随着手指的移动，把屏幕快照`View` 随着手指
4. 当中心点移动到其他的`Cell`时调用`UICollectionView`的相关方法使其交换
5. 当移到接近屏幕`UICollectionView`边缘时使用`CADisplayLink`来处理`UICollectionView`的滚动
6. 当结束手势时，将截图快照view移动到隐藏的cell同时删除截图快照view，把隐藏的`Cell`显示即可。
7. 交换条件处理（交换临界点处理）
8. 其实`iOS9` 以后系统已提供了相应方法，但是必须在`iOS9+`使用，所以暂未使用系统方法

### 代码实现
> 具体代码实现就不讲解了，可以查看demo代码。代码有完整注释，暂未封装，以后会封装下。

1. [完整Demo](https://github.com/asiosldh/BMDragCellCollectionView)
2. [blog讲解](http://idhong.com/2017/07/17/iOS-UICollectionView-Cell%E6%8B%96%E6%8B%BD%E9%87%8D%E6%8E%92%E7%9A%84%E5%AE%9E%E7%8E%B0/)
