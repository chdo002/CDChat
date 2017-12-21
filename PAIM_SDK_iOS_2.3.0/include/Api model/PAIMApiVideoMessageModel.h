//
//  PAIMApiVideoMessageModel.h
//  PAIM_Demo
//
//  Created by linshengqin on 15/5/15.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import "PAIMApiMessageModel.h"

@interface PAIMApiVideoMessageModel : PAIMApiMessageModel

@property (nonatomic,retain) NSString *thumbnailPic;    //缩略图
@property (nonatomic,retain) NSString *totalTime;       //消息内容时长
@property (nonatomic,retain) NSString *totalSize;       //视频消息内容大小,以k为单位

-(id)initApiVideoMessageModelWithMsgTo:(NSString *)msgTo
                           contentType:(MESSAGE_TYPE)contentType
                               content:(NSString *)content
                              chatType:(CHAT_TYPE)chatType
                        conversationID:(NSString *)conversationID
                             totalTime:(NSString*)totalTime
                          thumbnailPic:(NSString*)thumbnailPic
                             totalSize:(NSString*)totalSize;
@end
