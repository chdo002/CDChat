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
@property (retain,nonatomic) NSString *messageId;

@end



@protocol MessageCellProtocal

/**
 计算cell高度
 
 @return cell高度
 */
+(CGFloat)heightForMessage;


@end


#endif /* CDChatListProtocols_h */
