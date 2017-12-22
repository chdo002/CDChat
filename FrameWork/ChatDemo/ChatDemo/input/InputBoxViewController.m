//
//  InputBoxViewController.m
//  CDChatList_Example
//
//  Created by chdo on 2017/12/8.
//  Copyright © 2017年 chdo002. All rights reserved.
//

#import "InputBoxViewController.h"
#import "CTEmojiKeyboard.h"

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
    [newDic setObject:[UIImage imageNamed:@"emojiDelete"] forKey:@"emojiDelete"];

    [CTinputHelper setDefaultImageDic:newDic]; // 设置除表情的图片资源
    
    input = [[CTInputView alloc] initWithFrame:CGRectMake(0, ScreenH() - CTInputViewHeight, ScreenW(), CTInputViewHeight)];
    [self.view addSubview:input];
    
    
    
    CTEmojiKeyboard * keyboard = [CTEmojiKeyboard keyBoard];
//    keyboard.top = 100;
//    [self.view addSubview:keyboard];
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
