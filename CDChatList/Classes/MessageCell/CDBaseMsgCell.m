//
//  CDBaseMsgCell.m
//  CDChatList
//
//  Created by chdo on 2017/11/2.
//

#import "CDBaseMsgCell.h"
#import "ChatHelpr.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UITool.h"

@interface CDBaseMsgCell()

@end

@implementation CDBaseMsgCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = MsgBackGroundColor;
    
    // 1 消息时间初始化
    _timeLabel = [[UILabel alloc] init];
    [_timeLabel setFrame:CGRectMake(0, 0, 100, MsgTimeH)];
    _timeLabel.center = CGPointMake(ScreenW() / 2, MsgTimeH / 2);
    _timeLabel.text = @"星期一 下午 2:38";
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.backgroundColor = CRMHexColor(0xCECECE);
    _timeLabel.layer.cornerRadius = 5;
    _timeLabel.clipsToBounds = YES;
    _timeLabel.font = [UIFont systemFontOfSize:12];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_timeLabel];
    
    // 2 左边 消息内容初始化  头像  气泡
    [self initLeftMessageContent];
    
    // 3 右边 消息内容初始化  头像  气泡
    [self initRightMessageContent];
    
    return self;
}
#pragma mark 初始化左侧消息UI
-(void)initLeftMessageContent {
    
    // 视图容器
    _msgContent_left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW(), MessageContentH)];
    _msgContent_left.backgroundColor = MsgContentBackGroundColor;
    [self addSubview:_msgContent_left];
    
    // 头像
    UIImage *left_head = ChatHelpr.share.imageDic[@"icon_head"];
    _headImage_left = [[UIImageView alloc] initWithImage:left_head];
    _headImage_left.frame = CGRectMake(MessageMargin, MessageMargin,
                                       HeadSideLength, HeadSideLength);
    _headImage_left.contentMode = UIViewContentModeScaleAspectFit;
    _headImage_left.backgroundColor = HeadBackGroundColor;
    [_msgContent_left addSubview:_headImage_left];
    
    // 气泡
    UIImage *left_box = ChatHelpr.share.imageDic[@"left_box"];
    _bubbleImage_left = [[UIImageView alloc] initWithImage:left_box];
    _bubbleImage_left.userInteractionEnabled = YES;
    _bubbleImage_left.frame = CGRectMake(MessageMargin * 2 + HeadSideLength - BubbleShareAngleWidth,
                                         MessageMargin, BubbleMaxWidth, HeadSideLength);
    [_msgContent_left addSubview:_bubbleImage_left];
    
    //消息失败icon
    _failLabel_left = [[UILabel alloc] init];
    [_msgContent_left addSubview:_failLabel_left];
    
    if (@available(iOS 8.2, *)) {
        _failLabel_left.font = [UIFont systemFontOfSize:16 weight:UIFontWeightHeavy];
    } else {
        _failLabel_left.font = [UIFont systemFontOfSize:16];
    }
    
    _failLabel_left.text = @"!";
    _failLabel_left.textAlignment = NSTextAlignmentCenter;
    _failLabel_left.textColor = [UIColor whiteColor];
    _failLabel_left.backgroundColor = [UIColor redColor];
    _failLabel_left.clipsToBounds = YES;
    _failLabel_left.layer.cornerRadius = 10;
    _failLabel_left.frame = CGRectMake(0, 0, 20, 20);
    _failLabel_left.center = CGPointMake(_bubbleImage_left.frame.origin.x + _bubbleImage_left.frame.size.width + 20,
                                         _bubbleImage_left.frame.origin.y + _bubbleImage_left.frame.size.height * 0.5);
    
    //发送中的菊花loading
    _indicator_left = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_msgContent_left addSubview:_indicator_left];
    [_indicator_left startAnimating];
    _indicator_left.frame = _failLabel_left.frame;
    _indicator_left.center = _failLabel_left.center;

}
#pragma mark 初始化右侧消息UI
-(void)initRightMessageContent{
    
    // 视图容器
    _msgContent_right = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenW(), MessageContentH)];
    _msgContent_right.backgroundColor = MsgContentBackGroundColor;
    [self addSubview:_msgContent_right];

    // 头像
    UIImage *right_head = ChatHelpr.share.imageDic[@"icon_head"];
    
    _headImage_right = [[UIImageView alloc] initWithImage:right_head];
    _headImage_right.frame = CGRectMake(ScreenW() - (HeadSideLength + MessageMargin), MessageMargin,
                                        HeadSideLength, HeadSideLength);
    _headImage_right.contentMode = UIViewContentModeScaleAspectFit;
    _headImage_right.backgroundColor = HeadBackGroundColor;
    [_msgContent_right addSubview:_headImage_right];
    
    // 气泡
    UIImage *right_box = ChatHelpr.share.imageDic[@"right_box"];
    _bubbleImage_right = [[UIImageView alloc] initWithImage:right_box];
    _bubbleImage_right.userInteractionEnabled = YES;
    _bubbleImage_right.frame = CGRectMake(ScreenW() - (BubbleMaxWidth + MessageMargin * 2 + HeadSideLength) + BubbleShareAngleWidth,
                                          MessageMargin, BubbleMaxWidth, HeadSideLength);
    [_msgContent_right addSubview:_bubbleImage_right];
    
    //消息失败icon
    _failLabel_right = [[UILabel alloc] init];
    [_msgContent_right addSubview:_failLabel_right];
    if (@available(iOS 8.2, *)) {
        _failLabel_right.font = [UIFont systemFontOfSize:16 weight:UIFontWeightHeavy];
    } else {
        _failLabel_right.font = [UIFont systemFontOfSize:16];
    }
    
    _failLabel_right.text = @"!";
    _failLabel_right.textAlignment = NSTextAlignmentCenter;
    _failLabel_right.textColor = [UIColor whiteColor];
    _failLabel_right.backgroundColor = [UIColor redColor];
    _failLabel_right.clipsToBounds = YES;
    _failLabel_right.layer.cornerRadius = 10;
    _failLabel_right.frame = CGRectMake(0, 0, 20, 20);
    _failLabel_right.center = CGPointMake(_bubbleImage_right.frame.origin.x - 40,
                                          _bubbleImage_right.frame.size.height * 0.5);
    
    //发送中的菊花loading
    _indicator_right = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [_msgContent_right addSubview:_indicator_right];
    [_indicator_right startAnimating];
    
    _indicator_right.frame = _failLabel_right.frame;
    _indicator_right.center = _failLabel_right.center;
}

