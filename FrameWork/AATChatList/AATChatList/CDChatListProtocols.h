//
//  CDChatListProtocols.h
//  Pods
//
//  Created by chdo on 2017/10/26.
//

#ifndef CDChatListProtocols_h
#define CDChatListProtocols_h


#import "CDChatMacro.h"
#import "CTData.h"
#import "ChatListInfo.h"

static NSString * CDChatListDidScroll = @"CDChatListDidScroll";

typedef enum : NSUInteger {
    CDMessageTypeText,      // 文字类型
    CDMessageTypeImage,     // 图片类型
    CDMessageTypeAudio,     // 音频类型
    CDMessageTypeSystemInfo // 系统信息类型
} CDMessageType; // 消息类型

typedef enum : NSUInteger {
    
    CDMessageStateNormal,
    
    CDMessageStateSending,          // 图片消息上传中/文字消息发送中
    CDMessageStateSendFaild,        // 消息发送失败
    
    CDMessageStateDownloading,      // 图片消息下载中
    CDMessageStateDownloadFaild     // 图片消息下载失败
    
} CDMessageState;

/**
 消息模型
 */
@protocol MessageModalProtocal

@required
/*
 注意：
    1、发送图片消息 需用 SDImageCache预先缓存，key为messageid
 */

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

typedef id<MessageModalProtocal> CDChatMessage;
typedef NSArray<CDChatMessage>* CDChatMessageArray;

/**
 消息cell
 */
@protocol MessageCellProtocal

/**
 设置cell中的Data
 
 @param data 消息模型
 */
-(void)configCellByData:(CDChatMessage)data;

@end

@protocol ChatListProtocol <NSObject>


/**
 消息列表请求加载更多消息

 @param topMessage 目前最早的消息
 @param finnished 加载完成回调
 */
-(void)chatlistLoadMoreMsg: (CDChatMessage)topMessage
                  callback: (void(^)(CDChatMessageArray))finnished;

/**
 消息中的点击事件

 @param listInfo 点击事件体
 */
-(void)chatlistClickMsgEvent: (ChatListInfo *)listInfo;
@end

#endif /* CDChatListProtocols_h */
