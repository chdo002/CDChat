//
//  CDAudioTableViewCell.m
//  AATChatList
//
//  Created by chdo on 2018/1/10.
//  Copyright © 2018年 aat. All rights reserved.
//

#import "CDAudioTableViewCell.h"
#import "ChatHelpr.h"
#import "AATAudioTool.h"
@interface CDAudioTableViewCell()

@property(nonatomic, strong) UIImageView *wave_left; // 声波图片
@property(nonatomic, strong) UILabel *audioTimeLabel_left; // 显示音频时间
@property(nonatomic, strong) UIImageView *wave_right; //
@property(nonatomic, strong) UILabel *audioTimeLabel_right; //

@property(nonatomic, strong) UIImage *wave_left_image; // GIF图
@property(nonatomic, strong) UIImage *wave_right_image; // GIF图

@property(nonatomic, strong) UIGestureRecognizer *longPressRecognizer;
@end

@implementation CDAudioTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    [self.bubbleImage_left addGestureRecognizer:tap];
    [self.bubbleImage_right addGestureRecognizer:tap2];
    self.bubbleImage_right.userInteractionEnabled = YES;
    self.bubbleImage_left.userInteractionEnabled = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNoti:) name:AATAudioToolDidStopPlayNoti object:nil];
    _longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressGes:)];
    [self addGestureRecognizer:_longPressRecognizer];
    return self;
}

-(UIImage *)wave_left_image{
    if (!_wave_left_image) {
        
        NSArray *arr =@[ChatHelpr.share.imageDic[ChatHelpr.share.config.voice_left_1],
                        ChatHelpr.share.imageDic[ChatHelpr.share.config.voice_left_2],
                        ChatHelpr.share.imageDic[ChatHelpr.share.config.voice_left_3]];
        _wave_left_image = [UIImage animatedImageWithImages:arr duration:1];
    }
    return _wave_left_image;
}

-(UIImage *)wave_right_image{
    if (!_wave_right_image) {
        NSArray *arr = @[ChatHelpr.share.imageDic[ChatHelpr.share.config.voice_right_1],
                         ChatHelpr.share.imageDic[ChatHelpr.share.config.voice_right_2],
                         ChatHelpr.share.imageDic[ChatHelpr.share.config.voice_right_3]];
        _wave_right_image = [UIImage animatedImageWithImages: arr duration: 1];
    }
    return _wave_right_image;
}

-(UILabel *)audioTimeLabel_left{
    if (!_audioTimeLabel_left) {
        _audioTimeLabel_left = [[UILabel alloc] init];
        _audioTimeLabel_left.textColor = [UIColor lightGrayColor];
        _audioTimeLabel_left.textAlignment = NSTextAlignmentCenter;
        _audioTimeLabel_left.font = [UIFont systemFontOfSize:12];
        _audioTimeLabel_left.textAlignment = NSTextAlignmentRight;
    }
    return _audioTimeLabel_left;
}

-(UILabel *)audioTimeLabel_right{
    if (!_audioTimeLabel_right) {
        _audioTimeLabel_right = [[UILabel alloc] init];
        _audioTimeLabel_right.textColor = [UIColor lightGrayColor];
        _audioTimeLabel_right.textAlignment = NSTextAlignmentCenter;
        _audioTimeLabel_right.font = [UIFont systemFontOfSize:12];
        _audioTimeLabel_right.textAlignment = NSTextAlignmentLeft;
    }
    return _audioTimeLabel_right;
}

