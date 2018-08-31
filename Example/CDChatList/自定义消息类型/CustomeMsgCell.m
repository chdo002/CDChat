//
//  CustomeMsgCell.m
//  CDChatList_Example
//
//  Created by chdo on 2018/8/29.
//  Copyright © 2018年 chdo002. All rights reserved.
//

#import "CustomeMsgCell.h"
NSString *const CustomeMsgCellReuseId = @"CustomeMsgCellReuseId";
@implementation CustomeMsgCell

-(void)configCellByData:(CDChatMessage)data table:(CDChatListView *)table{
    [super configCellByData:data table:table];
    if (data.isLeft) {
        
    } else {
        
    }
}


@end
