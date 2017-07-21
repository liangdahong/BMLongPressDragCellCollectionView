# XWDragCellCollectionView
封装的CollectionView的拖动重排的效果控件，先请看图：(吐槽:不知道为啥从xcode7开始，模拟器变得很卡很卡，所以截图的效果不好，大家可以在真机上测试，效果还是非常不错的)
####图1：垂直滚动

![drag1.gif](http://ww2.sinaimg.cn/mw690/5ededce5gw1ezoq84h05ig208m0gawwn.gif)
####图2：水平滚动

![drag2.gif](http://ww1.sinaimg.cn/mw690/5ededce5gw1ezoq869c1ig208m0gahb3.gif)
####图3：配合瀑布流

![drag5.gif](http://ww3.sinaimg.cn/mw690/5ededce5gw1ezoq8a18dzg208m0gab2a.gif)


使用也非常简单，只需3步，步骤如下：

```
1、继承于XWDragCellCollectionView；

2、实现必须实现的DataSouce代理方法：（在该方法中返回整个CollectionView的数据数组用于重排）
    - (NSArray *)dataSourceArrayOfCollectionView:(XWDragCellCollectionView *)collectionView;
    
3、实现必须实现的一个Delegate代理方法：（在该方法中将重拍好的新数据源设为当前数据源）(例如 :_data = newDataArray)
    - (void)dragCellCollectionView:(XWDragCellCollectionView *)collectionView newDataArrayAfterMove:(NSArray *)newDataArray;
    
 ```
 
详细的使用可以查看代码中的demo，支持设置长按事件，是否开启边缘滑动，抖动、以及设置抖动等级，这些在h文件里面都有详细说明，有需要的可以尝试一下，并多多提意见，详细请浏览我的简书：[可拖拽重排的CollectionView](http://www.jianshu.com/p/8f0153ce17f9)
