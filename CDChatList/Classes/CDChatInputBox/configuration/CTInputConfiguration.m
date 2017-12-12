//
//  CTInputConfiguration.m
//  CDChatList
//
//  Created by chdo on 2017/12/12.
//

#import "CTInputConfiguration.h"

@interface CTInputConfiguration()
{
    
    BOOL hasVoice;
    BOOL hasEmoji;
    BOOL hasMore;
    CGFloat inset; // 内边距
    CGSize buttongSize; // 按钮大小
    CGFloat CTInputViewWidth;
    //CTInputViewHeight
}
@end

@implementation CTInputConfiguration


+(instancetype)share{
    
    static dispatch_once_t onceToken;
    static CTInputConfiguration *helper;
    dispatch_once(&onceToken, ^{
        helper = [[CTInputConfiguration alloc] init];
    });
    return helper;
}

-(instancetype)init{
    self = [super init];
    inset = 7.0f;
    hasVoice = NO;
    hasEmoji = NO;;
    hasMore = NO;;
    buttongSize = CGSizeMake(30, 30);
    CTInputViewWidth = ScreenW();
    return self;
}

// 输入框配置
+(CTInputConfiguration*)defaultConfig{
    return [CTInputConfiguration share];
}


-(CGRect)inputViewRect{
    
    CGFloat top = inset;
    CGFloat left = hasVoice ? inset * 2 + buttongSize.width : inset;
    CGFloat bottom = inset;
    CGFloat right = inset + (hasEmoji ? buttongSize.width + inset : 0) + + (hasMore ? buttongSize.width + inset : 0);
    
    return CGRectMake(left, top, CTInputViewWidth - left - right, CTInputViewHeight - top - bottom);
}

// 添加输入语音功能
-(void)addVoice{
    hasVoice = YES;
}

// 添加输入表情功能
-(void)addEmoji{
    hasEmoji = YES;
}

// 添加更多功能
-(void)addExtra:(NSDictionary *)info{
    
    if (!info) return;
    
    hasMore = YES;
}

@end
