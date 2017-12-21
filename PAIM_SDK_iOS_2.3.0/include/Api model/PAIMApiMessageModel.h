//
//  PAIMMessageModel.h
//  PAIM_Demo
//
//  Created by linshengqin on 15/5/15.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PAIMApiMessageModel : NSObject

/*!
 @property
 @abstract 消息ID
 */
@property (nonatomic,strong) NSString *msgId;
/*!
 @property
 @abstract 消息发送者
 */
@property (nonatomic,strong) NSString *msgFrom;
/*!
 @property
 @abstract 消息接收者
 */
@property (nonatomic,strong) NSString *msgTo;
/*!
 @property
 @abstract 消息收发
 */
@property (nonatomic,assign) MSG_PROTO msgProto;
/*!
 @property
 @abstract 消息内容类型
 */
@property (nonatomic,assign) MESSAGE_TYPE contentType;
/*!
 @property
 @abstract 消息内容
 */
@property (nonatomic,strong) NSString *content;
/*!
 @property
 @abstract 会话类型
 */
@property (nonatomic,assign) CHAT_TYPE msgType;
/*!
 @property
 @abstract 消息所属会话ID
 */
@property (nonatomic,strong) NSString *conversationID;
/*!
 @property
 @abstract 消息创建时间
 */
@property (nonatomic,strong) NSDate *createCST;
/*!
 @property
 @abstract 消息发送状态
 */
@property (nonatomic,assign) MESSAGE_STATE state;
/*!
 @property
 @abstract 被@好友的jid
 */
@property (nonatomic,strong) NSString *remindFriendJid;
/*!
 @property
 @abstract 是否被其他人@
 */
@property (nonatomic,assign) BOOL   isFocusByOtherPeople;
/*!
 @property
 @abstract 消息已读标示
 */
@property (nonatomic,assign) READ_STATE read;
/*!
 @property
 @abstract 消息的cell高度
 */
@property (nonatomic,assign) float height;
/*!
 @property
 @abstract 是否要显示时间
 */
@property (nonatomic,retain) NSString *displayTime;
/*!
 @property
 @abstract 是否为转发
 */
@property (nonatomic,assign) NSInteger retransmit;
/*!
 @property
 @abstract 原创者
 */
@property (nonatomic,strong) NSString *orignAuthorName;
/*!
 @property
 @abstract 原创者ID
 */
@property (nonatomic,strong) NSString *orignAuthorID;
/*!
 @property
 @abstract 语音是否正在播放
 */
@property (nonatomic) BOOL voiceIsPlay;
/*!
 @property
 @abstract 缩略图
 */
@property (nonatomic,retain) NSString *thumbnailPic;
/*!
 @property
 @abstract 下载key
 */
@property (nonatomic,retain) NSString *downloadKey;
/*!
 @property
 @abstract 消息内容时长
 */
@property (nonatomic,retain) NSString *totalTime;
/*!
 @property
 @abstract 视频消息内容大小,以k为单位
 */
@property (nonatomic,retain) NSString *totalSize;
/*!
 @property
 @abstract 已经播放的时间
 */
@property (nonatomic) float playedTime;
/*!
 @property
 @abstract 消息所属群ID
 */
@property (nonatomic,retain) NSString *groupID;
/*!
 @property
 @abstract 消息是否是服务端拉取来的（用于直播间）
 */
@property (nonatomic,assign) BOOL isMsgFromService;


/*!
 *  初始化
 *
 *  @return PAIMApiMessageModel
 */
- (id)init;

/*!
 *  初始化
 *
 *  @param msgTo          消息接收者
 *  @param contentType    消息内容类型
 *  @param content        消息内容
 *  @param chatType       会话类型
 *  @param conversationID 消息所属会话ID
 *
 *  @return PAIMApiMessageModel
 */
- (id)initApiMessageModelWithMsgTo:(NSString*)msgTo
                      contentType:(MESSAGE_TYPE)contentType
                          content:(NSString*)content
                         chatType:(CHAT_TYPE)chatType
                   conversationID:(NSString*)conversationID;

/*!
 *  初始化图片消息
 *
 *  @param msgTo          消息接收者
 *  @param contentType    消息内容类型
 *  @param content        消息内容
 *  @param chatType       会话类型
 *  @param conversationID 消息所属会话ID
 *
 *  @return 图片消息Model
 */
- (id)initApiImageMessageModelWithMsgTo:(NSString*)msgTo
                           contentType:(MESSAGE_TYPE)contentType
                               content:(NSString*)content
                              chatType:(CHAT_TYPE)chatType
                        conversationID:(NSString*)conversationID;

/*!
 *  初始化语音消息
 *
 *  @param msgTo           消息接收者
 *  @param contentType     消息内容类型
 *  @param content         消息内容
 *  @param chatType        会话类型
 *  @param conversationID  消息所属会话ID
 *  @param totalTime       消息内容时长
 *  @param restransmit     是否为转发
 *  @param orignAuthorName 原创者
 *  @param orignAuthorID   原创者ID
 *  @param voiceIsPlay     语音是否正在播放
 *
 *  @return 语音消息Model
 */
- (id)initApiVoiceMessageModelWithMsgTo:(NSString *)msgTo
                           contentType:(MESSAGE_TYPE)contentType
                               content:(NSString *)content
                              chatType:(CHAT_TYPE)chatType
                        conversationID:(NSString *)conversationID
                             totalTime:(NSString*)totalTime
                           restransmit:(NSInteger)restransmit
                       orignAuthorName:(NSString *)orignAuthorName
                         orignAuthorID:(NSString *)orignAuthorID
                           voiceIsPlay:(BOOL)voiceIsPlay;

/*!
 *  初始化视频消息
 *
 *  @param msgTo          消息接收者
 *  @param contentType    消息内容类型
 *  @param content        消息内容
 *  @param chatType       会话类型
 *  @param conversationID 消息所属会话ID
 *  @param totalTime      消息内容时长
 *  @param thumbnailPic   缩略图
 *  @param totalSize      视频消息内容大小,以k为单位
 *
 *  @return 视频消息Model
 */
- (id)initApiVideoMessageModelWithMsgTo:(NSString *)msgTo
                           contentType:(MESSAGE_TYPE)contentType
                               content:(NSString *)content
                              chatType:(CHAT_TYPE)chatType
                        conversationID:(NSString *)conversationID
                             totalTime:(NSString*)totalTime
                          thumbnailPic:(NSString*)thumbnailPic
                             totalSize:(NSString*)totalSize;


/*!
 *  初始化直播间消息
 *
 *  @param contentType    消息内容类型
 *  @param content        消息内容
 *  @param chatType       会话类型
 *  @param conversationID 消息所属会话ID
 *
 *  @return 直播间文本Model
 */
-(id)initApiMessageModelWithContentType:(MESSAGE_TYPE)contentType
                                content:(NSString*)content
                               chatType:(CHAT_TYPE)chatType
                         conversationID:(NSString*)conversationID;
/**
 * @return 是否直播消息状态
 */
-(BOOL)isLiveRoomMessage;


@end
