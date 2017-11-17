//
//  CDViewController.m
//  CDChatList
//
//  Created by chdo002 on 10/25/2017.
//  Copyright (c) 2017 chdo002. All rights reserved.
//

#import "CDViewController.h"

#import "CDMessageModal.h"
#import "UIImageView+WebCache.h"

@interface CDViewController ()<ChatListProtocol>@property(nonatomic, weak)CDChatList *listView;
@property(nonatomic, copy)NSMutableArray *msgArr;
@end

@implementation CDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 创建ListView
    
//    self.automaticallyAdjustsScrollViewInsets = NO;

    CDChatList *list = [[CDChatList alloc] initWithFrame:self.view.bounds];
    
    list.msgDelegate = self;
    list.viewController = self;
    self.listView = list;
    
    
    [self.view addSubview:self.listView];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"添加新的消息" style:UIBarButtonItemStyleDone target:self action:@selector(refresh)];
    [self.navigationItem setRightBarButtonItem: item];
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        //  初始化消息
        NSMutableArray *items = [NSMutableArray array];
        for (int i = 0; i < 15; i++) {
            CDMessageModal *modal = [[CDMessageModal alloc] init];
    
            modal.msg = [NSString stringWithFormat:@"%d",i];
            modal.createTime = [NSString stringWithFormat:@"%ld", (long) [[NSDate date] timeIntervalSince1970] * 1000];
            modal.msgType = CDMessageTypeText;
            NSString *number = @"";
            
            for (int i = 1; i <= 5; i ++) {
                int x = arc4random() % 10;
                number = [number stringByAppendingString:[NSString stringWithFormat:@"%i",x]];
            }
            
           UIColor *color = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
            modal.modalInfo = @{@"color": color};
            modal.messageId = number;
            [items addObject:modal];
        }
        
        self.msgArr = [items mutableCopy];
        self.listView.msgArr = self.msgArr;
        
    });
    
    
}

/**
 add more
 */
-(void)refresh{

    CDMessageModal *modal = [[CDMessageModal alloc] init];
    modal.createTime = [NSString stringWithFormat:@"%ld", (long) [[NSDate date] timeIntervalSince1970] * 1000];
    modal.msg = [NSString stringWithFormat:@"新消息%@",modal.createTime];
    modal.msgType = CDMessageTypeText;
    
    NSString *number = @"";
    for (int i = 1; i <= 5; i ++) {
        int x = arc4random() % 10;
        number = [number stringByAppendingString:[NSString stringWithFormat:@"%i",x]];
    }
    modal.messageId = number;
    UIColor *color = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
    modal.modalInfo = @{@"color": color};
    [self.listView addMessagesToBottom:@[modal]];
}

-(void)loadMoreMsg:(CDChatMessage)topMessage callback:(void (^)(CDChatMessageArray))finnished{
    
    NSMutableArray *items = [NSMutableArray array];
    for (int i = 0; i < 15; i++) {
        CDMessageModal *modal = [[CDMessageModal alloc] init];
        
        modal.msg = [NSString stringWithFormat:@"%d",i];
        modal.createTime = [NSString stringWithFormat:@"%ld", (long) [[NSDate date] timeIntervalSince1970] * 1000];
//        modal.msg = [NSString stringWithFormat:@"新消息%d",i];
        NSString *number = @"";
        for (int i = 1; i <= 5; i ++) {
            int x = arc4random() % 10;
            number = [number stringByAppendingString:[NSString stringWithFormat:@"%i",x]];
        }
        modal.messageId = number;
        
        UIColor *color = [UIColor colorWithRed:arc4random_uniform(255)/255.0 green:arc4random_uniform(255)/255.0 blue:arc4random_uniform(255)/255.0 alpha:1];
        modal.modalInfo = @{@"color": color};
        [items addObject:modal];
    }
    NSArray *newMesgs = [items mutableCopy];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       finnished(newMesgs);
    });
}

-(void)viewDidAppear:(BOOL)animated{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
