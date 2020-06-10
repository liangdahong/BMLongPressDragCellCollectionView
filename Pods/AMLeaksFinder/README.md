## 介绍

本项目是一款用于自动检测项目中【控制器内存泄漏】的工具，只需要把 `Sources` 路径下的文件拖入项目即可，效果如下，在上线时请务必移除，推荐使用 Cocoapods 导入 ，如果你感兴趣可以一起聊聊。

<p align="center">
<a href="https://en.wikipedia.org/wiki/IOS"><img src="https://img.shields.io/badge/platform-iOS-red.svg"></a>
<a href="https://en.wikipedia.org/wiki/IOS_8"><img src="https://img.shields.io/badge/support-iOS%208%2B%20-blue.svg?style=flat"></a>
<a href="https://github.com/liangdahong/AMLeaksFinder/releases"><img src="https://img.shields.io/cocoapods/v/AMLeaksFinder.svg"></a>
<a href="https://en.wikipedia.org/wiki/Objective-C"><img src="https://img.shields.io/badge/language-Objective--C-orange.svg"></a>
<a href="https://github.com/liangdahong/AMLeaksFinder/blob/master/LICENSE"><img src="https://img.shields.io/badge/licenses-MIT-red.svg"></a>
</p>

[English 📔](README_EN.md)

## 原理分析 
- [原理分析](principle.md)

## Cocoapods

```
pod 'AMLeaksFinder', '1.2.1',  :configurations => ['Debug']
```

- 如果想查看控制器的强引用链，导入：facebook 的 [FBRetainCycleDetector](https://github.com/facebook/FBRetainCycleDetector) 框架即可。

```
pod 'FBRetainCycleDetector',  :configurations => ['Debug']
```

## 效果演示

<p align="center">
    <img  width="25%" src="Images/003.gif"/>
    <img  width="25%" src="Images/001.gif"/>
    <img  width="25%" src="Images/002.gif"/>
    <img  width="99%" src="Images/101.png"/>
<p/>

## 联系
- 欢迎 [issues](https://github.com/liangdahong/AMLeaksFinder/issues) 和 [PR](https://github.com/liangdahong/AMLeaksFinder/pulls)
