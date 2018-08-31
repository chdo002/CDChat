//
//  CustomeMsgCell.m
//  CDChatList_Example
//
//  Created by chdo on 2018/8/29.
//  Copyright © 2018年 chdo002. All rights reserved.
//

#import "CustomeGifMsgCell.h"
NSString *const CustomeMsgCellReuseId = @"CustomeMsgCellReuseId";
@implementation CustomeGifMsgCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.gifImageView_left = [[FLAnimatedImageView alloc] init];
    [self.msgContent_left insertSubview:self.gifImageView_left aboveSubview:self.bubbleImage_left];
    
    self.gifImageView_right = [[FLAnimatedImageView alloc] init];
    [self.msgContent_right insertSubview:self.gifImageView_right aboveSubview:self.bubbleImage_right];
    
    return self;
}

-(void)configCellByData:(CDChatMessage)data table:(CDChatListView *)table{
    [super configCellByData:data table:table];
    if (data.isLeft) {
//        CGRect textRect = self.gifImageView_left.frame;
//        textRect.origin = CGPointMake(data.chatConfig.bubbleRoundAnglehorizInset + data.chatConfig.bubbleShareAngleWidth, data.chatConfig.bubbleRoundAnglehorizInset);
//        textRect.size = data.textlayout.contents.size;
        self.gifImageView_left.frame = self.bubbleImage_left.frame;
        [self.gifImageView_left sd_setImageWithURL:[NSURL URLWithString:data.msg] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

        }];

    } else {

//        CGRect textRect = self.gifImageView_right.frame;
//        textRect.origin = CGPointMake(data.chatConfig.bubbleRoundAnglehorizInset, data.chatConfig.bubbleRoundAnglehorizInset);
//        textRect.size = data.textlayout.contents.size;
        self.gifImageView_right.frame = self.bubbleImage_right.frame;
        [self.gifImageView_right sd_setImageWithURL:[NSURL URLWithString:data.msg] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

        }];
    }
}


@end
