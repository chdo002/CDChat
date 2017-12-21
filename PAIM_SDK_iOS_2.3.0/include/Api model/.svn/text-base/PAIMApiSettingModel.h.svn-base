//
//  PAIMApiSettingModel.h
//  PAIM_Demo
//
//  Created by Dmq on 15/5/25.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PAIMApiSettingModel : NSObject
@property (nonatomic,retain) NSString *conversationID;      //会话ID
@property (nonatomic,assign) BOOL stickie;                  //会话置顶
@property (nonatomic,retain) NSString *backGroundImg;       //会话聊天背景
@property (nonatomic,assign) BOOL showBadge;                //会话显示新消息badge
@property (nonatomic,assign) BOOL showNickName;             //显示昵称（群聊）
@property (nonatomic,assign) NSInteger  defaultBackdImg;    //会话聊天背景index
@property (nonatomic,assign) BOOL  notifyNewMessage;        //新消息通知
@property (nonatomic,retain) NSDate *stickieTime;
@property (nonatomic,assign) CHAT_TYPE chatType;            //会话类型
@property (nonatomic,assign) PreKeyboardType keyBoardType;  //键盘类型
/**
 *  初始化会话设置model
 *
 *  @param conversationID_   会话ID
 *  @param stickie_          会话置顶
 *  @param backGroundImg_    会话聊天背景
 *  @param showBadge_        会话显示新消息badge
 *  @param chatType_         会话类型
 *  @param showNickName_     显示昵称（群聊）
 *  @param defaultBackImg_   会话聊天背景index
 *  @param notifyNewMessage_ 新消息通知
 *  @param stickieTime_
 *
 *  @return 返回会话model实例
 */
-(id)initWithConversationID:(NSString *)conversationID
                    stickie:(BOOL)stickie
              backGroundImg:(NSString *)backGroundImg
                  showBadge:(BOOL)showBadge
                   chatType:(CHAT_TYPE)chatType
               showNickName:(BOOL)showNickName
            defaultBackdImg:(NSInteger)defaultBackImg
           notifyNewMessage:(BOOL)notifyNewMessage
                stickieTime:(NSDate *)stickieTime;
@end
