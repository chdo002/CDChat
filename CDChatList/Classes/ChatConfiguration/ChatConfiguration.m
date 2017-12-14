//
//  ChatConfiguration.m
//  CDChatList
//
//  Created by chdo on 2017/12/5.
//

#import "ChatConfiguration.h"
#import "ChatHelpr.h"

@implementation ChatConfiguration

-(instancetype)init{
    
    self = [super init];
    
    self.environment = 1;
    
    self.msgBackGroundColor = CRMHexColor(0xEBEBEB);
    self.msgContentBackGroundColor = CRMHexColor(0xEBEBEB);
    self.headBackGroundColor = CRMHexColor(0xEBEBEB);
    self.msgTextContentBackGroundColor = CRMHexColor(0xF5F5F5);
    
    self.msgTimeH = 30.0f;
    self.sysInfoMessageMaxWidth = ScreenW() * 0.64f;
    self.headSideLength = 40.0f;
    self.sysInfoPadding = 8.0f;
    
    self.bubbleRoundAnglehorizInset = 10.0f;
    self.bubbleShareAngleWidth = 6.0f;
    self.messageMargin = 10.0f;
    self.bubbleMaxWidth = ScreenW() * 0.64f;
    self.bubbleSharpAngleHeighInset = 25.0f;
    
    self.messageTextDefaultFontSize = 16;
    self.messageTextDefaultFont = [UIFont systemFontOfSize: self.messageTextDefaultFontSize];
    self.sysInfoMessageFont = [UIFont systemFontOfSize:14];
    
    CTDataConfig config;
    config.textColor = [UIColor blackColor].CGColor;
    config.hilightColor = [UIColor lightGrayColor].CGColor;
    config.clickStrColor = [UIColor blueColor].CGColor;
    config.lineSpace = 2;
    config.textSize = 16;
    config.lineBreakMode = NSLineBreakByCharWrapping;
    config.matchLink = YES;
    config.matchEmail = YES;
    config.matchEmoji = YES;
    config.matchPhone = YES;
    self.ctDataconfig = config;
    
    return self;
}

-(BOOL)isDebug{
    return self.environment == 0;
}

// 颜色

-(UIColor *)msgBackGroundColor{
    if ([self isDebug]) {
        return CRMHexColor(0xB5E7E1);
    } else {
        return _msgBackGroundColor;
    }
}

-(UIColor *)msgContentBackGroundColor{
    if ([self isDebug]) {
        return CRMHexColor(0x9E7777);
    } else {
        return _msgContentBackGroundColor;
    }
}

-(UIColor *)headBackGroundColor {
    if ([self isDebug]) {
        return [UIColor redColor];
    } else {
        return _headBackGroundColor;
    }
}

-(UIColor *)msgTextContentBackGroundColor{
    if ([self isDebug]) {
        return [UIColor redColor];
    } else {
        return _msgTextContentBackGroundColor;
    }
}

-(CGFloat)messageContentH{
    return self.messageMargin * 2 +  self.headSideLength;
}

-(CGFloat)bubbleSharpAnglehorizInset{
    return self.bubbleRoundAnglehorizInset + self.bubbleShareAngleWidth;
}

@end
