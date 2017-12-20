//
//  CTEmojiKeyboard.m
//  CDChatList
//
//  Created by chdo on 2017/12/15.
//

#import "CTEmojiKeyboard.h"
#import <AATUtility/AATUtility.h>

@interface CTEmojiKeyboard()
{
    UIScrollView *scrollView;
    UIPageControl *pageCtr;
    
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
        single->scrollView = [[UIScrollView alloc] init];
        [single addSubview:single->scrollView];
        
        UIPageControl *page = [[UIPageControl alloc] init];
        [single addSubview:page];
    });
    return single;
}

+(CTEmojiKeyboard *)keyBoard{
    
    [[CTEmojiKeyboard share] updateKeyBoard];
    return [CTEmojiKeyboard share];
}

-(void)updateKeyBoard{
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}

@end
