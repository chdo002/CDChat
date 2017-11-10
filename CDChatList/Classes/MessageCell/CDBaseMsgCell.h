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


#define HeadSideLength  40 // cell中头像边长
#define MessagePadding  10  // 头像内边距
#define MessageContentH (MessagePadding * 2 +  HeadSideLength) // 文字消息内容在只有一行时的高度 不包括时间label 

// 气泡切图cap内边距
#define BubbleSharpAngleHeighInset 25
#define BubbleSharpAnglehorizInset 11
#define BubbleRoundAnglehorizInset 5

#define BubbleMaxWidth scrnW * 0.64 // 气泡最大边长

#define MessageFont  [UIFont systemFontOfSize:16]

@interface CDBaseMsgCell : UITableViewCell


@property(nonatomic,strong) UILabel *timeLabel; //消息时间视图

@property(nonatomic, strong) CDChatMessage msgModal;

// 左侧 消息内容视图
@property(nonatomic,strong) UIView *msgContent_left;
@property(nonatomic,strong) UIImageView *bubbleImage_left;
@property(nonatomic,strong) UIImageView *headImage_left;
@property(nonatomic,strong) UIActivityIndicatorView *indicator_left;

// 右侧 消息内容视图
@property(nonatomic,strong) UIView *msgContent_right;
@property(nonatomic,strong) UIImageView *bubbleImage_right;
@property(nonatomic,strong) UIImageView *headImage_right;
@property(nonatomic,strong) UIActivityIndicatorView *indicator_right;

/**
 根据消息中缓存的消息高度，气泡宽度重新设置msgContent_left的frame

 @param data 消息内容
 */

-(CGRect)updateMsgContentFrame_left:(CDChatMessage) data;



/**
 根据消息中缓存的消息高度，气泡宽度重新设置msgContent_right的frame
 
 @param data 消息内容
 */
-(CGRect)updateMsgContentFrame_right:(CDChatMessage) data;



- (void)configCellByData:(CDChatMessage)data;

@end
