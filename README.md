# CDDGroupAvatar


[![CocoaPods](https://img.shields.io/cocoapods/v/CDDGroupAvatar.svg)](https://cocoapods.org/pods/YBImageBrowser)&nbsp;[![CocoaPods](https://img.shields.io/cocoapods/p/CDDGroupAvatar.svg)](https://github.com/indulgeIn/CDDGroupAvatar)&nbsp;

#### 这框架的初衷是想使群头像的实现尽可能的能像`SDWebImage`加载一张图片那么简单


#### 博客地址：

[iOS 群头像框架 — CDDGroupAvatar](https://www.jianshu.com/p/f1acb0c0fb97)

[博客](http://chendiandian.fun/2019/08/06/iOS-%E7%BE%A4%E5%A4%B4%E5%83%8F%E6%A1%86%E6%9E%B6-CDDGroupAvatar/)

![GIF](https://github.com/RocketsChen/CDDGroupAvatar/blob/master/CDDGroupAvatar.gif)

#### 安装：

* CocoaPods

1：在 Podfile 中添加 pod '`CDDGroupAvatar`'，执行 pod install 或 pod update。

* 手动导入

1：将demo项目中的 `CDDGroupAvatar` 文件夹所有内容拖入你的工程中。
2：集成 SDWebImage 框架。

* 用法

1：导入`#import <CDDGroupAvatar/DCAvatar.h>`可以拥有全部功能。
2：调用对应控件的类方法。
3：如果有使用上的疑问，可以下载演示demo进行查看。

#### 代码：

```
#import <CDDGroupAvatar/DCAvatar.h>
...

// UIImageView
[self.avImageViewW8 dc_setImageAvatarWithGroupId:@"avImageViewW8" Source:_groupNum8];

// UIButton
// Image
[self.avaButton dc_setImageAvatarWithGroupId:@"avaButton" Source:_groupNum9 forState:0];
// Background
[self.avaBgButton dc_setBackgroundImageAvatarWithGroupId:@"avaBgButton" Source:_groupNum4 forState:0];
```

#### 关于版本：
目前仅有OC版本，暂无Swift

