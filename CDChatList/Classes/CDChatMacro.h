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
#define Environment [ChatHelpr defaultConfiguration].environment
#define isChatListDebug [[ChatHelpr defaultConfiguration] isDebug]

// 16位颜色
#define CRMHexColor(hexColor)  [UIColor colorWithRed:((float)((hexColor & 0xFF0000) >> 16))/255.0 green:((float)((hexColor & 0xFF00) >> 8))/255.0 blue:((float)(hexColor & 0xFF))/255.0 alpha:1]

// 随机色
#define CRMRadomColor  [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

// 屏幕尺寸
#define scrnW [UIScreen mainScreen].bounds.size.width
#define scrnH [UIScreen mainScreen].bounds.size.height

// 导航栏高度
#define NaviH (44 + [[UIApplication sharedApplication] statusBarFrame].size.height)

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
#define MsgTimeH  [ChatHelpr defaultConfiguration].msgTimeH


// 颜色
#define MsgBackGroundColor [ChatHelpr defaultConfiguration].msgBackGroundColor           // cell背景色

#define MsgContentBackGroundColor [ChatHelpr defaultConfiguration].msgContentBackGroundColor       // 消息容器背景色

#define HeadBackGroundColor [ChatHelpr defaultConfiguration].headBackGroundColor             // 头像背景色

#define MsgTextContentBackGroundColor [ChatHelpr defaultConfiguration].msgTextContentBackGroundColor       // 文字背景色

// 长度
#define SysInfoMessageMaxWidth [ChatHelpr defaultConfiguration].sysInfoMessageMaxWidth    // 系统消息最大边长

#define HeadSideLength  [ChatHelpr defaultConfiguration].headSideLength // 头像边长
#define MessageContentH [ChatHelpr defaultConfiguration].messageContentH // 文字消息内容在只有一行时的高度 不包括时间label

#define SysInfoPadding  [ChatHelpr defaultConfiguration].sysInfoPadding                      // 系统消息内边距

// 气泡尺寸
#define BubbleRoundAnglehorizInset [ChatHelpr defaultConfiguration].bubbleRoundAnglehorizInset  // 气泡圆角半径
#define BubbleShareAngleWidth  [ChatHelpr defaultConfiguration].bubbleShareAngleWidth      // 气泡尖角宽度
#define MessageMargin  [ChatHelpr defaultConfiguration].messageMargin  // 头像外边距
#define BubbleMaxWidth [ChatHelpr defaultConfiguration].bubbleMaxWidth // 气泡最大边长   从尖角到另一边
#define BubbleSharpAnglehorizInset [ChatHelpr defaultConfiguration].bubbleSharpAnglehorizInset //尖角外部到文字边缘的水平距离
#define BubbleSharpAngleHeighInset [ChatHelpr defaultConfiguration].bubbleSharpAngleHeighInset  // 气泡顶部到尖角底部的距离

// 字体
#define MessageTextDefaultFontSize [ChatHelpr defaultConfiguration].messageTextDefaultFontSize
#define MessageTextDefaultFont [ChatHelpr defaultConfiguration].messageTextDefaultFont  //默认文字消息字体

#define SysInfoMessageFont  [ChatHelpr defaultConfiguration].sysInfoMessageFont  // 系统消息字体


#endif /* CDChatMacro_h */

