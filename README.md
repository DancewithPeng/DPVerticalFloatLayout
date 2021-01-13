# DPVerticalFloatLayout

[TOC]

垂直浮动布局，适用于多个不同宽度标签的实现



## 导入

### CocoaPods

在`Podfile`文件中加入

```ruby
pod 'DPVerticalFloatLayout', '~> 1.0'
```



## 使用

在UICollectionView初始化时指定

```objc
DPVerticalFloatLayout *layout = [[DPVerticalFloatLayout alloc] init];
UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:rect collectionViewLayout:layout];
```

或者在Interface Builder中指定布局的类型

<img src="http://markdownimages.dpdev.cn/images/image-20210113112348123.png" alt="image-20210113112348123" style="zoom: 67%;" />



## LICENSE

此项目采用**MIT**开源协议，[点击查看详情](LICENSE)

