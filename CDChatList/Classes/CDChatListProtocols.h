//
//  CDChatListProtocols.h
//  Pods
//
//  Created by chdo on 2017/10/26.
//

#ifndef CDChatListProtocols_h
#define CDChatListProtocols_h

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


@end


@protocol MessageCellProtocal

/**
 设置cell中的Data
 
 @param data 消息模型
 */
-(void)configCellByData:(id<MessageModalProtocal>)data;

@end


#endif /* CDChatListProtocols_h */
