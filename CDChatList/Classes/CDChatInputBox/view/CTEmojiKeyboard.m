//
//  CTEmojiKeyboard.m
//  CDChatList
//
//  Created by chdo on 2017/12/15.
//

#import "CTEmojiKeyboard.h"
#import <Utility/Utility.h>
@interface CTEmojiKeyboard()
{
    UIScrollView *scrollView;
}
@end
@implementation CTEmojiKeyboard

+(instancetype)share{
    
    static dispatch_once_t onceToken;
    static CTEmojiKeyboard *single;
    
    dispatch_once(&onceToken, ^{
        single = [[CTEmojiKeyboard alloc] init];
        single.backgroundColor = [UIColor cyanColor];
        single.frame = CGRectMake(0, 0, ScreenW(), ScreenH() * 0.4);
        single->scrollView = [[UIScrollView alloc] initWithFrame:single.bounds];
        
    });
    return single;
}

+(CTEmojiKeyboard *)keyBoard{
    return [CTEmojiKeyboard share];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}

@end
