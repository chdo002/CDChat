//
//  ChatConfiguration.m
//  CDChatList
//
//  Created by chdo on 2017/12/5.
//

#import "ChatConfiguration.h"
#import "ChatHelpr.h"
#import "UITool.h"

@implementation ChatConfiguration

-(instancetype)init{
    
    self = [super init];
    
    self.environment = 1;
    
    self.msgBackGroundColor = CRMHexColor(0xF3F3F3);
    self.msgContentBackGroundColor = self.msgBackGroundColor;
    self.headBackGroundColor = self.msgBackGroundColor;
    self.msgTextContentBackGroundColor_left = CRMHexColor(0xFFFFFF);
    self.msgTextContentBackGroundColor_right = CRMHexColor(0xA0E75A);
    
    self.msgTimeH = 25.0f;
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
    
    config = [CTData defaultConfig];
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

-(UIColor *)msgTextContentBackGroundColor_left{
    if ([self isDebug]) {
        return [UIColor redColor];
    } else {
        return _msgTextContentBackGroundColor_left;
    }
}

-(UIColor *)msgTextContentBackGroundColor_right{
    if ([self isDebug]) {
        return [UIColor redColor];
    } else {
        return _msgTextContentBackGroundColor_right;
    }
}

-(CGFloat)messageContentH{
    return self.messageMargin * 2 +  self.headSideLength;
}

-(CGFloat)bubbleSharpAnglehorizInset{
    return self.bubbleRoundAnglehorizInset + self.bubbleShareAngleWidth;
}

@end
