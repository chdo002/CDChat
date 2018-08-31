//
//  CustomMsgViewController.m
//  CDChatList_Example
//
//  Created by chdo on 2018/8/30.
//  Copyright © 2018年 chdo002. All rights reserved.
//

#import "CustomMsgViewController.h"
#import "CDChatList.h"
#import "CustomeGifMsgCell.h"
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
    NSMutableArray <CDMessageModel *>*msgs = [NSMutableArray arrayWithCapacity:array.count];
    NSInteger autoInc = 1;
    for (NSDictionary *dic in array) {
        CDMessageModel *model = [[CDMessageModel alloc] init:dic];
        model.messageId = [NSString stringWithFormat:@"%ld",(long)autoInc++];
        if (model.msgType == CDMessageTypeCustome) {
            model.reuseIdentifierForCustomeCell = CustomeMsgCellReuseId;
        }
        [msgs addObject:model];
    }
    
    list.msgArr = msgs;
}

-(NSDictionary<NSString *,Class> *)chatlistCustomeCellsAndClasses{
    return @{CustomeMsgCellReuseId: CustomeGifMsgCell.class};
}

-(CGSize)chatlistSizeForMsg:(CDChatMessage)msg ofList:(CDChatListView *)list{
    CGSize cellSize = CGSizeZero;
    
    
    
    if ([msg.reuseIdentifierForCustomeCell isEqualToString:CustomeMsgCellReuseId]) {
        
        // 获得本地缓存的图片
        UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey: msg.msg];
        if (!image) {
            image = [[SDImageCache sharedImageCache] imageFromCacheForKey: msg.messageId];
        }
        
        // 图片将被限制在140*140的区域内，按比例显示
        CGFloat width = image.size.width;
        CGFloat height = image.size.height;
        
        CGFloat maxSide = MAX(width, height);
        CGFloat miniSide = MIN(width, height);
        
        // 按比例缩小后的小边边长
        CGFloat actuallMiniSide = 140 * miniSide / maxSide;
        
        // 防止长图，宽图，限制最小边 下限
        if (actuallMiniSide < 80) {
            actuallMiniSide = 80;
        }
        
        cellSize = CGSizeMake(200, 200);
    }
    return cellSize;
}

- (void)chatlistLoadMoreMsg:(CDChatMessage)topMessage callback:(void (^)(CDChatMessageArray, BOOL))finnished{

}

@end
