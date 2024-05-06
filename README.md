# CDChatList

[![CI Status](http://img.shields.io/travis/chdo002/CDChatList.svg?style=flat)](https://travis-ci.org/chdo002/CDChatList)
[![Version](https://img.shields.io/cocoapods/v/CDChatList.svg?style=flat)](http://cocoapods.org/pods/CDChatList)
[![License](https://img.shields.io/cocoapods/l/CDChatList.svg?style=flat)](http://cocoapods.org/pods/CDChatList)
[![Platform](https://img.shields.io/cocoapods/p/CDChatList.svg?style=flat)](http://cocoapods.org/pods/CDChatList)


<img src="https://github.com/chdo002/CDChatList/blob/master/images/default.png?raw=true" width="150"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="https://github.com/chdo002/CDChatList/blob/master/images/custom.png?raw=true" width="150">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src="https://github.com/chdo002/CDChatList/blob/master/images/custom2.png?raw=true" width="150">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="https://coding.net/u/chdo/p/CDResource/git/raw/master/static4.jpg" width="150">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="https://coding.net/u/chdo/p/CDResource/git/raw/master/static5.jpg" width="150">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 

高性能的聊天页面解决方案
对聊天列表的高度封装，可灵活配置页面样式
高性能聊天对话组件，使用CoreText和手动代码布局，尽量实现简单，通用，高效，易于维护。


> 版本更新

* 0.2.1：将资源初始化方法简化 

* 0.1.3： 将CDLabel分离出去：[CDLabel](https://github.com/chdo002/cdlabel)

# 项目结构

CDChatListView: UITableView 视图，聊天页面主体

CDBaseMsgCell: 实现消息气泡基本视图

CDTextTableViewCell、CDImageTableViewCell、CDAudioTableViewCell: 继承自CDBaseMsgCell，实现响应功能。

CDSystemTableViewCell: 特殊消息气泡，实现系统通知

CellCaculator： tableview布局计算，并提前渲染cell

ChatConfiguration： chatlist配置类组，UI定制，及资源等

#### 子组件
CDLabel： 富文本标签

CDChatInputBox： 输入框封装组件

## 安装

支持至iOS 11

有时候需要清一下cocoapods的缓存，`pod cache clean --all`

```ruby
pod 'CDChatList'
```
```
#import <CDChatList/CDChatList.h>
```

## 使用

### 初始化lib资源

为了提高页面资源加载速度，demo中在启动时需要调用 ```[ChatHelpr.share configDefaultResource];``` 方法
后续版本中将会优化此处功能

### 配置 CDChatList

ChatHelpr负责ChatHelpr的UI配置，及组件的资源文件设置

UI配置及资源文件都有默认，所以无需自定义的话，就可以跳过组件的配置

具体详情可以看demo

### 添加 CDChatList 视图

```
CDChatListView *list = [[CDChatListView alloc] initWithFrame:self.view.bounds];
list.msgDelegate = self;
self.listView = list;
[self.view addSubview:self.listView];
```

CDChatList会将视图控制器automaticallyAdjustsScrollViewInsets及contentInsetAdjustmentBehavior设为NO及Never，并适应导航栏高度

### 消息模型  MessageModalProtocal

聊天组件提供了一个写好的消息Model：CDMessageModel

也可以使用自己的消息模型，实现相关的解析方法，

不管什么消息模型，都需遵守MessageModalProtocal，实现相关属性

### 组件事件 ChatListProtocol

#### 从聊天组件触发的消息

消息列表请求加载更多消息

```
-(void)chatlistLoadMoreMsg: (CDChatMessage)topMessage callback: (void(^)(CDChatMessageArray))finnished;
```

消息气泡上的的点击事件

```
-(void)chatlistClickMsgEvent: (ChatListInfo *)listInfo;
```

#### 调用聊天组件功能

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
-(void)chatlistLoadMoreMsg: (CDChatMessage)topMessa callback: (void(^)(CDChatMessageArray))finnished
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

#### 自定义消息气泡扩展

  通过实现下列两个方法实现自定义消息气泡的扩展，具体可见demo

```
-(NSDictionary<NSString *,Class> *)chatlistCustomeCellsAndClasses{
    return @{CustomeMsgCellReuseId: CustomeGifMsgCell.class, CustomNewsCellReuseId:CustomNewsCell.class};
}
```

```
-(CGSize)chatlistSizeForMsg:(CDChatMessage)msg ofList:(CDChatListView *)list{

    CGSize cellSize = CGSizeMake(200, 100);
    // ... 处理各种自定义类型消息的大小
    return cellSize;
}

```
