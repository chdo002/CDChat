//
//  ChatHelpr.m
//  CDChatList
//
//  Created by chdo on 2017/11/17.
//

#import "ChatHelpr.h"
#import "CTHelper.h"
#import "ChatImageDrawer.h"
#import "CTinputHelper.h"

@interface ChatHelpr()
@property(nonatomic, strong) NSDictionary<NSString*, UIImage *> *emojDic;
@property(nonatomic, strong) NSDictionary<NSString*, UIImage *> *imageDic;
@property(nonatomic, strong) ChatConfiguration *config;
@end

@implementation ChatHelpr

+(instancetype)share{
    
    static dispatch_once_t onceToken;
    static ChatHelpr *helper;
    
    dispatch_once(&onceToken, ^{
        helper = [[ChatHelpr alloc] init];
        helper->_config = [[ChatConfiguration alloc] init];
        dispatch_async(dispatch_get_main_queue(), ^{
           helper->_imageDic = [ChatImageDrawer defaultImageDic];
        });
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

#pragma mark  表情图片相关
+(NSDictionary<NSString *,UIImage *> *)defaultEmoticonDic{
    return [ChatHelpr share].emojDic;
}
+(void)setDefaultEmoticonDic:(NSDictionary<NSString *,UIImage *> *)dic{
    [ChatHelpr share].emojDic = dic;
    [CTinputHelper setDefaultEmoticonDic:dic];
    [CTHelper loadImageDic:dic];
}

#pragma mark  资源图片
+(NSDictionary<NSString *,UIImage *> *)defaultImageDic{
    return [ChatHelpr share].imageDic;
}
+(void)setDefaultImageDic:(NSDictionary<NSString *,UIImage *> *)dic{
    [ChatHelpr share].imageDic = dic;
}
@end
