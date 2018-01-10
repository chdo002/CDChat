//
//  AATAudioTool.h
//  AATUtility
//
//  Created by chdo on 2018/1/9.
//  Copyright © 2018年 aat. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>

//Privacy - Microphone Usage Description

@protocol AATAudioToolProtocol

// 开始录音
-(void)aatAudioToolDidStartRecord:(NSTimeInterval)currentTime;

// 录音时，更新
-(void)aatAudioToolUpdateCurrentTime:(NSTimeInterval)currentTime
                            fromTime:(NSTimeInterval)startTime
                           peakPower:(float)peak
                        averagePower:(float)averagePower;

// 停止录音
-(void)aatAudioToolDidStopRecord:(NSURL *)dataPath
                       startTime:(NSTimeInterval)start
                         endTime:(NSTimeInterval)end
                       errorInfo:(NSString *)info;


@end

@interface AATAudioTool : NSObject

@property (weak) id<AATAudioToolProtocol>delegate;

@property NSTimeInterval updateInterval;
@property BOOL isRecorderRecording;

+(instancetype)share;

- (void)startRecord;
- (void)stopRecord;
@end

