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



@end

/*
 https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511244324&di=c4b1f6c40bbb36959095b8a2ff8341d7&imgtype=jpg&er=1&src=http%3A%2F%2Fimg2.niutuku.com%2Fdesk%2F1208%2F2027%2Fntk-2027-16107.jpg
 
 41.25
 */
