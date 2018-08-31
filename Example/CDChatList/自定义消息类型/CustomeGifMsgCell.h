//
//  CustomeMsgCell.h
//  CDChatList_Example
//
//  Created by chdo on 2018/8/29.
//  Copyright © 2018年 chdo002. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDBaseMsgCell.h"
#import <YYImage/YYImage.h>
#import "FLAnimatedImageView+WebCache.h"

extern NSString *const CustomeMsgCellReuseId;

// 自定义Gif类型的消息
@interface CustomeGifMsgCell : CDBaseMsgCell
@property(nonatomic, strong) YYAnimatedImageView *gifImageView_left;
@property(nonatomic, strong) YYAnimatedImageView *gifImageView_right;
@end
