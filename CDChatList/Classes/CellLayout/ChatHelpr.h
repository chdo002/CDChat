//
//  ChatHelpr.h
//  CDChatList
//
//  Created by chdo on 2017/11/17.
//

#import <Foundation/Foundation.h>

@interface ChatHelpr : NSObject

+(NSDictionary *)emoticonDic;

+(void)matchEmoji:(NSMutableAttributedString *)msgStr;

+(void)matchUrl:(NSMutableAttributedString *)msgStr;
@end
