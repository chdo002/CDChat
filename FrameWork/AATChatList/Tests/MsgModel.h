//
//  MsgModel.h
//  Tests
//
//  Created by chdo on 2018/2/5.
//  Copyright © 2018年 aat. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CDChatList.h"
@interface MsgModel : NSObject<MessageModalProtocal>

/**
 消息内容
 */
@property (copy,nonatomic) NSString *msg;

/**
 发送时间 毫秒
 */
@property (copy,nonatomic) NSString *createTime;

/**
 是否显示时间
 */
@property (assign,nonatomic) BOOL willDisplayTime;

/**
 消息类型
 */
@property (assign,nonatomic) CDMessageType msgType;

/**
 消息状态
 */
@property (assign,nonatomic) CDMessageState msgState;

/**
 消息ID
 */
@property (copy,nonatomic) NSString *messageId;

/**
 模型其他信息
 */
@property (copy, nonatomic) NSDictionary *modalInfo;

/**
 cell左右判断
 */
@property (assign, nonatomic) BOOL isLeft;

/**
 消息对应用户的头像图片
 */
@property (strong, nonatomic) UIImage *userThumImage;

/**
 消息对应用户的头像图片地址
 */
@property (strong, nonatomic) NSString *userThumImageURL;

#pragma mark 缓存，这些字段，存在缓存表中

/**
 气泡宽度，缓存用
 */
@property (assign, nonatomic) CGFloat bubbleWidth;

/**
 cell高度，缓存用
 */
@property (assign, nonatomic) CGFloat cellHeight;

/**
 文字布局，缓存用
 */
@property (nonatomic, strong) CTData *textlayout;
@end
