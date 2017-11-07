//
//  CDMessageModal.m
//  CDChatList_Example
//
//  Created by chdo on 2017/10/26.
//  Copyright © 2017年 chdo002. All rights reserved.
//

#import "CDMessageModal.h"
#import <CDChatList/CDChatList.h>

@implementation CDMessageModal

@synthesize msg;

@synthesize msgType;

@synthesize messageId;

@synthesize createTime;

@synthesize cellHeight;

@synthesize modalInfo;

@synthesize willDisplayTime;

@synthesize bubbleWidth;

@synthesize msgState;


+(CDMessageModal *)initWithDic:(NSDictionary *)dic {
    
    CDMessageModal*modal = [[CDMessageModal alloc] init];
    
    modal.msg = dic[@"msg"];
    modal.messageId = dic[@"messageId"];
    modal.createTime = dic[@"createTime"];
    modal.msgType = [dic[@"msgType"] integerValue];
    modal.msgState = [dic[@"msgState"] integerValue];
    
    
    return modal;
}

@end
