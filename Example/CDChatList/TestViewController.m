//
//  TestViewController.m
//  CDChatList_Example
//
//  Created by chdo on 2018/8/31.
//  Copyright © 2018年 chdo002. All rights reserved.
//

#import "TestViewController.h"
#import "FLAnimatedImageView+WebCache.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    FLAnimatedImageView *vv  = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(20, 100, 200, 200)];
    [self.view addSubview:vv];
    
    [vv sd_setImageWithURL:[NSURL URLWithString:@"http://img.soogif.com/tKfb8AePf4hiwR70Jks0L2eMI9bSJ32C.gif_s400x0"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    FLAnimatedImageView *vv2  = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(20, 300, 200, 200)];
    [self.view addSubview:vv2];
    
    [vv2 sd_setImageWithURL:[NSURL URLWithString:@"http://img.soogif.com/QHAESCYVcGXu0Oghc1EFsu8WsyL2L4bI.gif_s400x0"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
    
    FLAnimatedImageView *vv3  = [[FLAnimatedImageView alloc] initWithFrame:CGRectMake(20, 500, 200, 200)];
    [self.view addSubview:vv3];
    
    [vv3 sd_setImageWithURL:[NSURL URLWithString:@"http://img.soogif.com/gSj6vbcUHDSLb3frNVt4BbFZlLiXW0tC.gif_s400x0"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        
    }];
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
