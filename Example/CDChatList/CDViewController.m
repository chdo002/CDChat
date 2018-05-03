//
//  CDViewController.m
//  CDChatList
//
//  Created by chdo002 on 03/20/2018.
//  Copyright (c) 2018 chdo002. All rights reserved.
//

#import "CDViewController.h"
#import "CDChatList.h"
#import <GDPerformanceView/GDPerformanceMonitor.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "MsgPicViewController.h"

#define NaviH (44 + [[UIApplication sharedApplication] statusBarFrame].size.height)
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface CDViewController ()<ChatListProtocol,CTInputViewProtocol,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property(nonatomic, weak)CDChatListView *listView;
@property(nonatomic, weak)CTInputView *msginputView;
@end

@implementation CDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[GDPerformanceMonitor sharedInstance] startMonitoringWithConfiguration:^(UILabel *textLabel) {
        textLabel.font = [UIFont systemFontOfSize:10];
        textLabel.numberOfLines = 1;
    }];
    
    self.view.backgroundColor = [UIColor whiteColor];
    CDChatListView *list = [[CDChatListView alloc] initWithFrame:CGRectMake(0, NaviH, ScreenW, ScreenH - NaviH - CTInputViewHeight)];
    list.msgDelegate = self;
    self.listView = list;
    [self.view addSubview:list];
    
    CTInputView *input = [[CTInputView alloc] initWithFrame:CGRectMake(0,ScreenH - CTInputViewHeight, ScreenW, CTInputViewHeight)];
    input.delegate = self;
    self.msginputView = input;
    [self.view addSubview:input];
    
    
    // 通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name: CDChatListDidScroll object:nil];
    
    
    NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"messageHistory" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *msgs = [NSMutableArray arrayWithCapacity:array.count];
    for (NSDictionary *dic in array) {
        NSString *msg = dic[@"msg"];
        CDMessageModel *model = [[CDMessageModel alloc] init];
        model.msg = msg;
        [msgs addObject:model];
    }
    self.listView.msgArr = msgs;
}

-(void)receiveNotification:(NSNotification *)noti{
    if ([noti.name isEqualToString: CDChatListDidScroll]) {
        [self.msginputView resignFirstResponder];
    }
}

#pragma mark ChatListProtocol

//cell 的点击事件
- (void)chatlistClickMsgEvent:(ChatListInfo *)listInfo {
    switch (listInfo.eventType) {
        case ChatClickEventTypeIMAGE:
            {
                CGRect newe =  [listInfo.containerView.superview convertRect:listInfo.containerView.frame toView:self.view];
//                [MsgPicViewController addToRootViewController:listInfo.image in:newe from: self.listView.msgArr];
            }
            break;
        case ChatClickEventTypeTEXT:
            
            break;
    }
}

- (void)chatlistLoadMoreMsg:(CDChatMessage)topMessage callback:(void (^)(CDChatMessageArray))finnished {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"messageHistory" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:5];
        for (int i = 0; i<11; i++) {
            CDMessageModel *model = [[CDMessageModel alloc] init];
            model.msg = array[0][@"msg"];
            [arr addObject:model];
        }
        finnished(arr);
    });
}

#pragma mark CTInputViewProtocol

- (void)inputViewPopAudioath:(NSURL *)path {
    CDMessageModel *model = [[CDMessageModel alloc] init];
    model.msg = @"fsdfdf";
    model.msgType = CDMessageTypeAudio;
    model.isLeft = YES;
    [self.listView addMessagesToBottom:@[model]];
}

- (void)inputViewPopCommand:(NSString *)string {
    UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
    imagePick.delegate = self;
    [self.navigationController presentViewController:imagePick animated:YES completion:^{}];
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *img = info[UIImagePickerControllerOriginalImage];
    /*
     发送图片消息时，为了达到消息还没发出就已经展示在页面上的效果，需要SDImageCache预先缓存，用messageid作为Key，
     发送完成后，将图片的完整地址保存到此字段中。
     */
    CDMessageModel *model = [[CDMessageModel alloc] init];
    model.msgType = CDMessageTypeImage;
    model.msgState = CDMessageStateSending;
    model.messageId = @"2938429384924";
    [[SDImageCache sharedImageCache] storeImage:img forKey:model.messageId completion:nil];
    [self.listView addMessagesToBottom:@[model]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        model.msgState = CDMessageStateNormal;
        [self.listView updateMessage:model];
    });
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
    [self.listView relayoutTable:YES ];
}

@end
