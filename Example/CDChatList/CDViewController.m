//
//  CDViewController.m
//  CDChatList
//
//  Created by chdo002 on 03/20/2018.
//  Copyright (c) 2018 chdo002. All rights reserved.
//

#import "CDViewController.h"
#import "CDChatList.h"
#define NaviH (44 + [[UIApplication sharedApplication] statusBarFrame].size.height)
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface CDViewController ()<ChatListProtocol,CTInputViewProtocol>
@property(nonatomic, weak)CDChatListView *listView;
@property(nonatomic, weak)CTInputView *inputView;
@end

@implementation CDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    self.view.backgroundColor = [UIColor whiteColor];
    CDChatListView *list = [[CDChatListView alloc] initWithFrame:CGRectMake(0, NaviH, ScreenW, ScreenH - NaviH - CTInputViewHeight)];
    list.msgDelegate = self;
    self.listView = list;
    [self.view addSubview:list];
    
    CTInputView *input = [[CTInputView alloc] initWithFrame:CGRectMake(0,ScreenH - CTInputViewHeight, ScreenW, CTInputViewHeight)];
    input.delegate = self;
    self.inputView = input;
    [self.view addSubview:input];
}


#pragma mark ChatListProtocol

- (void)chatlistClickMsgEvent:(ChatListInfo *)listInfo {
    
}

- (void)chatlistLoadMoreMsg:(CDChatMessage)topMessage callback:(void (^)(CDChatMessageArray))finnished {
    
}

#pragma mark CTInputViewProtocol

- (void)inputViewPopAudioath:(NSURL *)path {
    
}

- (void)inputViewPopCommand:(NSString *)string {

}

- (void)inputViewPopSttring:(NSString *)string {
    CDMessageModel *model = [[CDMessageModel alloc] init];
    model.msg = string;
    // 加入列表UI
    [self.listView addMessagesToBottom:@[model]];
}

- (void)inputViewWillUpdateFrame:(CGRect)newFrame animateDuration:(double)duration animateOption:(NSInteger)opti {
    //  当输入框因为多行文本变高时，listView需要做响应变化
    CGFloat inset_bot = ScreenH - CTInputViewHeight - newFrame.origin.y;
    UIEdgeInsets inset = UIEdgeInsetsMake(self.listView.contentInset.top,
                                          self.listView.contentInset.left,
                                          inset_bot,
                                          self.listView.contentInset.right);
    [self.listView setContentInset:inset];
    [self.listView relayoutTable:YES];
}

@end
