//
//  CDChatList.h
//  CDChatList
//
//  Created by chdo on 2017/10/25.
//

#import <UIKit/UIKit.h>
#import "CDChatListProtocols.h"

@interface CDChatList : UITableView

@property(nonatomic, copy) NSArray<id<MessageModalProtocal>>* msgArr;

@end
