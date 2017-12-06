//
//  ChatHelpr.m
//  CDChatList
//
//  Created by chdo on 2017/11/17.
//

#import "ChatHelpr.h"
#import "CTHelper.h"

@interface ChatHelpr()
@property(nonatomic, strong) NSDictionary<NSString*, UIImage *> *emojDic;
@property(nonatomic, strong) ChatConfiguration *config;
@end

@implementation ChatHelpr

+(instancetype)share{
    
    static dispatch_once_t onceToken;
    static ChatHelpr *helper;
    
    dispatch_once(&onceToken, ^{
        helper = [[ChatHelpr alloc] init];
        helper->_config = [[ChatConfiguration alloc] init];
    });
    return helper;
}

#pragma mark 聊天组件配置相关
+(ChatConfiguration *)defaultConfiguration{
    return [ChatHelpr share].config;
}

+(void)setDefaultConfiguration:(ChatConfiguration *)config{
    [ChatHelpr share].config = config;
}

#pragma mark  表情相关
+(NSDictionary<NSString *,UIImage *> *)defaultEmoticonDic{
    return [ChatHelpr share].emojDic;
}
+(void)setDefaultEmoticonDic:(NSDictionary<NSString *,UIImage *> *)dic{
    [ChatHelpr share].emojDic = dic;
    [CTHelper loadImageDic:dic];
}



@end
