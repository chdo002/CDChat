//
//  CDTextTableViewCell.h
//  CDChatList
//
//  Created by chdo on 2017/10/25.
//

#import <UIKit/UIKit.h>
#import "CDChatListProtocols.h"
#import "CDBaseMsgCell.h"


@interface CDTextTableViewCell : CDBaseMsgCell<MessageCellProtocal>

- (void)configCellByData:(id<MessageModalProtocal>)data;
@end
