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

@interface Test:NSObject

@end

@implementation Test


@end

@implementation ChatHelpr

+(void)load
{
    dispatch_async(dispatch_get_main_queue(), ^{
        ChatHelpr.share.imageDic = [ChatImageDrawer defaultImageDic];
        ChatHelpr.share.config = [[ChatConfiguration alloc] init];
    });
}

+(instancetype)share{
    
    static dispatch_once_t onceToken;
    static ChatHelpr *helper;
    
    dispatch_once(&onceToken, ^{
        helper = [[ChatHelpr alloc] init];
    });
    return helper;
}

@end
