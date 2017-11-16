//
//  JSONViewController.m
//  CDChatList_Example
//
//  Created by chdo on 2017/11/2.
//  Copyright © 2017年 chdo002. All rights reserved.
//

#import "JSONViewController.h"
#import "CDMessageModal.h"
#import <Masonry/Masonry.h>

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
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"msgList2" ofType:@"json"];
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
//    [self.msgArr replaceObjectAtIndex:_msgArr.count - 1 withObject:msg];
    [self.listView updateMessage:msg];
}

-(void)action2{
    
}

-(void)listen{
    
}

-(void)action3{
    
}


-(void)viewWillAppear:(BOOL)animated{
    
    
}

- (void)loadMoreMsg:(CDChatMessage)topMessage callback:(void (^)(CDChatMessageArray))finnished {
    finnished(nil);
}


@end
