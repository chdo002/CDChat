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
@property BOOL isCancelled;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
//    [self mainTest];

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSMutableDictionary *dic;
        
        /// 表情bundle地址
        NSString *emojiBundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Expression.bundle"];
        /// 表情键值对
        NSDictionary<NSString *, id> *temp = [[NSDictionary alloc] initWithContentsOfFile:[emojiBundlePath stringByAppendingPathComponent:@"files/expressionImage_custom.plist"]];
        /// 表情图片bundle
        NSBundle *bundle = [NSBundle bundleWithPath:emojiBundlePath];
        dic = [NSMutableDictionary dictionary];
        for (NSString *imagName in temp.allKeys) {
            UIImage *img = [UIImage imageNamed:temp[imagName] inBundle:bundle compatibleWithTraitCollection:nil];
            [dic setValue:img forKey:imagName];//
        }
        /// 设置聊天界面的表情资源
        [ChatHelpr setDefaultEmoticonDic:dic];
        /// 设置除表情的图片资源
        NSMutableDictionary *resDic = [NSMutableDictionary dictionaryWithDictionary:[ChatHelpr defaultImageDic]];
        [resDic setObject:[UIImage imageNamed:@"voice_left_1"] forKey:@"voice_left_1"];
        [resDic setObject:[UIImage imageNamed:@"voice_left_2"] forKey:@"voice_left_2"];
        [resDic setObject:[UIImage imageNamed:@"voice_left_3"] forKey:@"voice_left_3"];
        [resDic setObject:[UIImage imageNamed:@"voice_right_1"] forKey:@"voice_right_1"];
        [resDic setObject:[UIImage imageNamed:@"voice_right_2"] forKey:@"voice_right_2"];
        [resDic setObject:[UIImage imageNamed:@"voice_right_3"] forKey:@"voice_right_3"];
        [ChatHelpr setDefaultImageDic:resDic];
        
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
        
        NSDictionary *origin = [CTinputHelper defaultImageDic];
        
        NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:origin];
        [newDic setObject:[UIImage imageNamed:@"keyboard"] forKey:@"keyboard"];
        [newDic setObject:[UIImage imageNamed:@"voice"] forKey:@"voice"];
        [newDic setObject:[UIImage imageNamed:@"micro"] forKey:@"voice_microphone_alert"];
        [newDic setObject:[UIImage imageNamed:@"redo"] forKey:@"voice_revocation_alert"];
        [newDic setObject:[UIImage imageNamed:@"emojiDelete"] forKey:@"emojiDelete"];
        [CTinputHelper setDefaultImageDic:newDic]; /// 设置除表情的图片资源
        
    });
    
    
    [ChatHelpr defaultConfiguration].environment = 1;
    
    return YES;
}

- (void)mainTest
{
    @autoreleasepool {
        NSLog(@"starting thread.......");
        NSTimer *timer = [NSTimer timerWithTimeInterval:0.5 target:self selector:@selector(doTimerTask) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
        
        while (! self.isCancelled) {
            [self doOtherTask];
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate
                                                      dateWithTimeIntervalSinceNow:10]];
            NSLog(@"exiting runloop.........:");
        }
        NSLog(@"finishing thread.........");
    }
}

- (void)doTimerTask
{
    NSLog(@"do timer task");
}
- (void)doOtherTask
{
    NSLog(@"do other task");
}

@end
