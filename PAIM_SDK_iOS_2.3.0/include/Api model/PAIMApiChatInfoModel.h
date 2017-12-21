//
//  PAIMApiChatInfoModel.h
//  PAIM_Demo
//
//  Created by jinglijun on 15/5/20.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PAIMApiChatInfoModel : NSObject

@property (nonatomic, strong) NSString *pHeadImage;     //头像
@property (nonatomic, strong) NSString *pUserName;      //名称
@property (nonatomic, strong) NSString *pSubTitle;      //内容
@property (nonatomic, strong) NSString *pTime;          //显示时间字符
@property (nonatomic, strong) NSDate *createCST;  //原始时间
@property (nonatomic, strong) NSString *conversationID; //会话ID
@property (nonatomic, strong) NSString *msgBackJID;     //回复消息ID
@property (nonatomic, strong) NSString *badgeNumber;    //未读数
@property (nonatomic, strong) NSString *msgTo;          //消息接收者
@property (nonatomic, strong) NSString *msgFrom;        //消息发送者
@property (nonatomic, strong) NSString *msgId;          //消息ID
@property (nonatomic, strong) NSString *draft;          //草稿内容

@property (nonatomic, assign) MESSAGE_STATE state;      //发送状态
@property (nonatomic, assign) BOOL stickie;             //会话置顶
@property (nonatomic, assign) CHAT_TYPE msgType;        //消息类型
@property (nonatomic, assign) MESSAGE_TYPE contentType; //消息类型
@property (nonatomic, assign) ChatCellType cellType;    //cell类型
@property (nonatomic, assign) MSG_PROTO msgProto;       //发送、接收标志
@property (nonatomic, assign) BOOL isFocusByOtherPeople;//是否有人@我
@property (nonatomic, assign) BOOL msgSwitchOn;         //群聊新消息通知
@property (nonatomic,assign) NSUInteger groupType;      //群类型;    默认为:0

-(id)initWithConversationID:(NSString *)conversationID
                      msgTo:(NSString *)msgTo
                    msgType:(CHAT_TYPE)msgType
                contentType:(MESSAGE_TYPE)contentType
                badgeNumber:(NSString *)badgeNumber
                 msgBackJID:(NSString *)msgBackJID
                 pHeadImage:(NSString *)pHeadImage
                  pUserName:(NSString *)pUserName
                  pSubTitle:(NSString *)pSubTitle
                      pTime:(NSDate *)pTime
                    stickie:(BOOL)stickie
                   cellType:(ChatCellType)cellType
                    msgFrom:(NSString *)msgFrom
                      msgId:(NSString *)msgId
                      draft:(NSString *)draft
                      state:(MESSAGE_STATE)state
                   msgProto:(MSG_PROTO)msgProto
       isFocusByOtherPeople:(BOOL)isFocusByOtherPeople
                msgSwitchOn:(BOOL)msgSwitchOn;
@end
