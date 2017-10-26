//
//  MessageModal.m
//  CDChatList
//
//  Created by chdo on 2017/10/25.
//

#import "MessageModal.h"

@implementation MessageModal


@synthesize msgType;

@synthesize createTime;

@synthesize messageId;

@synthesize msg;

-(instancetype)init{
    if (!self) {
        self = [super init];
    }
    return self;
}

@end
