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

    self.msgArr = [NSMutableArray arrayWithObjects:@"1",@"2", nil];
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSString *msg in self.msgArr) {
        CDMessageModal *modal = [[CDMessageModal alloc] init];
        modal.msg = msg;
        modal.createTime = [NSString stringWithFormat:@"%ld", (long) [[NSDate date] timeIntervalSince1970] * 1000];
        modal.msgType = @"text";
        
        NSString *number = @"";
        for (int i = 1; i <= 5; i ++) {
            int x = arc4random() % 10;
            number = [number stringByAppendingString:[NSString stringWithFormat:@"%i",x]];
        }
        modal.messageId = number;
        [arr addObject:modal];
    }
    
    self.msgArr = [arr mutableCopy];
    CDChatList *list = [[CDChatList alloc] initWithFrame:self.view.bounds];
    self.listView = list;
    self.listView.msgArr = self.msgArr;
    [self.view addSubview:self.listView];
    
    
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    [self.navigationItem setRightBarButtonItem: item];
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
    
    
    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:self.msgArr];
    [tempArr addObject:modal];
    self.msgArr = tempArr;
    self.listView.msgArr = self.msgArr;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
