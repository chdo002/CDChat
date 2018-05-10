//
//  CDChatMacro.h
//  Pods
//
//  Created by chdo on 2017/10/26.
//


#import "CDChatListProtocols.h"
#import "ChatConfiguration.h"

#ifndef CDChatMacro_h
#define CDChatMacro_h

// 0 调试 1 生产
#define Environment ChatHelpr.share.config.environment
#define isChatListDebug [ChatHelpr.share.config isDebug]

// 消息中图片下载完成的通知
#define CHATLISTDOWNLOADLISTFINISH @"CDCHATLISTDOWNLOADLISTFINISH"

// 点击消息中可点击区域的通知
#define CHATLISTCLICKMSGEVENTNOTIFICATION @"CHATLISTCLICKMSGEVENTNOTIFICATION"


/*
 ========================================================================================================================
 =======================================================  cell中的宏  ====================================================
 ========================================================================================================================
 */


// cell中消息中时间视图的高度（如果显示）
#define MsgTimeH  ChatHelpr.share.config.msgTimeH


// 颜色
#define MsgBackGroundColor ChatHelpr.share.config.msgBackGroundColor           // cell背景色

#define MsgContentBackGroundColor ChatHelpr.share.config.msgContentBackGroundColor       // 消息容器背景色

#define HeadBackGroundColor ChatHelpr.share.config.headBackGroundColor             // 头像背景色

#define MsgTextContentBackGroundColor_left ChatHelpr.share.config.msgTextContentBackGroundColor_left       // 文字背景色
#define MsgTextContentBackGroundColor_right ChatHelpr.share.config.msgTextContentBackGroundColor_right       // 文字背景色
// 长度
#define SysInfoMessageMaxWidth ChatHelpr.share.config.sysInfoMessageMaxWidth    // 系统消息最大边长

#define HeadSideLength  ChatHelpr.share.config.headSideLength // 头像边长
#define MessageContentH ChatHelpr.share.config.messageContentH // 文字消息内容在只有一行时的高度 不包括时间label

#define SysInfoPadding  ChatHelpr.share.config.sysInfoPadding                      // 系统消息内边距

// 气泡尺寸
#define BubbleRoundAnglehorizInset ChatHelpr.share.config.bubbleRoundAnglehorizInset  // 气泡圆角半径
#define BubbleShareAngleWidth  ChatHelpr.share.config.bubbleShareAngleWidth      // 气泡尖角宽度
#define MessageMargin  ChatHelpr.share.config.messageMargin  // 头像外边距
#define BubbleMaxWidth ChatHelpr.share.config.bubbleMaxWidth // 气泡最大边长   从尖角到另一边
#define BubbleSharpAnglehorizInset ChatHelpr.share.config.bubbleSharpAnglehorizInset //尖角外部到文字边缘的水平距离
#define BubbleSharpAngleHeighInset ChatHelpr.share.config.bubbleSharpAngleHeighInset  // 气泡顶部到尖角底部的距离

// 字体
#define MessageTextDefaultFontSize ChatHelpr.share.config.messageTextDefaultFontSize
#define MessageTextDefaultFont ChatHelpr.share.config.messageTextDefaultFont  //默认文字消息字体

#define SysInfoMessageFont  ChatHelpr.share.config.sysInfoMessageFont  // 系统消息字体


#endif /* CDChatMacro_h */

