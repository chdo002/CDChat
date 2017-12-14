# CDChatList
iOS 聊天界面的组件

## 支持

iOS 8 +

## 安装

####  作为pod依赖 在podfile中添加

```
pod 'CDChatList', :source => 'http://git-ma.paic.com.cn/aat/AATComponent_iOS.git'
```

####  作为framework 集成

```
pod package CDChatList.podspec --force  -verbose
```

####  作为静态库集成

```
pod package CDChatList.podspec --library  --force  -verbose
```


没有cocoapods-packager，则通过下面命令安装
```
 sudo gem install cocoapods-packager
```


## TODO

- 实现异步加载图片，去除对SDWebImage依赖
- 添加音频消息类型