#pragma mark 根据消息中的cellHeight  bubbleWidth 更新左侧UI
/**
 根据消息中的cellHeight  bubbleWidth 更新UI

 @param data 消息体
 @return 气泡宽高
 */
-(CGRect)updateMsgContentFrame_left:(CDChatMessage) data{
    // 左侧
    // 设置消息内容的总高度
    CGRect msgRect = self.msgContent_left.frame;
    CGFloat msgContentHeight = data.cellHeight;
    
    // 根据是否显示时间，调整msgContent_left位置
    if (data.willDisplayTime) {
        msgRect.origin = CGPointMake(msgRect.origin.x, MsgTimeH);
        msgContentHeight = msgContentHeight - MsgTimeH; //
    } else {
        msgRect.origin = CGPointMake(msgRect.origin.x, 0);
    }
    msgRect.size.height = msgContentHeight;
    self.msgContent_left.frame = msgRect;
    
    // 更新气泡的高度和宽度
    CGRect bubbleRec = self.bubbleImage_left.frame;
    bubbleRec.size.width = data.bubbleWidth;
    bubbleRec.size.height = msgContentHeight - MessageMargin * 2;
    self.bubbleImage_left.frame = bubbleRec;
    
    // 更新loading位置
    _indicator_left.frame = CGRectMake(0, 0, 20, 20);
    _indicator_left.center = CGPointMake(_bubbleImage_left.frame.origin.x + _bubbleImage_left.frame.size.width + 20,
                                         _bubbleImage_left.frame.origin.y + _bubbleImage_left.frame.size.height * 0.5);
    
    // 更新faillabel位置
    _failLabel_left.frame = _indicator_left.frame;
    _failLabel_left.center = _indicator_left.center;
    
    // 更新动画状态
    // 更新动画状态
    if (data.msgState == CDMessageStateNormal) {
        [_indicator_left stopAnimating];
        [_failLabel_left setHidden: YES];
    } else if (data.msgState == CDMessageStateSending) {
        [_indicator_left startAnimating];
        [_failLabel_left setHidden: YES];
    } else if (data.msgState == CDMessageStateSendFaild ||
               data.msgState == CDMessageStateDownloadFaild) {
        [_indicator_left stopAnimating];
        [_failLabel_left setHidden: NO];
    } else if (data.msgState == CDMessageStateDownloading) {
        [_indicator_left startAnimating];
        [_failLabel_left setHidden: YES];
    }
    
    return bubbleRec;
}