-(UIImageView *)wave_left{
    if (!_wave_left) {
        _wave_left = [[UIImageView alloc] initWithImage:self.wave_left_image.images.lastObject];
        _wave_left.animationImages = self.wave_left_image.images;
        _wave_left.animationDuration = 1;
        _wave_left.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _wave_left;
}

-(UIImageView *)wave_right{
    if (!_wave_right) {
        _wave_right = [[UIImageView alloc] initWithImage:self.wave_right_image.images.lastObject];
        _wave_right.animationImages = self.wave_right_image.images;
        _wave_right.animationDuration = 1;
        _wave_right.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _wave_right;
}

-(void)configCellByData:(CDChatMessage)data table:(CDChatListView *)table{
    [super configCellByData:data table:table];
    
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
    
    if (!self.wave_left.superview) {
        self.wave_left.frame = CGRectMake(data.chatConfig.bubbleRoundAnglehorizInset,
                                          data.chatConfig.bubbleRoundAnglehorizInset,
                                          data.chatConfig.headSideLength,
                                          data.chatConfig.headSideLength - 2 * data.chatConfig.bubbleRoundAnglehorizInset);
        [self.bubbleImage_left addSubview:self.wave_left];
    }
    
    self.audioTimeLabel_left.frame = self.indicator_left.frame;
    CGRect fra = self.audioTimeLabel_left.frame;
    fra.size.width = 50;
    self.audioTimeLabel_left.frame = fra;
    if (!self.audioTimeLabel_left.superview) {
        [self.msgContent_left addSubview:self.audioTimeLabel_left];
    }
    
    if ([[AATAudioTool share].audioPath isEqualToString: self.msgModal.msg] && [[AATAudioTool share] isPlaying]) {
        [self.wave_left startAnimating];
    } else {
        [self.wave_left stopAnimating];
    }
    
    if (data.msgState == CDMessageStateNormal) {
        self.audioTimeLabel_left.text = [NSString stringWithFormat:@"%d’’",data.audioTime];
        [self.audioTimeLabel_left setHidden: NO];
    } else if (data.msgState == CDMessageStateSending) {
        [self.audioTimeLabel_left setHidden: YES];
    } else if (data.msgState == CDMessageStateSendFaild || data.msgState == CDMessageStateDownloadFaild) {
        [self.audioTimeLabel_left setHidden: YES];
    } else if (data.msgState == CDMessageStateDownloading) {
        [self.audioTimeLabel_left setHidden: YES];
    }
}

-(void)configAudio_Right:(CDChatMessage)data {
    if (!self.wave_right.superview) {
        [self.bubbleImage_right addSubview:self.wave_right];
    }
    self.wave_right.frame = CGRectMake(self.bubbleImage_right.frame.size.width - data.chatConfig.bubbleRoundAnglehorizInset - data.chatConfig.headSideLength,
                                       data.chatConfig.bubbleRoundAnglehorizInset,
                                       data.chatConfig.headSideLength,
                                       data.chatConfig.headSideLength - 2 * data.chatConfig.bubbleRoundAnglehorizInset);
    
    self.audioTimeLabel_right.frame = self.indicator_right.frame;
    CGRect fra = self.audioTimeLabel_right.frame;
    fra.size.width = 50;
    self.audioTimeLabel_right.frame = fra;
    if (!self.audioTimeLabel_right.superview) {
        [self.msgContent_right addSubview:self.audioTimeLabel_right];
    }
    
    if ([[AATAudioTool share].audioPath isEqualToString: self.msgModal.msg] && [[AATAudioTool share] isPlaying]) {
        [self.wave_right startAnimating];
    } else {
        [self.wave_right stopAnimating];
    }
    
    if (data.msgState == CDMessageStateNormal) {
        self.audioTimeLabel_right.text = [NSString stringWithFormat:@"%d’’",data.audioTime];
        [self.audioTimeLabel_right setHidden: NO];
    } else if (data.msgState == CDMessageStateSending) {
        [self.audioTimeLabel_right setHidden: YES];
    } else if (data.msgState == CDMessageStateSendFaild || data.msgState == CDMessageStateDownloadFaild) {
        [self.audioTimeLabel_right setHidden: YES];
    } else if (data.msgState == CDMessageStateDownloading) {
        [self.audioTimeLabel_right setHidden: YES];
    }
}

-(void)receiveNoti:(NSNotification *)noti{
    if (noti.name == AATAudioToolDidStopPlayNoti) {
        NSString *path = noti.object;
        if ([path isEqualToString:self.msgModal.msg]) {
            if (self.msgModal.isLeft) {
                [self.wave_left stopAnimating];
            } else {
                [self.wave_right stopAnimating];
            }
        }
    }
}

-(void)longPressGes:(UILongPressGestureRecognizer *)recognizer{
    
    CGPoint curPoint = [recognizer locationInView:self];
    if (!CGRectContainsPoint(self.bounds, curPoint)){
        return;
    }
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            //            [self showMenu];
//            [NSNotificationCenter.defaultCenter postNotificationName:CHATLISTLONGPRESS object:self];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            //            self.magnifierView.touchPoint = curPoint;
        }
            break;
        default:
        {
            //            [self.magnifierView removeFromSuperview];
        }
            break;
    }
}

-(void)tapGesture:(UITapGestureRecognizer *)ges{
    
    if ([[AATAudioTool share].audioPath isEqualToString:self.msgModal.msg]) {
        if ([[AATAudioTool share] isPlaying]){
            [[AATAudioTool share] stopPlay];
            
            if (self.msgModal.isLeft) {
                [self.wave_left stopAnimating];
            } else {
                [self.wave_right  stopAnimating];
            }
        } else {
            [AATAudioTool share].audioPath = self.msgModal.msg;
            [[AATAudioTool share] play];
            
            if (self.msgModal.isLeft) {
                [self.wave_left startAnimating];
            } else {
                [self.wave_right startAnimating];
            }
        }
    } else {
        [[AATAudioTool share] stopPlay];
        [AATAudioTool share].audioPath = self.msgModal.msg;
        [[AATAudioTool share] play];
        
        
        if (self.msgModal.isLeft) {
            [self.wave_left startAnimating];
        } else {
            [self.wave_right startAnimating];
        }
    }
}

@end
