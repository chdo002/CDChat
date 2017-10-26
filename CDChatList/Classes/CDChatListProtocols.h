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
@property (assign, nonatomic) CGFloat *cellHeight;


/**
 计算cell高度
 
 @return cell高度
 */
+(CGFloat)heightForMessage;

@end


@protocol MessageCellProtocal

/**
 设置cell中的Data
 
 @param data 消息模型
 */
-(void)configCellByData:(id<MessageModalProtocal>)data;

/**
 获取cell高度，可能从modal中的缓存中拿，否则cell计算，并缓存在modal中
 
 @return cell高度
 */
-(CGFloat)fetchCellHeight;

/**
 针对不同的cell，计算cell高度

 @param data 消息模型
 @return cell高度
 */
-(CGFloat)caculateCellHeight:(id<MessageModalProtocal>)data;

@end


#endif /* CDChatListProtocols_h */
