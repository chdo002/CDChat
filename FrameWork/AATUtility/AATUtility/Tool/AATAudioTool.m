//
//  AATAudioTool.m
//  AATUtility
//
//  Created by chdo on 2018/1/9.
//  Copyright © 2018年 aat. All rights reserved.
//

#import "AATAudioTool.h"
#import "AATUtility.h"

@interface AATAudioTool()<AVAudioRecorderDelegate, AVAudioPlayerDelegate>
{
    
    NSTimer *_timer; //定时器
    
    NSTimeInterval startTime;
    NSString *filePath;
    
}

@property (nonatomic, strong) NSURL *recordFileUrl; //文件地址

@property (nonatomic, strong) AVAudioRecorder *recorder;//录音器

@property (nonatomic, strong) AVAudioPlayer *player; //播放器
@property (nonatomic, strong) AVAudioSession *session;


@end


@implementation AATAudioTool

+(instancetype)share{
    
    static dispatch_once_t onceToken;
    static AATAudioTool *single;
    
    dispatch_once(&onceToken, ^{
        single = [[AATAudioTool alloc] init];
        single.updateInterval = 0.1;
        [[NSNotificationCenter defaultCenter] addObserver:single selector:@selector(enterBackGround:) name:UIApplicationDidEnterBackgroundNotification object:nil];
    });
    return single;
}


-(AVAudioSession *)session{
    if (!_session){
        
        AVAudioSession *session =[AVAudioSession sharedInstance];
        NSError *err;
        [session setActive:YES error:&err];
        [self handleError:err];
        _session = session;
    }
    return _session;
}

-(void)enterBackGround:(NSNotification *)noti{
    [self stopRecord];
    [self stopPlay];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark ====================================录音====================================

-(BOOL)isRecorderRecording{
    return self.recorder.isRecording;
}
-(AVAudioRecorder *)configRecorder:(NSError **)outError{
    
    _recorder = nil;
    //设置参数
    NSDictionary *recordSetting = [[NSDictionary alloc] initWithObjectsAndKeys:
                                   // 采样率  8000/11025/22050/44100/96000（影响音频的质量）
                                   [NSNumber numberWithFloat: 44100],AVSampleRateKey,
                                   // 音频格式
                                   [NSNumber numberWithInt: kAudioFormatLinearPCM],AVFormatIDKey,
                                   // 采样位数  8、16、24、32 默认为16
                                   [NSNumber numberWithInt:16],AVLinearPCMBitDepthKey,
                                   // 音频通道数 1 或 2
                                   [NSNumber numberWithInt: 1], AVNumberOfChannelsKey,
                                   // 录音质量
                                   [NSNumber numberWithInt:AVAudioQualityHigh],  AVEncoderAudioQualityKey,
                                   nil];
    
    _recorder = [[AVAudioRecorder alloc] initWithURL:self.recordFileUrl settings:recordSetting error:outError];
    _recorder.delegate = self;
    return _recorder;
}

- (void)startRecord {
    
    // 设置session
    NSError *sessionError;
    [self.session setCategory:AVAudioSessionCategoryPlayAndRecord error:&sessionError];
    if ([self handleError:sessionError]){
        return;
    }
    
    // 停止播放/录音
    [self stopPlay];
    
    // 设置文件地址
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    path = NSTemporaryDirectory();
    
    filePath = [path stringByAppendingString:[NSString stringWithFormat:@"%@.wav",[NSString dateTimeStamp]]];
    self.recordFileUrl = [NSURL fileURLWithPath:filePath];
    
    // 配置录音器
    NSError *error;
    [self configRecorder:&error];
    [self handleError:error];
    
    //设置参数
    if (self.recorder) {
        self.recorder.meteringEnabled = YES;
        [self.recorder prepareToRecord];
        [self.recorder record];
        startTime = -1;
        [self addTimer];
    } else {
        [self.delegate aatAudioToolDidStopRecord:nil startTime:0 endTime:0 errorInfo:@"音频格式和文件存储格式不匹配,无法初始化Recorder"];
    }
}


- (void)stopRecord {
    
    [self removeTimer];
    if ([self.recorder isRecording]) {
        [self.recorder stop];
    }
}


/**
 *  添加定时器
 */
- (void)addTimer
{
    _timer = [NSTimer scheduledTimerWithTimeInterval:self.updateInterval target:self selector:@selector(refreshRecord) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

/**
 *  移除定时器
 */
- (void)removeTimer
{
    [_timer invalidate];
    _timer = nil;
}

-(void)refreshRecord {
    if (startTime < 0 && !self.recorder.isRecording) { // 还未开始录音
        NSLog(@"还未开始录音");
        return;
    } else if (startTime < 0 && self.recorder.isRecording) { // 开始录音 记录时间
        NSLog(@"开始录音 记录时间");
        startTime = self.recorder.currentTime;
        [self.delegate aatAudioToolDidStartRecord:startTime];
        return;
    } else if (startTime > 0 && self.recorder.isRecording) { // 录音中
        NSLog(@"录音中");
        NSTimeInterval duration = self.recorder.currentTime - startTime;
        
        if (duration > 60.0) { // 停止录音
            [self stopRecord];
            return;
        }
        
        [self.recorder updateMeters];
        [self.delegate aatAudioToolUpdateCurrentTime:self.recorder.currentTime
                                            fromTime:startTime
                                           peakPower:[self.recorder peakPowerForChannel:0]
                                        averagePower:[self.recorder averagePowerForChannel:0]];
    } else {
        NSLog(@"没有在录音，中断了");
    }
    
}



#pragma mark  ---AVAudioRecorderDelegate---
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag{
    [self.delegate aatAudioToolDidStopRecord:recorder.url startTime:startTime endTime:recorder.currentTime errorInfo:nil];
}

- (void)audioRecorderBeginInterruption:(AVAudioRecorder *)recorder{
    [self.delegate aatAudioToolDidStopRecord:recorder.url startTime:startTime endTime:recorder.currentTime errorInfo:@"被打断了"];

}

-(void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder{
    
}

-(void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder withFlags:(NSUInteger)flags{
    
}

-(void)audioRecorderEndInterruption:(AVAudioRecorder *)recorder withOptions:(NSUInteger)flags{
    
}

- (void)audioRecorderEncodeErrorDidOccur:(AVAudioRecorder *)recorder error:(NSError * __nullable)error{
    [self.delegate aatAudioToolDidStopRecord:recorder.url startTime:startTime endTime:recorder.currentTime errorInfo:error.description];
}



#pragma mark ====================================播放====================================

-(AVAudioPlayer *)player{
    if (!_player) {
        NSError *err;
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordFileUrl error:&err];
        _player.delegate = self;
        [self handleError:err];
    }
    return _player;
}

- (void)play:(NSError **)outError {
    
    [self.session setCategory:AVAudioSessionCategoryPlayback error:outError];
    
    [self.recorder stop];
    
    if ([self.player isPlaying])return;
    
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:self.recordFileUrl error:outError];
    
    self.player.delegate = self;
    
    [self.session setCategory:AVAudioSessionCategoryPlayback error:outError];
    
    [self.player play];
    

}

-(void)stopPlay{
    [self.player stop];
}

#pragma mark public

-(BOOL)handleError:(NSError *)err{
    if (err) {
        [self.delegate aatAudioToolDidStopRecord:nil startTime:0 endTime:0 errorInfo:[NSString stringWithFormat:@"Error creating session: %@",[err description]]];
        [self removeTimer];
        return YES;
    }
    return NO;
}


@end
