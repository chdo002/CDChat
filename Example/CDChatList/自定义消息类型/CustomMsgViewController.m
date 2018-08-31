//
//  CustomMsgViewController.m
//  CDChatList_Example
//
//  Created by chdo on 2018/8/30.
//  Copyright © 2018年 chdo002. All rights reserved.
//

#import "CustomMsgViewController.h"
#import "BaseMsgModel.h"
#import "CDChatList.h"
#import "CustomeGifMsgCell.h"
#import "CustomNewsCell.h"
#import <GDPerformanceView/GDPerformanceMonitor.h>
#define StatusH [[UIApplication sharedApplication] statusBarFrame].size.height
#define NaviH (44 + StatusH)
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface CustomMsgViewController ()<ChatListProtocol>

@end

@implementation CustomMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[GDPerformanceMonitor sharedInstance] startMonitoringWithConfiguration:^(UILabel *textLabel) {
        textLabel.font = [UIFont systemFontOfSize:10];
        textLabel.numberOfLines = 1;
    }];
    
    BOOL isIphoneX = ScreenH >= 812;
    CDChatListView *list = [[CDChatListView alloc] initWithFrame:CGRectMake(0,
                                                                            NaviH,
                                                                            ScreenW,
                                                                            ScreenH - NaviH - (isIphoneX ? StatusH : 0))];
    [self.view addSubview:list];
    list.msgDelegate = self;
    
    NSString *jsonPath = [NSBundle.mainBundle pathForResource:@"messageHistory_custom_msg" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray <BaseMsgModel *>*msgs = [NSMutableArray arrayWithCapacity:array.count];
    NSInteger autoInc = 1;
    for (NSDictionary *dic in array) {
        BaseMsgModel *model = [[BaseMsgModel alloc] init:dic];
        model.messageId = [NSString stringWithFormat:@"%ld",(long)autoInc++];
        [msgs addObject:model];
    }
    
    list.msgArr = msgs;
}

-(NSDictionary<NSString *,Class> *)chatlistCustomeCellsAndClasses{
    return @{CustomeMsgCellReuseId: CustomeGifMsgCell.class, CustomNewsCellReuseId:CustomNewsCell.class};
}

-(CGSize)chatlistSizeForMsg:(CDChatMessage)msg ofList:(CDChatListView *)list{
    
    CGSize cellSize = CGSizeMake(200, 100);
    
    if ([msg.reuseIdentifierForCustomeCell isEqualToString:CustomeMsgCellReuseId]) {
        
        // 获得本地缓存的图片
//        UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey: msg.msg];
//        if (!image) {
//            image = [[SDImageCache sharedImageCache] imageFromCacheForKey: msg.messageId];
//        }
        
        NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:msg.msg ofType:@"gif"];
        YYImage *image = [YYImage imageWithContentsOfFile:filePath];
        
        if (!image) {
            return CGSizeMake(200, 100);
        }
        CGFloat maxLength = 200.0f;
        // 图片将被限制在maxLength*maxLength的区域内，按比例显示
        CGFloat width = image.size.width;
        CGFloat height = image.size.height;
        
        CGFloat maxSide = MAX(width, height);
        CGFloat miniSide = MIN(width, height);
        
        // 按比例缩小后的小边边长
        CGFloat actuallMiniSide = maxLength * miniSide / maxSide;
        
        // 防止长图，宽图，限制最小边 下限
        if (actuallMiniSide < 80) {
            actuallMiniSide = 80;
        }
        // 返回的高度是图片高度，需加上消息内边距变成消息体高度
        if (maxSide == width) {
            cellSize = CGSizeMake(maxLength, actuallMiniSide + msg.chatConfig.messageMargin * 2);
        } else {
            cellSize = CGSizeMake(actuallMiniSide, maxLength + msg.chatConfig.messageMargin * 2);
        }
    } else if ([msg.reuseIdentifierForCustomeCell isEqualToString:CustomNewsCellReuseId]) {
        cellSize = CGSizeMake(ScreenW * 0.65, ScreenW * 0.3);
    }
    return cellSize;
}

- (void)chatlistLoadMoreMsg:(CDChatMessage)topMessage callback:(void (^)(CDChatMessageArray, BOOL))finnished{
    finnished(nil,NO);
}

@end
