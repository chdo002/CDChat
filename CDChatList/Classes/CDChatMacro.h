//
//  CDChatMacro.h
//  Pods
//
//  Created by chdo on 2017/10/26.
//


#import "CDChatListProtocols.h"

#ifndef CDChatMacro_h
#define CDChatMacro_h

#define environment 0 // 0 调试 1 生产
#define isChatListDebug (environment == 0)

// 16位颜色
#define CRMHexColor(hexColor)  [UIColor colorWithRed:((float)((hexColor & 0xFF0000) >> 16))/255.0 green:((float)((hexColor & 0xFF00) >> 8))/255.0 blue:((float)(hexColor & 0xFF))/255.0 alpha:1]

// 随机色
#define CRMRadomColor  [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1]

// Bundle图片
#define BundleImage(name) [UIImage imageNamed:name inBundle:[NSBundle bundleWithPath:[[NSBundle bundleForClass:[CDChatList class]] pathForResource:@"CDChatList" ofType:@"bundle"]] compatibleWithTraitCollection:nil]


// UI
#define scrnW [UIScreen mainScreen].bounds.size.width
#define scrnH [UIScreen mainScreen].bounds.size.height

#define NaviH (44 + [[UIApplication sharedApplication] statusBarFrame].size.height)   // 导航栏高度

// cell

#define MsgTimeH  30 // cell中消息中时间视图的高度（如果显示）

#define DOWNLOADLISTFINISH @"CDCHATLISTDOWNLOADLISTFINISH"


#endif /* CDChatMacro_h */
