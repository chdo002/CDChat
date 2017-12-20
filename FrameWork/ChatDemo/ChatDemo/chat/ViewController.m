//
//  ViewController.m
//  ChatDemo
//
//  Created by chdo on 2017/12/20.
//  Copyright © 2017年 aat. All rights reserved.
//

#import "ViewController.h"
#import <AATChatList/AATChatList.h>
#import <AATUtility/AATUtility.h>
#import "CDMessageModal.h"

@interface ViewController ()
@property(nonatomic, weak)CDChatList *listView;
@property(nonatomic, strong)NSMutableArray<CDChatMessage> *msgArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    
    
    CDChatList *list = [[CDChatList alloc] initWithFrame:self.view.bounds];
    list.msgDelegate = self;
    self.listView = list;
    [self.view addSubview:self.listView];
    
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"msgList" ofType:@"json"];
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
