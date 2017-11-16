//
//  CDChatList.h
//  CDChatList
//
//  Created by chdo on 2017/10/25.
//

#import <UIKit/UIKit.h>
#import "CDChatListProtocols.h"

/**
 聊天列表视图
 */
@interface CDChatList : UITableView

@property(weak, nonatomic) UIViewController *viewController;
@property(weak, nonatomic) id<ChatListProtocol> msgDelegate;
@property(nonatomic, copy) CDChatMessageArray msgArr;

/**
 添加新的数据到底部

 @param newBottomMsgArr 新的消息数组
 */
-(void)addMessagesToBottom: (CDChatMessageArray)newBottomMsgArr;

/**
 更新数据源中的某条消息

 @param message 消息
 */
-(void)updateMessage:(CDChatMessage)message;

@end
