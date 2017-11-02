//
//  CDBaseMsgCell.h
//  CDChatList
//
//  Created by chdo on 2017/11/2.
//

#import <UIKit/UIKit.h>

#import "CDChatMacro.h"
#import "CDChatList.h"


@interface CDBaseMsgCell : UITableViewCell


@property(nonatomic,strong) UILabel *timeLabel; //消息时间视图

@property(nonatomic, strong) id<MessageModalProtocal> msgModal;

@property(nonatomic,strong) UIView *msgContent_left;

@property(nonatomic,strong) UIImageView *bubbleImage;


@property(nonatomic,strong) UIView *msgContent_right;

@end
