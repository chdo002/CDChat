//
//  ChatConfiguration.m
//  CDChatList
//
//  Created by chdo on 2017/12/5.
//

#import "ChatConfiguration.h"
#import "CDChatMacro.h"

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
    
    return self;
}



@end
