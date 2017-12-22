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
        [ChatHelpr setDefaultEmoticonDic:dic]; // 设置聊天界面的表情资源
        // 设置输入框的表情资源
        [CTinputHelper setDefaultEmoticonDic:dic emojiNameArrs:@[temp.allKeys,temp.allKeys] emojiNameArrTitles:@[@"hhe",@"haha"]];
//        [CTinputHelper setDefaultEmoticonDic:dic emojiNameArrs:nil emojiNameArrTitles:nil];
    });
    
    [ChatHelpr defaultConfiguration].environment = 1;
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
