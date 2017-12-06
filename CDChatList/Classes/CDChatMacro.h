//
//  CDChatMacro.h
//  Pods
//
//  Created by chdo on 2017/10/26.
//


#import "CDChatListProtocols.h"

#ifndef CDChatMacro_h
#define CDChatMacro_h

// 0 调试 1 生产
#define Environment 1
#define isChatListDebug (Environment == 0)

// 16位颜色
#define CRMHexColor(hexColor)  [UIColor colorWithRed:((float)((hexColor & 0xFF0000) >> 16))/255.0 green:((float)((hexColor & 0xFF00) >> 8))/255.0 blue:((float)(hexColor & 0xFF))/255.0 alpha:1]

// 随机色
#define CRMRadomColor  [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

// 资源图片  pod的资源会被打包成相应的bundle
#define BundleImage(name) [UIImage imageNamed:name inBundle:[NSBundle bundleWithPath:[[NSBundle bundleForClass:[CDChatList class]] pathForResource:@"CDChatList" ofType:@"bundle"]] compatibleWithTraitCollection:nil]

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
#define MsgTimeH  30


// 颜色
#define MsgBackGroundColor (isChatListDebug ? CRMHexColor(0xB5E7E1) : CRMHexColor(0xEBEBEB))           // cell背景色
#define MsgContentBackGroundColor (isChatListDebug ? CRMHexColor(0x9E7777) : CRMHexColor(0xEBEBEB))       // 消息容器背景色
#define HeadBackGroundColor (isChatListDebug ? [UIColor redColor] : CRMHexColor(0xEBEBEB))             // 头像背景色
#define MsgTextContentBackGroundColor (isChatListDebug ? [UIColor redColor] : CRMHexColor(0xF5F5F5))       // 文字背景色

// 长度
#define SysInfoMessageMaxWidth scrnW * 0.64    // 系统消息最大边长
#define HeadSideLength  40 // 头像边长
#define MessageContentH (MessageMargin * 2 +  HeadSideLength) // 文字消息内容在只有一行时的高度 不包括时间label
#define SysInfoPadding  8                      // 系统消息内边距

// 气泡尺寸
#define BubbleRoundAnglehorizInset 10  // 气泡圆角半径
#define BubbleShareAngleWidth  6      // 气泡尖角宽度
#define MessageMargin  10  // 头像外边距
#define BubbleMaxWidth scrnW * 0.64 // 气泡最大边长   从尖角到另一边
#define BubbleSharpAnglehorizInset (BubbleRoundAnglehorizInset + BubbleShareAngleWidth) //尖角外部到文字边缘的水平距离
#define BubbleSharpAngleHeighInset 25  // 气泡顶部到尖角底部的距离

// 字体
#define MessageTextDefaultFontSize 16
#define MessageTextDefaultFont  [UIFont systemFontOfSize: MessageTextDefaultFontSize] //默认文字消息字体
#define SysInfoMessageFont  [UIFont systemFontOfSize:14] // // 系统消息字体


#endif /* CDChatMacro_h */

