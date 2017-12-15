//
//  CDMessageModal.m
//  CDChatList_Example
//
//  Created by chdo on 2017/10/26.
//  Copyright © 2017年 chdo002. All rights reserved.
//

#import "CDMessageModal.h"

@implementation CDMessageModal

@synthesize msg;

@synthesize msgType;

@synthesize messageId;

@synthesize createTime;

@synthesize isLeft;

@synthesize modalInfo;

@synthesize willDisplayTime;

@synthesize msgState;

// 缓存字段 不需要赋值
@synthesize bubbleWidth;

@synthesize cellHeight;

@synthesize textlayout;

+(CDMessageModal *)initWithDic:(NSDictionary *)dic {
    
    CDMessageModal*modal = [[CDMessageModal alloc] init];
    modal.msg = dic[@"msg"];
    modal.messageId = dic[@"messageId"];
    modal.createTime = dic[@"createTime"];
    modal.msgType = [dic[@"msgType"] integerValue];
    modal.msgState = [dic[@"msgState"] integerValue];
    modal.isLeft = [dic[@"isLeft"] integerValue];
    
    
    
    return modal;
}

@synthesize userThumImage;

@synthesize userThumImageURL;

@end
