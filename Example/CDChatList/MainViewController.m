//
//  MainViewController.m
//  CDChatList_Example
//
//  Created by chdo on 2017/11/7.
//  Copyright © 2017年 chdo002. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSString *str= @"哈速度发货速度回复";
    
    CGFloat BubbleMaxWidth = [UIScreen mainScreen].bounds.size.width;
    
    NSDictionary *attri = @{NSFontAttributeName: [UIFont systemFontOfSize:16]};
    //NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
    // 计算的高度 = boundingRectWithSize计算出来的高度 + \n\r转义字符出现的个数 * 单行文本的高度。
    CGRect rec = [str boundingRectWithSize:CGSizeMake(BubbleMaxWidth, CGFLOAT_MAX) options:NSStringDrawingUsesDeviceMetrics attributes:attri context:nil];
    
//    UILabel *label = [[UILabel alloc] initWithFrame:rec];
    
    //    ceilf
    
    
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
