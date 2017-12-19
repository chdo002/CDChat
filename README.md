# CDChatList (0.2.0)
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


## 使用

### 配置 CDChatList

ChatHelpr负责ChatHelpr的UI配置，及组件的资源文件设置
UI配置及资源文件都有默认，所以无需自定义的话，就可以跳过组件的配置

### 添加 CDChatList 视图


```
    CDChatList *list = [[CDChatList alloc] initWithFrame:self.view.bounds];
    list.msgDelegate = self;
    self.listView = list;
    [self.view addSubview:self.listView];
```

CDChatList会将视图控制器automaticallyAdjustsScrollViewInsets及contentInsetAdjustmentBehavior设为NO及Never，并适应导航栏高度

### 消息模型  MessageModalProtocal

消息模型需遵守MessageModalProtocal，实现相关属性

### 组件事件 ChatListProtocol

#### 从组件发出的消息

消息列表请求加载更多消息
```
-(void)chatlistLoadMoreMsg: (CDChatMessage)topMessage
                  callback: (void(^)(CDChatMessageArray))finnished;
```

消息中的点击事件
```
-(void)chatlistClickMsgEvent: (ChatListInfo *)listInfo;
```
#### 向组件发消息

添加新的数据到底部

```
-(void)addMessagesToBottom: (CDChatMessageArray)newBottomMsgArr;
```


更新数据源中的某条消息模型(主要是为了更新UI上的消息状态)

```
-(void)updateMessage:(CDChatMessage)message;
```

### 使用场景

#### 收/发消息

```Objective-C
// 发
{
    MessageModal *modal;
}
-(void)send{
    modal = [[MessageModal alloc] init];
    modal.msgState = CDMessageStateSending;
    modal.createTime = ...;
    modal.msg = ...;
    modal.msgType = ...;
    [chatList addMessagesToBottom: modal];
}

-(void)sendCallBack:(BOOL)isSuccess{
    modal.msgState = isSuccess;  // 此处应处理成枚举
    [chatList updateMessage: modal];
}



// 收
-(void)receivedNewMessage:(MessageModal *)modal{
    [chatList addMessagesToBottom: modal];
}

```

#### 下拉加载更多消息
消息列表被下拉时，触发此回调

```
-(void)chatlistLoadMoreMsg: (CDChatMessage)topMessage
                  callback: (void(^)(CDChatMessageArray))finnished
{
    // 根据topMessage 获取更多消息
    NSArray *msgArr = [self getMoreMessageFrom: topMessage amount: 10];
    callback(msgArr);
}
```

#### 消息点击事件

目前消息体重处理了 文本点击 及 图片点击 事件

```
-(void)chatlistClickMsgEvent: (ChatListInfo *)listInfo{
    if (listInfo.eventType == ChatClickEventTypeTEXT){
        // 点击的文本
        listInfo.clickedText
        // 点击的文字位置  防止有相同的可点击文字
        listInfo.range
        // 被点击文本的隐藏信息   e.g.  <a title="转人工" href="doTransfer">
        listInfo.clickedTextContent
    } else if (listInfo.eventType == ChatClickEventTypeIMAGE){
        // 图片
        listInfo.image
        // 图片在tableview中的位置
        listInfo.msgImageRectInTableView
    }
}
```



## TODO

- 实现异步加载图片，去除对SDWebImage依赖
- 添加音频消息类型
- 自定义消息内容匹配    去人工
- 头像漏做
- 消息中添加extra类型 