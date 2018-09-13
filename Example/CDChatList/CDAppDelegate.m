//
//  CDAppDelegate.m
//  CDChatList
//
//  Created by chdo002 on 03/20/2018.
//  Copyright (c) 2018 chdo002. All rights reserved.
//

#import "CDAppDelegate.h"
#import <CDChatList/CDChatList.h>
#import <objc/runtime.h>

@implementation CDAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // 配置聊天列表环境
    ChatHelpr.share.config.environment = 1;
    
    [ChatHelpr.share configDefaultResource];
    
//    // 聊天页面图片资源配置
//    NSMutableDictionary *dic;
//
//    /// 表情bundle地址
//    NSString *emojiBundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Expression.bundle"];
//    /// 表情键值对
//    NSDictionary<NSString *, id> *temp = [[NSDictionary alloc] initWithContentsOfFile:[emojiBundlePath stringByAppendingPathComponent:@"files/expressionImage_custom.plist"]];
//    /// 表情图片bundle
//    NSBundle *bundle = [NSBundle bundleWithPath:emojiBundlePath];
//    dic = [NSMutableDictionary dictionary];
//    for (NSString *imagName in temp.allKeys) {
//        UIImage *img = [UIImage imageNamed:temp[imagName] inBundle:bundle compatibleWithTraitCollection:nil];
//        [dic setValue:img forKey:imagName];//
//    }
//    /// 设置聊天界面的表情资源
//    CTHelper.share.emojDic = dic;
//
//
//    /// 设置除表情的图片资源
//    NSString *resouceBundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"InputViewBundle.bundle"];
//    NSBundle *resourceBundle = [NSBundle bundleWithPath:resouceBundlePath];
//
//
//    NSMutableDictionary *resDic = [NSMutableDictionary dictionaryWithDictionary:ChatHelpr.share.imageDic];
//    [resDic setObject:[UIImage imageNamed:@"voice_left_1" inBundle:resourceBundle compatibleWithTraitCollection:nil] forKey:@"voice_left_1"];
//    [resDic setObject:[UIImage imageNamed:@"voice_left_2" inBundle:resourceBundle compatibleWithTraitCollection:nil] forKey:@"voice_left_2"];
//    [resDic setObject:[UIImage imageNamed:@"voice_left_3" inBundle:resourceBundle compatibleWithTraitCollection:nil] forKey:@"voice_left_3"];
//    [resDic setObject:[UIImage imageNamed:@"voice_right_1" inBundle:resourceBundle compatibleWithTraitCollection:nil] forKey:@"voice_right_1"];
//    [resDic setObject:[UIImage imageNamed:@"voice_right_2" inBundle:resourceBundle compatibleWithTraitCollection:nil] forKey:@"voice_right_2"];
//    [resDic setObject:[UIImage imageNamed:@"voice_right_3" inBundle:resourceBundle compatibleWithTraitCollection:nil] forKey:@"voice_right_3"];
//
//
//    NSDictionary *drawImages = [ChatImageDrawer defaultImageDic];
//    for (NSString *imageName in drawImages) {
//        resDic[imageName] = drawImages[imageName];
//    }
//
//
//    ChatHelpr.share.imageDic = resDic;
//
//
//    // 设置输入框的表情资源
//    CTinputHelper.share.emojDic = dic;
//    CTinputHelper.share.emojiNameArr = @[temp.allKeys,temp.allKeys];
//    CTinputHelper.share.emojiNameArrTitles = @[@"hhe",@"haha"];
//    UIImage *photo = [UIImage imageNamed:@"keyboard_photo" inBundle:resourceBundle compatibleWithTraitCollection:nil];
//
////    //        UIImage *news = [UIImage imageNamed:@"icon_news" inBundle:resourceBundle compatibleWithTraitCollection:nil];
//    // 配置 ‘’更多‘’  功能;
//    [CTinputHelper.share.config addExtra:@{@"图片": photo}];
//    [CTinputHelper.share.config addEmoji];
//    [CTinputHelper.share.config addVoice];
//
//    NSDictionary *origin = CTinputHelper.share.imageDic;
//
//    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:origin];
//    [newDic setObject:[UIImage imageNamed:@"keyboard" inBundle:resourceBundle compatibleWithTraitCollection:nil]
//               forKey:@"keyboard"];
//    [newDic setObject:[UIImage imageNamed:@"voice" inBundle:resourceBundle compatibleWithTraitCollection:nil]
//               forKey:@"voice"];
//    [newDic setObject:[UIImage imageNamed:@"micro" inBundle:resourceBundle compatibleWithTraitCollection:nil]
//               forKey:@"voice_microphone_alert"];
//    [newDic setObject:[UIImage imageNamed:@"redo" inBundle:resourceBundle compatibleWithTraitCollection:nil]
//               forKey:@"voice_revocation_alert"];
//    [newDic setObject:[UIImage imageNamed:@"emojiDelete" inBundle:resourceBundle compatibleWithTraitCollection:nil]
//               forKey:@"emojiDelete"];
//    [newDic setObject:[UIImage imageNamed:@"voice" inBundle:resourceBundle compatibleWithTraitCollection:nil]
//               forKey:@"voice"];
//
//    /// 设置除表情的图片资源
//    CTinputHelper.share.imageDic = newDic;
    
    return YES;
}

@end
