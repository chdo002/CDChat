//
//  InputBoxViewController.m
//  CDChatList_Example
//
//  Created by chdo on 2017/12/8.
//  Copyright © 2017年 chdo002. All rights reserved.
//

#import "InputBoxViewController.h"
#import "CTInputView.h"
@interface InputBoxViewController ()<UITextViewDelegate>
{
    CTInputView *input;
}
@property (nonatomic, strong) UITextView *textView;

@end

@implementation InputBoxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSDictionary *origin = [CTinputHelper defaultImageDic];
    
    NSMutableDictionary *newDic = [NSMutableDictionary dictionaryWithDictionary:origin];
    [newDic setObject:[UIImage imageNamed:@"keyboard"] forKey:@"keyboard"];
    [newDic setObject:[UIImage imageNamed:@"voice"] forKey:@"voice"];

    [CTinputHelper setDefaultImageDic:newDic];
    
    input = [[CTInputView alloc] initWithFrame:CGRectMake(0, ScreenH() - CTInputViewHeight, ScreenW(), CTInputViewHeight)];
    [self.view addSubview:input];
}

-(void)viewDidDisappear:(BOOL)animated{
    input = nil;
}

- (IBAction)becomeFirst:(id)sender {
    [input becomeFirstResponder];
}

- (IBAction)resigFitrst:(id)sender {
    [input resignFirstResponder];
}

-(void)send{

}

@end
