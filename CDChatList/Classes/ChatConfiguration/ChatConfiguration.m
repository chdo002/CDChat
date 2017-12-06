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
    
    self.sysInfoMessageMaxWidth = scrnW * 0.64f;
    self.headSideLength = 40.0f;
    self.messageContentH = self.messageMargin * 2 +  self.headSideLength;
    self.sysInfoPadding = 8.0f;
    
    self.bubbleRoundAnglehorizInset = 10.0f;
    self.bubbleShareAngleWidth = 6.0f;
    self.messageMargin = 10.0f;
    self.bubbleMaxWidth = scrnW * 0.64f;
    self.bubbleSharpAnglehorizInset = self.bubbleRoundAnglehorizInset + self.bubbleShareAngleWidth;
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

@end
