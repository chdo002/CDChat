//
//  CDAudioTableViewCell.m
//  AATChatList
//
//  Created by chdo on 2018/1/10.
//  Copyright © 2018年 aat. All rights reserved.
//

#import "CDAudioTableViewCell.h"
#import "ChatHelpr.h"
#import "AATUtility.h"

@interface CDAudioTableViewCell()
@property(nonatomic, strong) UIImageView *wave_left;
@property(nonatomic, strong) UIImageView *wave_right;

@property(nonatomic, strong) UIImage *wave_left_image;
@property(nonatomic, strong) UIImage *wave_right_image;
@end

@implementation CDAudioTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self addGestureRecognizer:tap];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNoti:) name:AATAudioToolDidStopPlayNoti object:nil];
    return self;
}

-(UIImage *)wave_left_image{
    if (!_wave_left_image) {
        NSArray *arr =@[[ChatHelpr defaultImageDic][@"voice_left_1"],
                        [ChatHelpr defaultImageDic][@"voice_left_2"],
                        [ChatHelpr defaultImageDic][@"voice_left_3"]];
        _wave_left_image = [UIImage animatedImageWithImages:arr duration:1];
    }
    return _wave_left_image;
}

-(UIImage *)wave_right_image{
    if (!_wave_right_image) {
        NSArray *arr = @[[ChatHelpr defaultImageDic][@"voice_right_1"],
                         [ChatHelpr defaultImageDic][@"voice_right_2"],
                         [ChatHelpr defaultImageDic][@"voice_right_3"]];
        _wave_right_image = [UIImage animatedImageWithImages: arr duration: 1];
    }
    return _wave_right_image;
}

-(UIImageView *)wave_left{
    if (!_wave_left) {
        _wave_left = [[UIImageView alloc] initWithImage:self.wave_left_image.images.lastObject];
        _wave_left.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _wave_left;
}

-(UIImageView *)wave_right{
    if (!_wave_right) {
        _wave_right = [[UIImageView alloc] initWithImage:self.wave_right_image.images.lastObject];
        _wave_right.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _wave_right;
}

-(void)configCellByData:(CDChatMessage)data{
    [super configCellByData:data];
    
    if (data.isLeft) {
        // 左侧
        //     设置消息内容, 并调整UI
        [self configAudio_Left:data];
    } else {
        // 右侧
        //     设置消息内容, 并调整UI
        [self configAudio_Right:data];
    }
}

-(void)configAudio_Left:(CDChatMessage)data{
    [super updateMsgContentFrame_left:data];
    if (!self.wave_left.superview) {
        self.wave_left.frame = CGRectMake(BubbleRoundAnglehorizInset, BubbleRoundAnglehorizInset,
                                          HeadSideLength, HeadSideLength - 2 * BubbleRoundAnglehorizInset);
        [self.bubbleImage_left addSubview:self.wave_left];
    }
}

-(void)configAudio_Right:(CDChatMessage)data {
    
    CGRect bubbleRec = [super updateMsgContentFrame_right:data];
    
    if (!self.wave_right.superview) {
        [self.bubbleImage_right addSubview:self.wave_right];
    }
    self.wave_right.frame = CGRectMake(bubbleRec.size.width - BubbleRoundAnglehorizInset - HeadSideLength,
                                       BubbleRoundAnglehorizInset, HeadSideLength,
                                       HeadSideLength - 2 * BubbleRoundAnglehorizInset);
}

-(void)receiveNoti:(NSNotification *)noti{
    if (noti.name == AATAudioToolDidStopPlayNoti) {
        if (self.msgModal.isLeft) {
            self.wave_left.image = self.wave_left_image.images.lastObject;
        } else {
            self.wave_right.image = self.wave_right_image.images.lastObject;
        }
    }
}

-(void)tapGesture:(UITapGestureRecognizer *)ges{
    CGPoint gesLoca = [ges locationInView:self];
    if (self.msgModal.isLeft) {
        if (CGRectContainsPoint(self.bubbleImage_left.frame, gesLoca)) {
            self.wave_left.image = self.wave_left_image;
            [self playAudio];
        }
    } else {
        if (CGRectContainsPoint(self.bubbleImage_right.frame, gesLoca)) {
            self.wave_right.image = self.wave_right_image;
            [self playAudio];
        }
    }
}

-(void)playAudio{
    if ([[AATAudioTool share] isPlaying]){
        [[AATAudioTool share] stopPlay];
    } else {
        [AATAudioTool share].audioPath = self.msgModal.msg;
        [[AATAudioTool share] play];
    }
}

@end
