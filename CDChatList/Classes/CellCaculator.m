//
//  CellCaculator.m
//  CDChatList
//
//  Created by chdo on 2017/10/26.
//

#import "CellCaculator.h"
#import "CDChatMacro.h"
#import "SDImageCache.h"
#import "CDBaseMsgCell.h"
#import "ImageDownLoader.h"

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

    for (int i = 0; i < msgArr.count; i++) {    
        dispatch_group_async(group, caculatorQueue, ^{
           [self fetchCellHeight:i of:msgArr];
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
+(CGFloat)fetchCellHeight:(NSUInteger)index of:(CDChatMessageArray)msgArr{
    
    CDChatMessage data = msgArr[index];
    // 返回缓存中的高度
    if (data.cellHeight) {
        return data.cellHeight;
    }
    
//     计算高度
    
    // 和上一条信息对比判断cell上是否显示时间label
    if (index > 0) {
        CDChatMessage previousData = msgArr[index - 1];
        NSInteger lastTime = [previousData.createTime integerValue];
        NSInteger currentTime = [data.createTime integerValue];
        data.willDisplayTime = ((currentTime - lastTime) > 180000);
    }
    
    CGSize res = [self caculateCellHeightAndBubleWidth:data];
    
    CGFloat height = res.height;
    
    data.bubbleWidth = res.width;
    // 加上可能显示的时间视图高度
    data.cellHeight = height + (data.willDisplayTime ? MsgTimeH : 0);
    
    return height;
}

/**
 针对不同的cell，计算cell高度
 
 @param data 消息模型
 @return cell高度
 */
+(CGSize)caculateCellHeightAndBubleWidth:(CDChatMessage)data{
    
    CGFloat randwidth = (CGFloat)arc4random_uniform(15);
    CGFloat randHeight = (CGFloat)arc4random_uniform(15);

    switch (data.msgType) {
        case CDMessageTypeText:
            randwidth = 12;
            return CGSizeMake(randwidth + 150, randHeight + 179);
        case CDMessageTypeImage:
            return [self sizeForImageMessage:data];
        case CDMessageTypeSystemInfo:
            return CGSizeMake(randwidth + 150, randHeight + 179);
        default:
            return CGSizeMake(150, 170);
    }
}

+(CGSize) sizeForImageMessage: (CDChatMessage)data {
    
    UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey:data.messageId];
    if (image) {
        
        // 图片将被限制在140*140的区域内，按比例显示
        CGFloat width = image.size.width;
        CGFloat height = image.size.height;
        
        CGFloat maxSide = MAX(width, height);
        CGFloat miniSide = MIN(width, height);

        // 按比例缩小后的小边边长
        CGFloat actuallMiniSide = 140 * miniSide / maxSide;
        
        // 防止长图，宽图，限制最小边 下限
        if (actuallMiniSide < 45) {
            actuallMiniSide = 45;
        }
        
        // 返回的高度是图片高度，需加上消息内边距边成消息体高度
        if (maxSide == width) {
            return CGSizeMake(140, actuallMiniSide + MessagePadding * 2);
        } else {
            return CGSizeMake(actuallMiniSide, 140 + MessagePadding * 2);
        }
    
    } else {
        
        return CGSizeMake(140, 140);
    }
}

@end
