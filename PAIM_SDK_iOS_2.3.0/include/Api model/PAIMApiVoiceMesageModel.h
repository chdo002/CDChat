//
//  PAIMApiVoiceMesageModel.h
//  PAIM_Demo
//
//  Created by linshengqin on 15/5/15.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import "PAIMApiMessageModel.h"

@interface PAIMApiVoiceMesageModel : PAIMApiMessageModel

@property (nonatomic,retain) NSString *totalTime;       //消息内容时长
@property (nonatomic,assign) NSInteger retransmit;        //是否为转发
@property (nonatomic,retain) NSString *orignAuthorName;   //原创者
@property (nonatomic,retain) NSString *orignAuthorID;    //原创者ID
@property (nonatomic) BOOL voiceIsPlay;                 //语音是否正在播放

-(id)initApiVoiceMessageModelWithMsgTo:(NSString *)msgTo
                           contentType:(MESSAGE_TYPE)contentType
                               content:(NSString *)content
                              chatType:(CHAT_TYPE)chatType
                        conversationID:(NSString *)conversationID
                             totalTime:(NSString*)totalTime
                           restransmit:(NSInteger)restransmit;
@end