#pragma mark 根据消息中的cellHeight  bubbleWidth 更新右侧UI
/**
 根据消息中的cellHeight  bubbleWidth 更新UI
 
 @param data 消息体
 @return 气泡宽高
 */
-(CGRect)updateMsgContentFrame_right:(CDChatMessage) data{
    // 右侧
    // 设置消息内容的总高度
    CGRect msgRect = self.msgContent_right.frame;
    CGFloat msgContentHeight = data.cellHeight;
    if (data.willDisplayTime) {
        msgRect.origin = CGPointMake(msgRect.origin.x, MsgTimeH);
        msgContentHeight = msgContentHeight - MsgTimeH; //
    } else {
        msgRect.origin = CGPointMake(msgRect.origin.x, 0);
    }
    msgRect.size.height = msgContentHeight;
    self.msgContent_right.frame = msgRect;
    
    // 设置气泡的高度和宽度
    CGRect bubbleRec = self.bubbleImage_right.frame;
    bubbleRec.size.width = data.bubbleWidth;
    bubbleRec.size.height = msgContentHeight - MessageMargin * 2;
    bubbleRec.origin.x = ScreenW() - (data.bubbleWidth + MessageMargin * 2 + HeadSideLength) + BubbleShareAngleWidth;
    self.bubbleImage_right.frame = bubbleRec;
    
    // 设置loading位置
    _indicator_right.frame = CGRectMake(0, 0, 20, 20);
    _indicator_right.center = CGPointMake(_bubbleImage_right.frame.origin.x - 20,
                                          _bubbleImage_right.frame.origin.y + _bubbleImage_right.frame.size.height * 0.5);
    // 更新faillabel位置
    _failLabel_right.frame = _indicator_right.frame;
    _failLabel_right.center = _indicator_right.center;
    
    // 更新动画状态
    if (data.msgState == CDMessageStateNormal) {
        [_indicator_right stopAnimating];
        [_failLabel_right setHidden: YES];
    } else if (data.msgState == CDMessageStateSending) {
        [_indicator_right startAnimating];
        [_failLabel_right setHidden: YES];
    } else if (data.msgState == CDMessageStateSendFaild ||
               data.msgState == CDMessageStateDownloadFaild) {
        [_indicator_right stopAnimating];
        [_failLabel_right setHidden: NO];
    } else if (data.msgState == CDMessageStateDownloading) {
        [_indicator_right startAnimating];
        [_failLabel_right setHidden: YES];
    }
    
    return bubbleRec;
}

