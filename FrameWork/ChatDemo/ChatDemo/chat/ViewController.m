//
//  ViewController.m
//  ChatDemo
//
//  Created by chdo on 2017/12/20.
//  Copyright © 2017年 aat. All rights reserved.
//

#import "ViewController.h"
#import <AATChatList/AATChatList.h>
#import <AATUtility/AATUtility.h>
#import "CDMessageModal.h"

@interface ViewController ()<ChatListProtocol>
@property(nonatomic, weak)CDChatList *listView;
@property(nonatomic, strong)NSMutableArray<CDChatMessage> *msgArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CDChatList *list = [[CDChatList alloc] initWithFrame:self.view.bounds];
    list.msgDelegate = self;
    self.listView = list;
    [self.view addSubview:self.listView];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"msgList" ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSError *err;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&err];
    
    NSMutableArray *msgArr = [NSMutableArray array];
    
    for (NSDictionary *dic in arr) {
        CDMessageModal *modal = [CDMessageModal initWithDic:dic];
        [msgArr addObject:modal];
    }
    
    self.listView.msgArr = msgArr;
    self.msgArr = msgArr;
    
}

- (void)chatlistClickMsgEvent:(ChatListInfo *)listInfo {
    

    if (listInfo.eventType == ChatClickEventTypeIMAGE) {
        CGRect rec =  [self.listView convertRect:listInfo.msgImageRectInTableView toView:self.view];
        [AATHUD showInfo:NSStringFromCGRect(rec) andDismissAfter:1];
    } else if (listInfo.eventType == ChatClickEventTypeTEXT){
        [AATHUD showInfo:listInfo.clickedTextContent andDismissAfter:1];
    }
}

- (void)chatlistLoadMoreMsg:(CDChatMessage)topMessage callback:(void (^)(CDChatMessageArray))finnished {
    
    CDMessageModal *mode = [[CDMessageModal alloc] init];
    mode.msg = [self radomString];
    mode.isLeft = arc4random() % 2 == 1;
    mode.messageId = @"12312556";
    mode.createTime = @"1509634535127";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        finnished(@[mode]);
    });
}


-(NSString *)radomString{
    
    NSString *pool = @"推送佛哦时间风高放火金坷垃发生丢开方便农民， 爱说的反馈规划局客服更是加快哦票紧迫i";
    NSArray *emArr = @[@"[惊恐]",@"[困]",@"[得意]",@"[鼓掌]",@"[刀]",@"[害羞]",@"[礼物]",@"[哈欠]",@"[拳头]",@"[飞吻]",@"[发抖]",@"[嘴唇]"];
    NSMutableString *str = [[NSMutableString alloc] init];
    
    int lent = arc4random() % 50 + 50;
    for (int i = 0; i < lent; i ++) {
        int x = arc4random() % emArr.count;
        [str appendString:emArr[x]];
    }
    for (int i = 0; i < lent; i ++) {
        int x = arc4random() % [pool length];
        [str appendString:[pool substringWithRange:NSMakeRange(x, 1)]];
    }
    for (int i = 0; i < lent; i ++) {
        int x = arc4random() % emArr.count;
        [str appendString:emArr[x]];
    }
    return [str copy];
}

@end
