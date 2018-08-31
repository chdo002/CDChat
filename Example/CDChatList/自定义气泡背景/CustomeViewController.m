//
//  CustomeViewController.m
//  CDChatList_Example
//
//  Created by chdo on 2018/8/29.
//  Copyright © 2018年 chdo002. All rights reserved.
//

#import "CustomeViewController.h"
#import "CDChatList.h"
#define StatusH [[UIApplication sharedApplication] statusBarFrame].size.height
#define NaviH (44 + StatusH)
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

/*
 在文字、图片或音频类型外的扩展类型，可继承CDBaseMsgCell基础消息类型，也可完全使用自定义类型
 */
@interface CustomeViewController ()<ChatListProtocol>

@end

@implementation CustomeViewController

- (void)setUpCustomBubble {
    UIImage *leftBubble = [UIImage imageNamed:@"buble_left" inBundle:nil compatibleWithTraitCollection:nil];
    UIImage *rigthBubble = [UIImage imageNamed:@"bubble_right" inBundle:nil compatibleWithTraitCollection:nil];
    UIImage *leftBubble_mask = [UIImage imageNamed:@"bubble_left_mask" inBundle:nil compatibleWithTraitCollection:nil];
    UIImage *rigthBubble_mask = [UIImage imageNamed:@"bubble_right_mask" inBundle:nil compatibleWithTraitCollection:nil];
    
    NSMutableDictionary *resDic = [NSMutableDictionary dictionaryWithDictionary:ChatHelpr.share.imageDic];
    resDic[ChatHelpr.share.config.left_box] = [leftBubble resizableImageWithCapInsets:UIEdgeInsetsMake(16, 16, 16, 16) resizingMode:UIImageResizingModeStretch];
    resDic[ChatHelpr.share.config.right_box] = [rigthBubble resizableImageWithCapInsets:UIEdgeInsetsMake(16, 16, 16, 16) resizingMode:UIImageResizingModeStretch];
    resDic[ChatHelpr.share.config.bg_mask_left] = [leftBubble_mask resizableImageWithCapInsets:UIEdgeInsetsMake(16, 16, 16, 16) resizingMode:UIImageResizingModeStretch];
    resDic[ChatHelpr.share.config.bg_mask_right] = [rigthBubble_mask resizableImageWithCapInsets:UIEdgeInsetsMake(16, 16, 16, 16) resizingMode:UIImageResizingModeStretch];
    ChatHelpr.share.imageDic = resDic;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 设置自定义气泡背景
    [self setUpCustomBubble];
    
    BOOL isIphoneX = ScreenH >= 812;
    CDChatListView *list = [[CDChatListView alloc] initWithFrame:CGRectMake(0,
                                                                            NaviH,
                                                                            ScreenW,
                                                                            ScreenH - NaviH - (isIphoneX ? StatusH : 0))];
    [self.view addSubview:list];
    list.msgDelegate = self;
    
    
    NSString *jsonPath = [NSBundle.mainBundle pathForResource:@"messageHistory_custom" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray <CDMessageModel *>*msgs = [NSMutableArray arrayWithCapacity:array.count];
    NSInteger autoInc = 1;
    for (NSDictionary *dic in array) {
        CDMessageModel *model = [[CDMessageModel alloc] init:dic];
        model.messageId = [NSString stringWithFormat:@"%ld",(long)autoInc++];
        if (model.isLeft) {
            CTDataConfig config = [CTData defaultConfig];
            config.textColor = [UIColor blackColor].CGColor;
            model.ctDataconfig = config;
        } else {
            CTDataConfig config = [CTData defaultConfig];
            config.textColor = [UIColor whiteColor].CGColor;
            model.ctDataconfig = config;
        }
        [msgs addObject:model];
    }
    list.msgArr = msgs;
    
}


- (void)chatlistLoadMoreMsg:(CDChatMessage)topMessage callback:(void (^)(CDChatMessageArray, BOOL))finnished {
    
}

- (void)dealloc
{
    
    NSMutableDictionary<NSString *,UIImage *> *originImageDic = [ChatImageDrawer defaultImageDic];
    
    UIImage *leftBubble = originImageDic[@"left_box"];
    UIImage *rigthBubble = originImageDic[@"right_box"];
    UIImage *leftBubble_mask = originImageDic[@"bg_mask_left"];
    UIImage *rigthBubble_mask = originImageDic[@"bg_mask_right"];
    
    NSMutableDictionary *resDic = [NSMutableDictionary dictionaryWithDictionary:ChatHelpr.share.imageDic];
    resDic[ChatHelpr.share.config.left_box] = leftBubble;
    resDic[ChatHelpr.share.config.right_box] = rigthBubble;
    resDic[ChatHelpr.share.config.bg_mask_left] = leftBubble_mask;
    resDic[ChatHelpr.share.config.bg_mask_right] = rigthBubble_mask;
    ChatHelpr.share.imageDic = resDic;
    
}

@end
