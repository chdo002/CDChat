//
//  PAIMApiRecordVoice.h
//  PAIM_Demo
//
//  Created by linshengqin on 15/7/16.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol PAIMApiVoiceDelegate <NSObject>

/*!
 * 录音结束回调
 *  @param filePath  文件路径
 *  @param interval  录音时长
 */
- (void)recordingFinishedWithFileName:(NSString *)filePath time:(NSTimeInterval)interval;

/*!
 * 录音超时回调
 */
- (void)recordingTimeout;

/*!
 * 录音超时回调
 */
- (void)recordingStopped;

/*!
 * 停止录音回调
 */
- (void)recordingFailed:(NSString *)failureInfoString;

/*!
 * 停止播放录音回调
 */
- (void)playingStoped;

@optional

/*!
 * 录音音量变化回调
 */
- (void)levelMeterChanged:(float)levelMeter;

@end

@interface PAIMApiVoice : NSObject 

@property(nonatomic,assign) id<PAIMApiVoiceDelegate> delegate;
@property (nonatomic, strong) NSString *currentPath;

/*!
 * 开始录音
 */
-(void)startRecordVoice;

/*!
 * 取消录音
 */
-(void)cancelRecordVoice;

/*!
 * 结束录音
 */
-(void)endRecordVoice;

/*!
 * 播放多媒体文件
 */
- (void)playAudioWithFileName:(NSString *)filename;

/*!
 * 停止播放多媒体文件
 */
- (void)stopPlaying;

@end
