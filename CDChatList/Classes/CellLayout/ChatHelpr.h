//
//  ChatHelpr.h
//  CDChatList
//
//  Created by chdo on 2017/11/17.
//

#import <Foundation/Foundation.h>
#import <YYText/YYText.h>

@interface ChatListInfo: NSObject
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, copy) NSAttributedString *msgText;
@property (nonatomic, copy) NSString *link;
@property (nonatomic, assign) NSRange range;
@property (nonatomic, assign) CGRect rect;
@end



@interface ChatHelpr : NSObject

+(NSDictionary *)emoticonDic;
+(void)matchEmoji:(NSMutableAttributedString *)msgStr;


+(void)matchUrl: (NSMutableAttributedString *) msgStr
   fetchActions: (YYTextAction (^)(void))getAction;
@end
