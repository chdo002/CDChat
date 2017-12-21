//
//  AppDelegate.m
//  ChatDemo
//
//  Created by chdo on 2017/12/20.
//  Copyright © 2017年 aat. All rights reserved.
//

#import "AppDelegate.h"
#import <AATChatList/AATChatList.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    

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
        [ChatHelpr setDefaultEmoticonDic:dic]; // 设置聊天界面的表情资源
        [CTinputHelper setDefaultEmoticonDic:dic emojiNameArrs:@[temp.allKeys]];// 设置输入框的表情资源
    });
    
    [ChatHelpr defaultConfiguration].environment = 1;
    return YES;
}
@end
