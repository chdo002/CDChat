//
//  CDViewController.m
//  CDChatList
//
//  Created by chdo002 on 10/25/2017.
//  Copyright (c) 2017 chdo002. All rights reserved.
//

#import "CDViewController.h"
#import <CDChatList/CDChatList.h>
#import "CDMessageModal.h"


@interface CDViewController ()
@property(nonatomic, weak)CDChatList *listView;
@property(nonatomic, copy)NSMutableArray *msgArr;
@end

@implementation CDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    
    // 创建ListView
    CDChatList *list = [[CDChatList alloc] initWithFrame:self.view.bounds];
    self.listView = list;
    
    [self.view addSubview:self.listView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"添加新的消息" style:UIBarButtonItemStyleDone target:self action:@selector(refresh)];
    [self.navigationItem setRightBarButtonItem: item];
    
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //  初始化消息
        NSMutableArray *items = [NSMutableArray array];
        for (int i = 0; i < 40; i++) {
            CDMessageModal *modal = [[CDMessageModal alloc] init];
            modal.msg = [NSString stringWithFormat:@"%d",i];
            modal.createTime = [NSString stringWithFormat:@"%ld", (long) [[NSDate date] timeIntervalSince1970] * 1000];
            modal.msgType = @"text";
            
            NSString *number = @"";
            for (int i = 1; i <= 5; i ++) {
                int x = arc4random() % 10;
                number = [number stringByAppendingString:[NSString stringWithFormat:@"%i",x]];
            }
            modal.messageId = number;
            [items addObject:modal];
        }
        self.msgArr = [items mutableCopy];
        self.listView.msgArr = self.msgArr;
    });
}

/**
 刷新界面
 */
-(void)refresh{
    
    CDMessageModal *modal = [[CDMessageModal alloc] init];
    
    modal.createTime = [NSString stringWithFormat:@"%ld", (long) [[NSDate date] timeIntervalSince1970] * 1000];
    modal.msg = [NSString stringWithFormat:@"新消息%@",modal.createTime];
    modal.msgType = @"text";
    
    NSString *number = @"";
    for (int i = 1; i <= 5; i ++) {
        int x = arc4random() % 10;
        number = [number stringByAppendingString:[NSString stringWithFormat:@"%i",x]];
    }
    modal.messageId = number;
    
//    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self.msgArr];
//    [tempArr addObject:modal];
//    self.msgArr = tempArr;
//    self.listView.msgArr = self.msgArr;
    
    [self.listView addMessagesToBottom:@[modal]];
}

-(void)viewDidAppear:(BOOL)animated{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
