//
//  CDBaseMsgCell.h
//  CDChatList
//
//  Created by chdo on 2017/11/2.
//

#import <UIKit/UIKit.h>
#import "CDChatListProtocols.h"

@interface CDBaseMsgCell : UITableViewCell<MessageCellProtocal>

@property(nonatomic,strong) UILabel *timeLabel; //消息时间视图
@property(nonatomic, strong) CDChatMessage msgModal;

// 左侧 消息内容视图
@property(nonatomic,strong) UIView *msgContent_left;                 // 消息载体视图 包括下面三个
@property(nonatomic,strong) UIImageView *bubbleImage_left;           // 气泡视图
@property(nonatomic,strong) UIImageView *headImage_left;             // 头像视图
@property(nonatomic,strong) UIActivityIndicatorView *indicator_left; // loading视图
@property(nonatomic,strong) UILabel *failLabel_left;             // 消息失败转台视图

// 右侧 消息内容视图
@property(nonatomic,strong) UIView *msgContent_right;                 // 消息载体视图 包括下面三个
@property(nonatomic,strong) UIImageView *bubbleImage_right;           // 气泡视图
@property(nonatomic,strong) UIImageView *headImage_right;             // 头像视图
@property(nonatomic,strong) UIActivityIndicatorView *indicator_right; // loading视图
@property(nonatomic,strong) UILabel *failLabel_right;             // 消息失败转台视图
///**
// 根据消息中缓存的消息高度，气泡宽度重新设置msgContent_left的frame
//
// @param data 消息内容
// */
//
//-(CGRect)updateMsgContentFrame_left:(CDChatMessage) data;
//
//
///**
// 根据消息中缓存的消息高度，气泡宽度重新设置msgContent_right的frame
//
// @param data 消息内容
// */
//-(CGRect)updateMsgContentFrame_right:(CDChatMessage) data;

- (void)configCellByData:(CDChatMessage)data table:(CDChatListView *)table;

@end
