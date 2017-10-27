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
    NSDateFormatter *dateFormatter;
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
        
        caculator->dateFormatter = [[NSDateFormatter alloc] init];
        [caculator->dateFormatter setDateStyle:NSDateFormatterMediumStyle];
        [caculator->dateFormatter setTimeStyle:NSDateFormatterShortStyle];
        [caculator->dateFormatter setDateFormat:@"mm分ss秒：SSS毫秒"];
        
    });
    return caculator;
}

+(void)logTimeWhit:(NSString *)tag{
    NSLog(@"%@--%@", [[CellCaculator shareInstance]->dateFormatter stringFromDate:[NSDate date]], tag);
}


+(void)caculatorAllCellHeight:(NSArray<id<MessageModalProtocal>> *)msgArr callBackOnMainThread:(void(^)(void))completeBlock{
    
    logTime(@"开始计算")
    dispatch_group_t group = dispatch_group_create();
    
    for (id<MessageModalProtocal> msg in msgArr) {
        dispatch_group_async(group, [CellCaculator shareInstance]->caculatQueue, ^{
           msg.cellHeight = [self fetchCellHeight:msg];
        });
    }
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        logTime(@"计算完成")
        completeBlock();
    });
}

//TODO: 获取cell的高度方式
+(CGFloat)fetchCellHeight:(id<MessageModalProtocal>)data{
    
    // 返回缓存中的高度
    if (data.cellHeight) {
        return data.cellHeight;
    }
    // 计算高度
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
    CGFloat rand = (CGFloat)arc4random_uniform(15);
    
    // ..
    return 50.f + rand;
}

@end
