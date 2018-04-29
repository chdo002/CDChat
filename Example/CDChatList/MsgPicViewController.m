//
//  MsgPicViewController.m
//  CDChatList_Example
//
//  Created by chdo on 2018/4/29.
//  Copyright © 2018年 chdo002. All rights reserved.
//

#import "MsgPicViewController.h"

@interface MsgPicViewController ()
{
    UIScrollView *scrol;
}
@end

@implementation MsgPicViewController

+(void)addToRootViewController:(UIImage *)img in :(CGRect)imgRectIntTableView from: (CDChatMessageArray) msgs{
    
    MsgPicViewController *msgVc = [[MsgPicViewController alloc] init];
    msgVc.img = img;
    msgVc.imgRectIntTableView = imgRectIntTableView;
    msgVc.msgs = msgs;
    
    msgVc.view.backgroundColor = [UIColor clearColor];
    msgVc.view.frame = [UIScreen mainScreen].bounds;
    
    [msgVc willMoveToParentViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    [[UIApplication sharedApplication].keyWindow.rootViewController addChildViewController:msgVc];
    [[UIApplication sharedApplication].keyWindow addSubview:msgVc.view];
    [msgVc didMoveToParentViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

-(void)willMoveToParentViewController:(UIViewController *)parent{
    scrol = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrol.backgroundColor = [UIColor clearColor];
    [self.view addSubview:scrol];
    scrol.contentSize = CGSizeMake(self.msgs.count * ScreenWidth, 0);
}

-(void)didMoveToParentViewController:(UIViewController *)parent{
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
