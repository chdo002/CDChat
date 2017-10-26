//
//  CDViewController.m
//  CDChatList
//
//  Created by chdo002 on 10/25/2017.
//  Copyright (c) 2017 chdo002. All rights reserved.
//

#import "CDViewController.h"
#import <CDChatList/CDChatList.h>

@interface CDViewController ()
@property(nonatomic, weak)CDChatList *listView;
@end

@implementation CDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    CDChatList *list = [[CDChatList alloc] initWithFrame:self.view.bounds];
    self.listView = list;
    self.listView.msgArr = @[@"1", @"2"];
    [self.view addSubview:self.listView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(refresh)];
    [self.navigationItem setRightBarButtonItem: item];
}

/**
 刷新界面
 */
-(void)refresh{
    NSArray *arrr =  self.listView.msgArr;
    
    NSMutableArray *newArr = [NSMutableArray arrayWithArray:arrr];
    [newArr addObject:@"haha"];
    
//   self.listView.msgArr = newArr;
    
    [self.listView setMsgArr:newArr];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
