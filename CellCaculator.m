//
//  CellCaculator.m
//  CDChatList
//
//  Created by chdo on 2017/10/26.
//

#import "CellCaculator.h"
@interface CellCaculator()
{
    dispatch_queue_t caculatQueue;
}

@end
@implementation CellCaculator

+(CellCaculator *)shareInstance{
    static CellCaculator *caculator = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        caculator = [[CellCaculator alloc]init];
        caculator->caculatQueue = dispatch_queue_create("calqueue", DISPATCH_QUEUE_CONCURRENT);
    });
    return caculator;
}

+(CGFloat)fetchCellHeight:(id<MessageModalProtocal>)data{
    
    if (data.cellHeight) {
        return data.cellHeight;
    }
    
    CGFloat height = [[CellCaculator shareInstance] caculateCellHeight:data];
    data.cellHeight = height;
    return height;
}

/**
 针对不同的cell，计算cell高度
 
 @param data 消息模型
 @return cell高度
 */
-(CGFloat)caculateCellHeight:(id<MessageModalProtocal>)data{
    
    // ..
    return 50.f;
}

@end
