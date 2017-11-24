//
//  ChatHelpr.h
//  CDChatList
//
//  Created by chdo on 2017/11/17.
//

#import <Foundation/Foundation.h>
#import <YYText/YYText.h>

@interface ChatHelpr : NSObject

/**
 匹配HTML标签

 @param msgStr 消息富文本
 */
+(NSMutableAttributedString *)matchHTML:(NSMutableAttributedString *)msgStr;

/**
 匹配表情文本

 @param msgStr 消息富文本
 */
+(void)matchEmoji:(NSMutableAttributedString *)msgStr;

/**
 匹配链接文本

 @param msgStr 消息富文本
 @param getAction 获取点击处理动作
 */
+(void)matchUrl: (NSMutableAttributedString *) msgStr
   fetchActions: (YYTextAction (^)(void))getAction;

@end
