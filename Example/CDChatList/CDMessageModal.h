//
//  CDMessageModal.h
//  CDChatList_Example
//
//  Created by chdo on 2017/10/26.
//  Copyright © 2017年 chdo002. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CDChatList/CDChatList.h>


@interface CDMessageModal : NSObject<MessageModalProtocal>

+(CDMessageModal *)initWithDic:(NSDictionary *)dic;


@end
