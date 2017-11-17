//
//  ChatListDataHelper.m
//  CDChatList
//
//  Created by chdo on 2017/11/16.
//

#import "ChatListDataHelper.h"
#import "CDBaseMsgCell.h"

@implementation ChatListDataHelper

/**
 转为富文本
 匹配  链接 表情 ......
 */
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
    
    msg_attri.yy_font = [UIFont systemFontOfSize:16];
    msg_attri.yy_lineSpacing = 0;
    msg_attri.yy_strokeWidth = @(-3);
    msg_attri.yy_strokeColor = [UIColor redColor];
    msg_attri.yy_lineHeightMultiple = 1;
    msg_attri.yy_maximumLineHeight = 16;
    msg_attri.yy_minimumLineHeight = 16;
    //...
    
    return msg_attri;
}


@end
