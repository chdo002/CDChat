//
//  MessageModalProtocal.h
//  Pods
//
//  Created by chdo on 2017/10/25.
//

#ifndef MessageModalProtocal_h
#define MessageModalProtocal_h

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
#endif /* MessageModalProtocal_h */
