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

@end

@implementation CDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    CDChatList *listView = [[CDChatList alloc] initWithFrame:self.view.bounds];
    listView.msgArr = @[@"1", @"2"];
    [self.view addSubview:listView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