#pragma mark 设置消息data
- (void)configCellByData:(CDChatMessage)data table:(CDChatListView *)table {
    self.msgModal = data;
    
    // 设置显示或隐藏  左右气泡
    [self.msgContent_left setHidden:!data.isLeft];
    [self.msgContent_right setHidden:data.isLeft];
    
    // 设置头像
    if (data.isLeft) {
        if (data.userThumImage) {
            _headImage_left.image = data.userThumImage;
        } else if (data.userThumImageURL) {
            
            [_headImage_left sd_setImageWithURL:[NSURL URLWithString:data.userThumImageURL]
                                placeholderImage:ChatHelpr.share.imageDic[@"icon_head"]];
        } else {
            [_headImage_left setImage:ChatHelpr.share.imageDic[@"icon_head"]];
        }
    } else {
        if (data.userThumImage) {
            _headImage_right.image = data.userThumImage;
        } else if (data.userThumImageURL) {
            [_headImage_right sd_setImageWithURL:[NSURL URLWithString:data.userThumImageURL]
                                 placeholderImage:ChatHelpr.share.imageDic[@"icon_head"]];
        } else {
            [_headImage_right setImage:ChatHelpr.share.imageDic[@"icon_head"]];
        }
    }
    
    // 设置顶部时间Label
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:[data.createTime doubleValue] * 0.001];
    self.timeLabel.text = [self checkDateDisplay:date];
    CGSize textSize = [self.timeLabel.text boundingRectWithSize:CGSizeMake(ScreenW(), MsgTimeH) options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: self.timeLabel.font} context:nil].size;
    if (textSize.height < MsgTimeH) {
        textSize.height = MsgTimeH;
    }
    [_timeLabel setFrame:CGRectMake(0, 0, textSize.width + SysInfoPadding * 2, textSize.height)];
    _timeLabel.center = CGPointMake(ScreenW() / 2, MsgTimeH / 2);
}

#pragma mark 根据消息时间，计算需要显示的消息时间格式
/**
 根据消息时间，计算需要显示的消息时间格式

 @param thisDate 消息时间
 @return 显示在label上的
 */
- (NSString*)checkDateDisplay:(NSDate *) thisDate {
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    NSDate *nowDate =  [NSDate date];
    
    // IOS8 最低支持；
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear;
    
    NSDateComponents *nowComps = [[NSDateComponents alloc] init];
    nowComps = [calendar components:unitFlags fromDate:nowDate];
    NSInteger nowDay = nowComps.day;
    
    // 时间戳  转 是日期
    NSDateComponents *thisComps = [[NSDateComponents alloc] init];
    thisComps = [calendar components:unitFlags fromDate:thisDate];
    NSInteger thisDay = thisComps.day;
    
    // 当前时间差；
    NSDateComponents *dayDiffComps = [[NSDateComponents alloc] init] ;
    dayDiffComps = [calendar components:NSCalendarUnitDay fromDate:thisDate toDate:nowDate options:NSCalendarWrapComponents];
    NSInteger compareDay = dayDiffComps.day;
    
    NSString *timeString;
    
    // 是否 是当天 的 时间；
    if (compareDay == 0 && nowDay == thisDay) {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"HH:mm"];
        timeString  = [dateFormat stringFromDate:thisDate];
        return timeString;
    }
    
    // 是否  昨天时间；
    if (compareDay == 1 || (compareDay == 0 && nowDay != thisDay) ){
        timeString = @"昨天";
        
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"HH:mm"];
        NSString* time = [dateFormat stringFromDate:thisDate];
        timeString = [NSString stringWithFormat:@"%@ %@" , timeString , time ];
        
        return timeString;
    }
    
    // 是否  前天时间；
    if (compareDay == 2 || (compareDay == 0 && nowDay != thisDay) ){
        timeString = @"前天";
        
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        [dateFormat setDateFormat:@"HH:mm"];
        NSString* time = [dateFormat stringFromDate:thisDate];
        timeString = [NSString stringWithFormat:@"%@ %@" , timeString , time ];
        
        return timeString;
    }
    
    // 非近 一周时间 ；
    NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM-dd"];
    timeString  = [dateFormat stringFromDate:thisDate];
    
    [dateFormat setDateFormat:@"yy/MM/dd"];
    timeString  = [dateFormat stringFromDate:thisDate];
    
    return timeString;
}
 


@end
