//
//  CDChatListProtocols.h
//  Pods
//
//  Created by chdo on 2017/10/26.
//

#import "CDChatMacro.h"

#ifndef CDChatListProtocols_h
#define CDChatListProtocols_h



typedef enum : NSUInteger {
    CDMessageTypeText,      // 文字类型
    CDMessageTypeImage,     // 图片类型
    CDMessageTypeSystemInfo // 系统信息类型
} CDMessageType; // 消息类型

typedef enum : NSUInteger {
    CDMessageStateNormal,
    CDMessageStateSending,     // 发送中，图片消息上传中，文字消息发送中
    CDMessageStateDownloading, // 下载中， 图片消息下载中
    CDMessageStateFaild        // 消息发送失败
} CDMessageState;

/**
 消息模型
 */
@protocol MessageModalProtocal

/**
 消息内容
 */
@property (copy,nonatomic) NSString *msg;

/**
 发送时间
 */
@property (copy,nonatomic) NSString *createTime;

/**
 是否显示时间
 */
@property (assign,nonatomic) BOOL willDisplayTime;

/**
 消息类型
 */
@property (assign,nonatomic) CDMessageType msgType;

/**
 消息状态
 */
@property (assign,nonatomic) CDMessageState msgState;

/**
 消息ID
 */
@property (copy,nonatomic) NSString *messageId;

/**
 气泡宽度，缓存用
 */
@property (assign, nonatomic) CGFloat bubbleWidth;

/**
 cell高度，缓存用
 */
@property (assign, nonatomic) CGFloat cellHeight;

/**
 模型其他信息
 */
@property (copy, nonatomic) NSDictionary *modalInfo;



@end

typedef id<MessageModalProtocal> CDChatMessage;
typedef NSArray<CDChatMessage>* CDChatMessageArray;

/**
 消息cell
 */
@protocol MessageCellProtocal

/**
 设置cell中的Data
 
 @param data 消息模型
 */
-(void)configCellByData:(CDChatMessage)data;

@end

@protocol ChatListProtocol <NSObject>


/**
 请求加载更多消息

 @param topMessage 目前最早的消息
 @param finnished 加载完成回调
 */
-(void)loadMoreMsg: (CDChatMessage)topMessage
          callback: (void(^)(CDChatMessageArray))finnished;

@end

#endif /* CDChatListProtocols_h */









