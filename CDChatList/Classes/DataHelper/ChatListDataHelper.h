//
//  ChatListDataHelper.h
//  CDChatList
//
//  Created by chdo on 2017/11/16.
//

#import <Foundation/Foundation.h>

@interface ChatListDataHelper : NSObject

/**
 将消息字符串 转为 富文本

 @param msg 消息字符串
 @param attributes 富文本参数   字体 字号..
 @return 结果
 */
+(NSMutableAttributedString *)decorateMessageStr:(NSString * )msg attribute:(NSDictionary<NSAttributedStringKey, id> *)attributes;

@end
