//
//  ChatListDataHelper.m
//  CDChatList
//
//  Created by chdo on 2017/11/16.
//

#import "ChatListDataHelper.h"
#import "CDBaseMsgCell.h"

@implementation ChatListDataHelper

+(NSMutableAttributedString *)decorateMessageStr:(NSString *)msg attribute:(NSDictionary<NSAttributedStringKey, id> *)attributes{
    if (!msg) return nil;
    
    NSMutableDictionary *attributsDic = [attributes mutableCopy];
    if (!attributsDic) {
        attributsDic = [[NSMutableDictionary alloc] init];
    }
    //无字体 则设置默认字体
    UIFont *font = attributsDic[NSFontAttributeName];
    if (!font) [attributsDic setObject:MessageTextDefaultFont forKey:NSFontAttributeName];
    
    NSMutableAttributedString *msg_attri = [[NSMutableAttributedString alloc] initWithString:msg attributes:attributsDic];
    
    //...
    return msg_attri;
}


@end
