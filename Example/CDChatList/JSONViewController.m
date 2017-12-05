//
//  JSONViewController.m
//  CDChatList_Example
//
//  Created by chdo on 2017/11/2.
//  Copyright © 2017年 chdo002. All rights reserved.
//

#import "JSONViewController.h"
#import "CDMessageModal.h"
#import "CDChatList_Example-Swift.h"
#import <CDChatList/CDChatList.h>

@interface JSONViewController ()<ChatListProtocol>
@property(nonatomic, weak)CDChatList *listView;
@property(nonatomic, strong)NSMutableArray<CDChatMessage> *msgArr;

@end

@implementation JSONViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    CDChatList *list = [[CDChatList alloc] initWithFrame:self.view.bounds];
    
    list.msgDelegate = self;
    list.viewController = self;
    self.listView = list;
    [self.view addSubview:self.listView];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"动作1" style:UIBarButtonItemStyleDone target:self action:@selector(action1)];
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithTitle:@"动作2" style:UIBarButtonItemStyleDone target:self action:@selector(action2)];
    UIBarButtonItem *item3 = [[UIBarButtonItem alloc] initWithTitle:@"动作3" style:UIBarButtonItemStyleDone target:self action:@selector(action3)];
    [self.navigationItem setRightBarButtonItems:@[item1, item2, item3]];
    
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

-(void)action1{
    
    
    CDChatMessage msg = self.msgArr.lastObject;
    msg.msgState = CDMessageStateNormal;
    [self.listView updateMessage:msg];
}

-(void)action2{
    [self.listView reloadData];
}

-(void)listen{
    
}

-(void)action3{
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    
}

-(void)chatlistLoadMoreMsg: (CDChatMessage)topMessage
                  callback: (void(^)(CDChatMessageArray))finnished {
    
    CDMessageModal *mode = [[CDMessageModal alloc] init];
    mode.msg = [self radomString];
    mode.messageId = @"12312556";
    mode.createTime = @"1509634535127";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        finnished(@[mode]);
    });
}

-(void)chatlistClickMsgEvent:(ChatListInfo *)listInfo{
    
    CGRect rec =  [self.listView convertRect:listInfo.msgImageRectInTableView toView:self.view];
    
    if (listInfo.eventType == ChatClickEventTypeIMAGE) {
        [ImageViewer showImageWithImage:listInfo.image rectInWindow:rec];
    } else if (listInfo.eventType == ChatClickEventTypeTEXT){
        
        UIAlertController *alert = [[UIAlertController alloc] init];
        alert.message = listInfo.clickedTextContent;
        UIAlertAction *aciotn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:nil];
        [alert addAction:aciotn];
        [self presentViewController:alert animated:YES completion:nil];
    }
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
