//
//  TestViewController.m
//  CDChatList_Example
//
//  Created by chdo on 2018/6/6.
//  Copyright © 2018年 chdo002. All rights reserved.
//

#import "TestViewController.h"
#import "CDChatList.h"

#define NaviH (44 + [[UIApplication sharedApplication] statusBarFrame].size.height)
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height
@interface TestViewController ()
@property(nonatomic, weak)CDChatListView *listView;
@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    CDChatListView *list = [[CDChatListView alloc] initWithFrame:CGRectMake(0,
                                                                            NaviH,
                                                                            ScreenW,
                                                                            ScreenH - NaviH)];
    
    self.listView = list;
    [self.view addSubview:list];
    
}

-(void)viewDidAppear:(BOOL)animated{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        CDMessageModel *model = [[CDMessageModel alloc] init];
        model.msg = @"fsdfdf";
        model.msgType = CDMessageTypeText;
        model.isLeft = YES;
        [self.listView addMessagesToBottom:@[model]];
    });
}

@end
