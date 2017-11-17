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

-(void)action1{
    
    
    CDChatMessage msg = self.msgArr.lastObject;
    msg.msgState = CDMessageStateNormal;
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
    
    CDMessageModal *mode = [[CDMessageModal alloc] init];
    mode.msg = @"[大哭][足球][发怒][猪头][傲慢][流汗][爱心][冷汗][拳头][飞吻][发抖][嘴唇][难过][色][撇嘴][玫瑰][咖啡][差劲][偷笑][微笑][爱你][抓狂][擦汗][月亮][再见][西瓜][阴险][乱舞][快哭了][投降][疑问][亲亲][敲打][骷髅][乒乓][饥饿][奋斗][跳绳][闭嘴][太阳][疯了][发呆][白眼][坏笑][怄火][惊讶][右哼哼][凋谢][惊恐][困][得意][鼓掌][刀][害羞][礼物][瓢虫][流泪][吐][悠闲][磕头][糗大了][啤酒][NO][菜刀][咒骂][睡][爱情][蛋糕][便便][胜利][勾引][委屈][右太极][篮球][愉快][嘘][衰][抠鼻][献吻][心碎][强][OK][弱][调皮][晕][憨笑][左哼哼][酷][呲牙][激动][跳跳][握手][鄙视][抱拳][尴尬][吓][回头][炸弹][转圈][饭][可怜][闪电][拥抱][左太极][哈欠]";
    mode.messageId = @"12312";
    mode.createTime = @"1509634535127";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        finnished(@[mode]);
    });
    
}


@end
