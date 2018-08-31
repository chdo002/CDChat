//
//  CustomMsgViewController.m
//  CDChatList_Example
//
//  Created by chdo on 2018/8/30.
//  Copyright © 2018年 chdo002. All rights reserved.
//

#import "CustomMsgViewController.h"
#import "CDChatList.h"
#import "CustomeMsgCell.h"
#define StatusH [[UIApplication sharedApplication] statusBarFrame].size.height
#define NaviH (44 + StatusH)
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface CustomMsgViewController ()<ChatListProtocol>

@end

@implementation CustomMsgViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
        [msgs addObject:model];
    }
    list.msgArr = msgs;
    
}


-(NSDictionary<NSString *,Class> *)chatlistCustomeCellsAndClasses{
    return @{CustomeMsgCellReuseId: CustomeMsgCell.class};
}

-(CGSize)chatlistSizeForMsg:(CDChatMessage)msg ofList:(CDChatListView *)list{
    CGSize cellSize = CGSizeZero;
    if ([msg.reuseIdentifierForCustomeCell isEqualToString:CustomeMsgCellReuseId]) {
        cellSize = CGSizeMake(200, 100);
    }
    return cellSize;
}

- (void)chatlistLoadMoreMsg:(CDChatMessage)topMessage callback:(void (^)(CDChatMessageArray, BOOL))finnished{
    
}

@end
