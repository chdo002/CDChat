//
//  ImageDownLoader.m
//  CDChatList
//
//  Created by chdo on 2017/11/8.
//

#import "ImageDownLoader.h"
#import "CDChatListProtocols.h"

@interface ImageDownLoader()
{
    dispatch_queue_t downloadQueue;
}

@property(nonatomic, strong) NSMutableArray<CDChatMessage> *msgs;

@end

@implementation ImageDownLoader

+(void)downloadMessage:(CDChatMessage)mssage {
    
    dispatch_semaphore_t signal = dispatch_semaphore_create(1);
    
    dispatch_time_t overTime = dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC);
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"需要线程同步的操作1 开始");
        sleep(2);
        NSLog(@"需要线程同步的操作1 结束");
        dispatch_semaphore_signal(signal);
    });
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        sleep(1);
        dispatch_semaphore_wait(signal, overTime);
        NSLog(@"需要线程同步的操作2");
        dispatch_semaphore_signal(signal);
    });
    
}

@end
