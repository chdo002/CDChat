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

#define MsgBackGroundColor (isChatListDebug ? CRMHexColor(0xB5E7E1) : CRMHexColor(0xEBEBEB))           // cell背景色
#define MsgContentBackGroundColor (isChatListDebug ? CRMHexColor(0x9E7777) : CRMHexColor(0xEBEBEB))       // 消息容器背景色
#define HeadBackGroundColor (isChatListDebug ? [UIColor redColor] : CRMHexColor(0xEBEBEB))             // 头像背景色
#define MsgTextContentBackGroundColor (isChatListDebug ? [UIColor redColor] : CRMHexColor(0xF5F5F5))       // 文字背景色

#define HeadSideLength  40 // 头像边长
#define MessageMargin  10  // 头像外边距
#define MessageContentH (MessageMargin * 2 +  HeadSideLength) // 文字消息内容在只有一行时的高度 不包括时间label 

// 气泡切图cap内边距
#define BubbleRoundAnglehorizInset 10  // 气泡圆角半径
#define BubbleShareAngleWidth  6      // 气泡尖角宽度
#define BubbleSharpAnglehorizInset (BubbleRoundAnglehorizInset + BubbleShareAngleWidth) //尖角外部到圆角内部的距离 
#define BubbleSharpAngleHeighInset 25  // 气泡顶部到尖角底部的距离

#define BubbleMaxWidth scrnW * 0.64 // 气泡最大边长   从尖角到另一边

#define MessageFont  [UIFont systemFontOfSize:16]

#define SysInfoMessageFont  [UIFont systemFontOfSize:14]
#define SysInfoPadding  8

@interface CDBaseMsgCell : UITableViewCell<MessageCellProtocal>


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


@end
