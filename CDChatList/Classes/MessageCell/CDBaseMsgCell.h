//
//  CDBaseMsgCell.h
//  CDChatList
//
//  Created by chdo on 2017/11/2.
//

#import <UIKit/UIKit.h>

#import "CDChatMacro.h"
#import "CDChatList.h"


// cell

#define MsgBackGroundColor CRMHexColor(0x9E7777) // cell背景色


#define HeadSideLength  40 // 头像边长
#define MessagePadding  10  // 头像内边距
#define MessageContentH (MessagePadding * 2 +  HeadSideLength) // 文字消息内容在只有一行时的高度 不包括时间label 


#define BubbleMaxWidth scrnW * 0.64 // 气泡最大边长

@interface CDBaseMsgCell : UITableViewCell


@property(nonatomic,strong) UILabel *timeLabel; //消息时间视图

@property(nonatomic, strong) id<MessageModalProtocal> msgModal;

// 左侧 消息内容视图
@property(nonatomic,strong) UIView *msgContent_left;
@property(nonatomic,strong) UIImageView *bubbleImage_left;
@property(nonatomic,strong) UIImageView *headImage_left;

// 右侧 消息内容视图
@property(nonatomic,strong) UIView *msgContent_right;
@property(nonatomic,strong) UIImageView *bubbleImage_right;
@property(nonatomic,strong) UIImageView *headImage_right;



@end
