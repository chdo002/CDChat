//
//  AppDelegate.m
//  ChatDemo
//
//  Created by chdo on 2017/12/21.
//  Copyright © 2017年 aat. All rights reserved.
//

#import "AppDelegate.h"
#import "AATChatList.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSMutableDictionary *dic;
        // 表情bundle地址
        NSString *emojiBundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Expression.bundle"];
        // 表情键值对
        NSDictionary<NSString *, id> *temp = [[NSDictionary alloc] initWithContentsOfFile:[emojiBundlePath stringByAppendingPathComponent:@"files/expressionImage_custom.plist"]];
        // 表情图片bundle
        NSBundle *bundle = [NSBundle bundleWithPath:emojiBundlePath];
        dic = [NSMutableDictionary dictionary];
        for (NSString *imagName in temp.allKeys) {
            UIImage *img = [UIImage imageNamed:temp[imagName] inBundle:bundle compatibleWithTraitCollection:nil];
            [dic setValue:img forKey:imagName];//
        }
        
        // 设置聊天界面的表情资源
        [ChatHelpr setDefaultEmoticonDic:dic];
        
        // 设置输入框的表情资源
        [CTinputHelper setDefaultEmoticonDic:dic emojiNameArrs:@[temp.allKeys,temp.allKeys] emojiNameArrTitles:@[@"hhe",@"haha"]];
        
        [[CTinputHelper defaultConfiguration] addExtra:@{
                                                         @"相册1": [UIImage imageNamed:@"keyboard_photo"],
                                                         @"拍照2": [UIImage imageNamed:@"icon_photo"],
                                                         @"拍照3": [UIImage imageNamed:@"icon_news"],
                                                         @"拍照4": [UIImage imageNamed:@"icon_photo"],
                                                         @"拍照5": [UIImage imageNamed:@"icon_photo"],
                                                         @"拍照6": [UIImage imageNamed:@"icon_news"],
                                                         @"拍照7": [UIImage imageNamed:@"icon_photo"],
                                                         @"拍照8": [UIImage imageNamed:@"icon_photo"],
                                                         @"拍照9": [UIImage imageNamed:@"icon_photo"],
                                                         @"新闻0": [UIImage imageNamed:@"icon_news"]
                                                         }];
        
        [[CTinputHelper defaultConfiguration] addEmoji];
        [[CTinputHelper defaultConfiguration] addVoice];
    });
    
    
    [ChatHelpr defaultConfiguration].environment = 1;
    
    return YES;
}

@end
