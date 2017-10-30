//
//  CDChatList.h
//  CDChatList
//
//  Created by chdo on 2017/10/25.
//

#import <UIKit/UIKit.h>
#import "CDChatListProtocols.h"

@interface CDChatList : UITableView


@property(weak, nonatomic) id<ChatListProtocol> msgDelegate;
@property(nonatomic, copy) CDChatMessageArray msgArr;

/**
 添加新的数据到底部

 @param newBottomMsgArr 新的消息数组
 */
-(void)addMessagesToBottom: (CDChatMessageArray)newBottomMsgArr;

@end
