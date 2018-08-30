//
//  BaseViewController.m
//  CDChatList_Example
//
//  Created by chdo on 2018/8/30.
//  Copyright © 2018年 chdo002. All rights reserved.
//

#import <GDPerformanceView/GDPerformanceMonitor.h>
#import "MsgPicViewController.h"
#import "BaseViewController.h"
#import "BaseMsgModel.h"
#import "CDChatList.h"

#define StatusH [[UIApplication sharedApplication] statusBarFrame].size.height
#define NaviH (44 + StatusH)
#define ScreenW [UIScreen mainScreen].bounds.size.width
#define ScreenH [UIScreen mainScreen].bounds.size.height

@interface BaseViewController ()
<ChatListProtocol,
CTInputViewProtocol,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate>
@property(nonatomic, weak)CDChatListView *listView;
@property(nonatomic, weak)CTInputView *msginputView;
@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[GDPerformanceMonitor sharedInstance] startMonitoringWithConfiguration:^(UILabel *textLabel) {
        textLabel.font = [UIFont systemFontOfSize:10];
        textLabel.numberOfLines = 1;
    }];
    // 初始化聊天界面
    BOOL isIphoneX = ScreenH >= 812;
    CDChatListView *list = [[CDChatListView alloc] initWithFrame:CGRectMake(0,
                                                                            NaviH,
                                                                            ScreenW,
                                                                            ScreenH - NaviH - CTInputViewHeight - (isIphoneX ? StatusH : 0))];
    list.msgDelegate = self;
    self.listView = list;
    [self.view addSubview:list];
    
    // 初始化输入框
    CTInputView *input = [[CTInputView alloc] initWithFrame:CGRectMake(0,
                                                                       list.cd_bottom,
                                                                       ScreenW,
                                                                       CTInputViewHeight)];
    input.delegate = self;
    self.msginputView = input;
    [self.view addSubview:input];
    
    // 加载本地聊天消息
    NSString *jsonPath = [NSBundle.mainBundle pathForResource:@"messageHistory" ofType:@"json"];
    NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
    NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray <BaseMsgModel *>*msgs = [NSMutableArray arrayWithCapacity:array.count];
    NSInteger autoInc = 1;
    for (NSDictionary *dic in array) {
        BaseMsgModel *model = [[BaseMsgModel alloc] init:dic];
        model.messageId = [NSString stringWithFormat:@"%ld",(long)autoInc++];
        [msgs addObject:model];
    }
    self.listView.msgArr = msgs;
}


#pragma mark ChatListProtocol

-(void)chatlistBecomeFirstResponder{
    [self.msginputView resignFirstResponder];
}

//cell 的点击事件
- (void)chatlistClickMsgEvent:(ChatListInfo *)listInfo {
    switch (listInfo.eventType) {
        case ChatClickEventTypeIMAGE:
        {
            CGRect newe =  [listInfo.containerView.superview convertRect:listInfo.containerView.frame toView:self.view];
            [MsgPicViewController addToRootViewController:listInfo.image ofMsgId:listInfo.msgModel.messageId in:newe from:self.listView.msgArr];
        }
            break;
        case ChatClickEventTypeTEXT:
            
            break;
    }
}

// 下拉加载更多
- (void)chatlistLoadMoreMsg:(CDChatMessage)topMessage callback:(void (^)(CDChatMessageArray,BOOL))finnished {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSString *jsonPath = [[NSBundle mainBundle] pathForResource:@"messageHistory" ofType:@"json"];
        NSData *jsonData = [NSData dataWithContentsOfFile:jsonPath];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
        
        NSMutableArray *arr = [NSMutableArray arrayWithCapacity:5];
        for (int i = 0; i<11; i++) {
            BaseMsgModel *model = [[BaseMsgModel alloc] init];
            model.msg = array[0][@"msg"];
            model.msgType = CDMessageTypeImage;
            model.userThumImage = [UIImage imageNamed:@"thum"];
            [arr addObject:model];
        }
        finnished(arr,YES);
    });
}

#pragma mark CTInputViewProtocol

- (void)inputViewPopAudioath:(NSURL *)path {
    
    // 此处会存到内存和本地， 内存地址不会加密，本地地址会加密
    NSData *data = [NSData dataWithContentsOfURL:path];
    
    NSString *createTtime = [NSString stringWithFormat:@"%ld",(long)[[NSDate date] timeIntervalSince1970]];
    
    NSString *sufix = [path.absoluteString componentsSeparatedByString:@"."].lastObject;
    
    [[SDImageCache sharedImageCache] cd_storeImageData:data forKey:[NSString stringWithFormat:@"%@.%@",createTtime,sufix] toDisk:YES completion:^{
        
        CDMessageModel *mode = [[CDMessageModel alloc] init];
        mode.msgType = CDMessageTypeAudio;
        mode.msgState = CDMessageStateNormal;
        mode.msg = [path absoluteString];
        mode.isLeft = arc4random() % 2 == 1;
        mode.createTime = createTtime;
        mode.messageId = createTtime;
        mode.audioSufix = sufix;
        [self.listView addMessagesToBottom:@[mode]];
        
    }];
}


- (void)inputViewPopCommand:(NSString *)string {
    UIImagePickerController *imagePick = [[UIImagePickerController alloc] init];
    imagePick.delegate = self;
    [self presentViewController:imagePick animated:YES completion:^{}];
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
    model.msg = info[UIImagePickerControllerMediaURL];
    model.msgState = CDMessageStateSending;
    UInt64 recordTime = [[NSDate date] timeIntervalSince1970]*1000;
    double timeInter = recordTime;
    model.messageId = [NSString stringWithFormat:@"%0.3f" ,timeInter] ;
    [[SDImageCache sharedImageCache] storeImage:img forKey:model.messageId completion:nil];
    [self.listView addMessagesToBottom:@[model]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        model.msgState = CDMessageStateNormal;
        [self.listView updateMessage:model];
    });
}
// 输入框输出文字
- (void)inputViewPopSttring:(NSString *)string {
    CDMessageModel *model = [[CDMessageModel alloc] init];
    model.msg = string;
    // 加入列表UI
    [self.listView addMessagesToBottom:@[model]];
}

// 当输入框frame变化是，会回调此方法
- (void)inputViewWillUpdateFrame:(CGRect)newFrame animateDuration:(double)duration animateOption:(NSInteger)opti {
    //  当输入框因为多行文本变高时，listView需要做响应变化
    BOOL isIphoneX = ScreenH >= 812;
    CGFloat inset_bot = ScreenH - CTInputViewHeight - newFrame.origin.y - (isIphoneX ? StatusH : 0);
    
    UIEdgeInsets inset = UIEdgeInsetsMake(self.listView.contentInset.top,
                                          self.listView.contentInset.left,
                                          inset_bot,
                                          self.listView.contentInset.right);
    [self.listView setContentInset:inset];
    [self.listView relayoutTable:YES];
}


-(BOOL)canBecomeFirstResponder{
    return YES;
}
@end
