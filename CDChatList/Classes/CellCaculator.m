//
//  CellCaculator.m
//  CDChatList
//
//  Created by chdo on 2017/10/26.
//

#import "CellCaculator.h"
#import "CDChatMacro.h"

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
        // 计算所有cell高度的队列
        caculator->caculatQueue = dispatch_queue_create("calqueue", DISPATCH_QUEUE_CONCURRENT);
        
    });
    return caculator;
}

+(void)caculatorAllCellHeight: (CDChatMessageArray)msgArr
         callBackOnMainThread: (void(^)(CGFloat))completeBlock{
    
    dispatch_group_t group = dispatch_group_create();
    
    dispatch_queue_t caculatorQueue = [CellCaculator shareInstance]->caculatQueue;

    for (CDChatMessage msg in msgArr) {
        dispatch_group_async(group, caculatorQueue, ^{
           msg.cellHeight = [self fetchCellHeight:msg];
           
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        CGFloat totalHeight = 0.0f;
        for (CDChatMessage msg in msgArr) {
            totalHeight = totalHeight + msg.cellHeight;
        }
        completeBlock(totalHeight);
    });
}

//TODO: 获取cell的高度方式
+(CGFloat)fetchCellHeight:(CDChatMessage)data{
    // 返回缓存中的高度
    if (data.cellHeight) {
        return data.cellHeight;
    }
    
//     计算高度
    CGFloat height = [self caculateCellHeight:data];
    data.cellHeight = height;
    return height;
}

/**
 针对不同的cell，计算cell高度
 
 @param data 消息模型
 @return cell高度
 */
+(CGFloat)caculateCellHeight:(CDChatMessage)data{
    return 50;
//    CGFloat rand = (CGFloat)arc4random_uniform(15);
//    // ..
//    return 50.f + rand;
}

@end





