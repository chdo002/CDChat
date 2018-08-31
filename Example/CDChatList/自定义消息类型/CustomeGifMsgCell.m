//
//  CustomeMsgCell.m
//  CDChatList_Example
//
//  Created by chdo on 2018/8/29.
//  Copyright © 2018年 chdo002. All rights reserved.
//

#import "CustomeGifMsgCell.h"
#import "BaseMsgModel.h"
NSString *const CustomeMsgCellReuseId = @"CustomeMsgCellReuseId";
@implementation CustomeGifMsgCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.gifImageView_left = [[YYAnimatedImageView alloc] init];
    [self.msgContent_left insertSubview:self.gifImageView_left aboveSubview:self.bubbleImage_left];
    
    self.gifImageView_right = [[YYAnimatedImageView alloc] init];
    [self.msgContent_right insertSubview:self.gifImageView_right aboveSubview:self.bubbleImage_right];
    
    return self;
}

-(void)configCellByData:(CDChatMessage)data table:(CDChatListView *)table{
    [super configCellByData:data table:table];
    
    BaseMsgModel *model = (BaseMsgModel *)data;
    
    if (data.isLeft) {
        
        self.gifImageView_left.frame = self.bubbleImage_left.frame;
        if (model.cacheGif) {
            self.gifImageView_left.image = model.cacheGif;
        } else {
            NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:data.msg ofType:@"gif"];
            model.cacheGif = [YYImage imageWithContentsOfFile:filePath];
            self.gifImageView_left.image = model.cacheGif;
        }
        
//        __weak typeof(self) ws = self;
//        [self.gifImageView_left sd_setImageWithURL:[NSURL URLWithString:data.msg] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//
//        }];
        
    } else {
        
        self.gifImageView_right.frame = self.bubbleImage_right.frame;
        if (model.cacheGif) {
            self.gifImageView_right.image = model.cacheGif;
        } else {
            NSString  *filePath = [[NSBundle bundleWithPath:[[NSBundle mainBundle] bundlePath]]pathForResource:data.msg ofType:@"gif"];
            model.cacheGif = [YYImage imageWithContentsOfFile:filePath];
            self.gifImageView_right.image = model.cacheGif;
        }
        
//        __weak typeof(self) ws = self;
//        [self.gifImageView_right sd_setImageWithURL:[NSURL URLWithString:data.msg] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//            // 文件: ani@3x.gif
////            UIImage *image = [YYImage imageNamed:@"ani.gif"];
////            UIImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
//            image = [[YYImage alloc] initWithCGImage:image.CGImage];
//            self.gifImageView_right = [YYAnimatedImageView alloc] initWithImage:image
////            ws.gifImageView_right = [YYImage]
//        }];
        
    }
}


@end
