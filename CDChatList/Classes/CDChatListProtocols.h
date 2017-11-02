//
//  CDChatListProtocols.h
//  Pods
//
//  Created by chdo on 2017/10/26.
//

#import "CDChatMacro.h"

#ifndef CDChatListProtocols_h
#define CDChatListProtocols_h

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
@property (copy,nonatomic) NSString *msgType;

/**
 消息ID
 */
@property (copy,nonatomic) NSString *messageId;

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

@protocol ChatListProtocol


/**
 请求加载更多消息

 @param topMessage 目前最早的消息
 @param finnished 加载完成回调
 */
-(void)loadMoreMsg: (CDChatMessage)topMessage
          callback: (void(^)(CDChatMessageArray))finnished;

@end

#endif /* CDChatListProtocols_h */









