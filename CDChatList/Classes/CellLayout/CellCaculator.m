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
#import "SDWebImageDownloader.h"

@interface CellCaculator()
//{
//    dispatch_queue_t caculatQueue;
//}

@end
@implementation CellCaculator

//+(CellCaculator *)shareInstance{
//    static CellCaculator *caculator = nil;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        caculator = [[CellCaculator alloc]init];
//        // 计算所有cell高度的队列
//        caculator->caculatQueue = dispatch_queue_create("calqueue", DISPATCH_QUEUE_CONCURRENT);
//    });
//    return caculator;
//}

+(void)caculatorAllCellHeight: (CDChatMessageArray)msgArr
         callBackOnMainThread: (void(^)(CGFloat))completeBlock{
    
//    dispatch_group_t group = dispatch_group_create();
    
////   dispatch_queue_t caculatorQueue = [CellCaculator shareInstance]->caculatQueue;
//    dispatch_queue_t caculatorQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//
//    for (int i = 0; i < msgArr.count; i++) {
//        dispatch_group_async(group, caculatorQueue, ^{
//           [self fetchCellHeight:i of:msgArr];
//        });
//    }
//
//    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
//        CGFloat totalHeight = 0.0f;
//        for (CDChatMessage msg in msgArr) {
//            totalHeight = totalHeight + msg.cellHeight;
//        }
//        completeBlock(totalHeight);
//    });
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < msgArr.count; i++) {
            [self fetchCellHeight:i of:msgArr];
        }
        CGFloat totalHeight = 0.0f;
        for (CDChatMessage msg in msgArr) {
            totalHeight = totalHeight + msg.cellHeight;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            completeBlock(totalHeight);
        });
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
    
    // 记录 缓存
    data.bubbleWidth = res.width;
    
    // 加上可能显示的时间视图高度
    CGFloat height = res.height;
    data.cellHeight = height + (data.willDisplayTime ? MsgTimeH : 0);
    
    return data.cellHeight;
}

#pragma mark 针对不同的cell，计算cell高度及气泡宽度

/**
 针对不同的cell，计算cell高度及气泡宽度
 
 @param data 消息模型
 @return cell高度
 */
+(CGSize)caculateCellHeightAndBubleWidth:(CDChatMessage)data{

    switch (data.msgType) {
        case CDMessageTypeText:
            return [self sizeForTextMessage:data];
        case CDMessageTypeImage:
            return [self sizeForImageMessage:data];
        case CDMessageTypeSystemInfo:
            return [self sizeForSysInfoMessage:data];
        default:
            return CGSizeMake(150, 170);
    }
}

#pragma mark ---计算文字消息尺寸方法
+(CGSize) sizeForTextMessage:(CDChatMessage)msgData{
    
//    NSDictionary *attri = @{NSFontAttributeName: MessageFont};
    #warning 注意换行
    //NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
    // 计算的高度 = boundingRectWithSize计算出来的高度 + \n\r转义字符出现的个数 * 单行文本的高度。

    // 文字的限制区域，红色部分
    CGSize maxTextSize = CGSizeMake(BubbleMaxWidth - BubbleSharpAnglehorizInset - BubbleRoundAnglehorizInset,
                                    CGFLOAT_MAX);
//
//    [msgData.msg_attributed enumerateAttributesInRange:NSMakeRange(0, msgData.msg_attributed.length) options:NSAttributedStringEnumerationReverse usingBlock:^(NSDictionary<NSAttributedStringKey,id> * _Nonnull attrs, NSRange range, BOOL * _Nonnull stop) {
//        
//    }];
//
    // 计算文字区域大小
    CGSize caculateTextSize = [msgData.msg_attributed boundingRectWithSize:maxTextSize options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading context:nil].size;
    
    // 计算气泡宽度
    CGFloat bubbleWidth = ceilf(caculateTextSize.width) + BubbleSharpAnglehorizInset + BubbleRoundAnglehorizInset;
    // 计算整个cell高度
    CGFloat cellheight = ceilf(caculateTextSize.height) + BubbleRoundAnglehorizInset * 2 + MessageMargin * 2;
    
    // 如果 小于最小cell高度
    if (cellheight < MessageContentH) {
        cellheight = MessageContentH;
    }
    
    return CGSizeMake(bubbleWidth, cellheight);
}

#pragma mark ---计算图片消息尺寸方法

/**
 根据图片大小计算气泡宽度和cell高度
 */
static CGSize caculateImageSize140By140(UIImage *image) {
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
    
    // 返回的高度是图片高度，需加上消息内边距变成消息体高度
    if (maxSide == width) {
        return CGSizeMake(140, actuallMiniSide + MessageMargin * 2);
    } else {
        return CGSizeMake(actuallMiniSide, 140 + MessageMargin * 2);
    }
}

+(CGSize) sizeForImageMessage: (CDChatMessage)msgData {
    
    // 获得本地缓存的图片
    UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey: msgData.msg_attributed.string];
    
    // 如果本地存在图片，则通过图片计算
    if (image) {
        msgData.msgState = CDMessageStateNormal;
        return caculateImageSize140By140(image);
    } else {
        // 若不存在，则返回占位图大小，并下载
        msgData.msgState = CDMessageStateDownloading;
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:msgData.msg_attributed.string] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if(error){
                
            } else {
                
                CGSize size = caculateImageSize140By140(image);
                [[SDImageCache sharedImageCache] storeImage:image forKey:msgData.msg_attributed.string completion:nil];
                
                #warning 记录 缓存 这里写法有待商榷
                
                msgData.bubbleWidth = size.width;
                // 加上可能显示的时间视图高度
                CGFloat height = size.height;
                msgData.cellHeight = height + (msgData.willDisplayTime ? MsgTimeH : 0);
                
                msgData.msgState = CDMessageStateNormal;
                [[NSNotificationCenter defaultCenter] postNotificationName:DOWNLOADLISTFINISH object:msgData userInfo:nil];
            }
        }];
        
        return CGSizeMake(140, 140);
    }
}
#pragma mark ---计算系统消息消息尺寸方法

+(CGSize)sizeForSysInfoMessage:(CDChatMessage)msgData{
    
    NSDictionary *attri = @{NSFontAttributeName: SysInfoMessageFont};
    CGSize maxTextSize = CGSizeMake(SysInfoMessageMaxWidth, CGFLOAT_MAX);
    CGSize caculateTextSize = [msgData.msg_attributed.string boundingRectWithSize: maxTextSize
                                                        options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                     attributes:attri context:nil].size;
    
    return CGSizeMake(caculateTextSize.width + SysInfoPadding * 2,
                      caculateTextSize.height + SysInfoPadding * 2);
}

@end
