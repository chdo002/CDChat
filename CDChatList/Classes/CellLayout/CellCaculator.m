//
//  CellCaculator.m
//  CDChatList
//
//  Created by chdo on 2017/10/26.
//

#import "CellCaculator.h"
#import "CDChatMacro.h"
#import "SDImageCache.h"
#import "SDWebImageDownloader.h"
#import "ChatHelpr.h"
#import "CDBaseMsgCell.h"



/**
 
 从YYKit demo 中直接拿的 适配iOS 10以下
 文本 Line 位置修改
 将每行文本的高度和位置固定下来，不受中英文/Emoji字体的 ascent/descent 影响
 */
@interface WBTextLinePositionModifier : NSObject <YYTextLinePositionModifier>
@property (nonatomic, strong) UIFont *font; // 基准字体 (例如 Heiti SC/PingFang SC)
@property (nonatomic, assign) CGFloat paddingTop; //文本顶部留白
@property (nonatomic, assign) CGFloat paddingBottom; //文本底部留白
@property (nonatomic, assign) CGFloat lineHeightMultiple; //行距倍数
@end

/*
 将每行的 baseline 位置固定下来，不受不同字体的 ascent/descent 影响。
 
 注意，Heiti SC 中，    ascent + descent = font size，
 但是在 PingFang SC 中，ascent + descent > font size。
 所以这里统一用 Heiti SC (0.86 ascent, 0.14 descent) 作为顶部和底部标准，保证不同系统下的显示一致性。
 间距仍然用字体默认
 */
@implementation WBTextLinePositionModifier

- (instancetype)init {
    self = [super init];
    
    if (@available(iOS 9, *)) {
        _lineHeightMultiple = 1.34;   // for PingFang SC
    } else {
        _lineHeightMultiple = 1.3125; // for Heiti SC
    }
    
    return self;
}

- (void)modifyLines:(NSArray *)lines fromText: (NSAttributedString *)text inContainer:(YYTextContainer *)container {
    
    CGFloat ascent = _font.pointSize * 0.86;
    
    CGFloat lineHeight = _font.pointSize * _lineHeightMultiple;
    for (YYTextLine *line in lines) {
        CGPoint position = line.position;
        position.y = _paddingTop + ascent + line.row  * lineHeight;
        line.position = position;
    }
}

- (id)copyWithZone:(NSZone *)zone {
    WBTextLinePositionModifier *one = [self.class new];
    one->_font = _font;
    one->_paddingTop = _paddingTop;
    one->_paddingBottom = _paddingBottom;
    one->_lineHeightMultiple = _lineHeightMultiple;
    return one;
}

@end



@interface CellCaculator()

@end

@implementation CellCaculator


+(void)caculatorAllCellHeight: (CDChatMessageArray)msgArr
         callBackOnMainThread: (void(^)(CGFloat))completeBlock{
    
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
    
    NSMutableAttributedString *msg_attributeText = [[NSMutableAttributedString alloc] initWithString:msgData.msg];

  
    // 各种替换匹配
    
    // 表情匹配替换
    [ChatHelpr matchEmoji:msg_attributeText];
    
    // 链接匹配替换
    [ChatHelpr matchUrl:msg_attributeText fetchActions:^YYTextAction(void) {
        return ^(UIView *containerView, NSAttributedString *text, NSRange range, CGRect rect){
            ChatListInfo *info = [ChatListInfo new];
            info.eventType = ChatClickEventTypeURL;
            info.containerView = containerView;
            info.msgText = text.string;
            info.msglink = [text attributedSubstringFromRange:range].string;
            info.range = range;
            info.clicedkRect = rect;
            [[NSNotificationCenter defaultCenter] postNotificationName:CHATLISTCLICKMSGEVENT object:info];
        };
    }];
    
    
//    msg_attributeText.yy_lineSpacing = 2;
//    msg_attributeText.yy_maximumLineHeight = MessageTextDefaultFontSize;
//    msg_attributeText.yy_minimumLineHeight = MessageTextDefaultFontSize;
    msg_attributeText.yy_font = [UIFont systemFontOfSize:MessageTextDefaultFontSize];
    
    // 文字的限制区域，红色部分
    CGSize maxTextSize = CGSizeMake(BubbleMaxWidth - BubbleSharpAnglehorizInset - BubbleRoundAnglehorizInset,
                                    CGFLOAT_MAX);

    YYTextContainer *container = [YYTextContainer containerWithSize:maxTextSize];

    // 
//    WBTextLinePositionModifier *modifier = [WBTextLinePositionModifier new];
//    modifier.font = msg_attributeText.yy_font;
//    modifier.paddingTop = 0;
//    modifier.paddingBottom = 0;
//    container.linePositionModifier = modifier;
    
    YYTextLayout *layout = [YYTextLayout layoutWithContainer:container text:msg_attributeText];
    msgData.textlayout = layout;
    
    // 计算气泡宽度
    CGFloat bubbleWidth = ceilf(layout.textBoundingSize.width) + BubbleSharpAnglehorizInset + BubbleRoundAnglehorizInset;
    // 计算整个cell高度
    CGFloat cellheight = ceilf(layout.textBoundingSize.height) + BubbleRoundAnglehorizInset * 2 + MessageMargin * 2;

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
    if (actuallMiniSide < 80) {
        actuallMiniSide = 80;
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
    UIImage *image = [[SDImageCache sharedImageCache] imageFromCacheForKey: msgData.msg];
    
    // 如果本地存在图片，则通过图片计算
    if (image) {
        msgData.msgState = CDMessageStateNormal;
        return caculateImageSize140By140(image);
    } else {
        // 若不存在，则返回占位图大小，并下载
        msgData.msgState = CDMessageStateDownloading;
        [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:[NSURL URLWithString:msgData.msg] options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            if(error){
                msgData.msgState = CDMessageStateDownloadFaild;
                [[NSNotificationCenter defaultCenter] postNotificationName:CHATLISTDOWNLOADLISTFINISH object:msgData userInfo:error.userInfo];
            } else {
                
                CGSize size = caculateImageSize140By140(image);
                [[SDImageCache sharedImageCache] storeImage:image forKey:msgData.msg completion:nil];
                
                #warning 记录 缓存 这里写法有待商榷
                
                msgData.bubbleWidth = size.width;
                // 加上可能显示的时间视图高度
                CGFloat height = size.height;
                msgData.cellHeight = height + (msgData.willDisplayTime ? MsgTimeH : 0);
                
                msgData.msgState = CDMessageStateNormal;
                [[NSNotificationCenter defaultCenter] postNotificationName:CHATLISTDOWNLOADLISTFINISH object:msgData userInfo:nil];
            }
        }];
        
        return CGSizeMake(140, 140);
    }
}
#pragma mark ---计算系统消息消息尺寸方法

+(CGSize)sizeForSysInfoMessage:(CDChatMessage)msgData{
    
    NSDictionary *attri = @{NSFontAttributeName: SysInfoMessageFont};
    CGSize maxTextSize = CGSizeMake(SysInfoMessageMaxWidth, CGFLOAT_MAX);
    CGSize caculateTextSize = [msgData.msg boundingRectWithSize: maxTextSize
                                                        options: NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading
                                                     attributes:attri context:nil].size;
    
    return CGSizeMake(caculateTextSize.width + SysInfoPadding * 2,
                      caculateTextSize.height + SysInfoPadding * 2);
}

@end




