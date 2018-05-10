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

@end
