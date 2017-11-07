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

@interface JSONViewController ()
@property(nonatomic, weak)CDChatList *listView;
@property(nonatomic, copy)NSMutableArray *msgArr;

@end

@implementation JSONViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//
//    UIView *red = [[UIView alloc] init];
//    red.backgroundColor = [UIColor redColor];
//    [self.view addSubview:red];
//
//    UIView *blue = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 50, 50)];
//    blue.backgroundColor = [UIColor blackColor];
//    [self.view addSubview:blue];
//
//    [red mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.width.equalTo(@70);
//        make.height.equalTo(@20);
//
//        make.leading.equalTo(blue.mas_trailing).offset(100);
//        make.centerY.equalTo(blue);
//    }];
//
//    return;
 
    CDChatList *list = [[CDChatList alloc] initWithFrame:self.view.bounds];
//    list.msgDelegate = self;
    list.viewController = self;
    self.listView = list;
    [self.view addSubview:self.listView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
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
}
@end
