//
//  CDBaseMsgCell.m
//  CDChatList
//
//  Created by chdo on 2017/11/2.
//

#import "CDBaseMsgCell.h"


@interface CDBaseMsgCell()

@end
@implementation CDBaseMsgCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.backgroundColor = MsgBackGroundColor;
    
    // 1 消息时间初始化
    _timeLabel = [[UILabel alloc] init];
    [_timeLabel setFrame:CGRectMake(0, 0, 100, 25)];
    _timeLabel.center = CGPointMake(scrnW / 2, MsgTimeH / 2);
    _timeLabel.text = @"昨天 下午 2:38";
    _timeLabel.textColor = [UIColor whiteColor];
    _timeLabel.backgroundColor = CRMHexColor(0xCECECE);
    _timeLabel.layer.cornerRadius = 5;
    _timeLabel.clipsToBounds = YES;
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:_timeLabel];
    
    // 2 左边 消息内容初始化
    [self initLeftMessageContent];
    //    _msgContent_left.hidden = YES;
    
    // 3 右边 消息内容初始化
    [self initRightMessageContent];
    _msgContent_right.hidden = YES;
    
    
    return self;
}

-(void)initLeftMessageContent {
    _msgContent_left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrnW, MessageContentH)];
    //    _msgContent_left.backgroundColor = MsgBackGroundColor;
    _msgContent_left.backgroundColor = [UIColor blueColor];
    [self addSubview:_msgContent_left];
    // 头像
    UIImage *left_head = BundleImage(@"icon_head");
    _headImage_left = [[UIImageView alloc] initWithImage:left_head];
    _headImage_left.frame = CGRectMake(MessagePadding, MessagePadding,
                                       HeadSideLength, HeadSideLength);
    _headImage_left.contentMode = UIViewContentModeScaleAspectFit;
    _headImage_left.backgroundColor = [UIColor redColor];
    [_msgContent_left addSubview:_headImage_left];
    
    // 气泡
    UIImage *left_box = BundleImage(@"left_box");
    UIEdgeInsets inset_left = UIEdgeInsetsMake(25, 11, 5, 5);
    //    UIImage *left_box = BundleImage(@"bg_mask_left");
    
    left_box = [left_box resizableImageWithCapInsets:inset_left resizingMode:UIImageResizingModeStretch];
    _bubbleImage_left = [[UIImageView alloc] initWithImage:left_box];
    _bubbleImage_left.frame = CGRectMake(MessagePadding * 2 + HeadSideLength,
                                         MessagePadding, BubbleMaxWidth, HeadSideLength);
    [_msgContent_left addSubview:_bubbleImage_left];
}

-(void)initRightMessageContent{
    _msgContent_right = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrnW, MessageContentH)];
    _msgContent_right.backgroundColor = MsgBackGroundColor;
    [self addSubview:_msgContent_right];
    // 头像
    UIImage *right_head = BundleImage(@"icon_head");
    _headImage_right = [[UIImageView alloc] initWithImage:right_head];
    _headImage_right.frame = CGRectMake(scrnW - (HeadSideLength + MessagePadding), MessagePadding,
                                        HeadSideLength, HeadSideLength);
    _headImage_right.contentMode = UIViewContentModeScaleAspectFit;
    _headImage_right.backgroundColor = [UIColor redColor];
    [_msgContent_right addSubview:_headImage_right];
    
    // 气泡
    UIImage *right_box = BundleImage(@"right_box");
    UIEdgeInsets inset_right = UIEdgeInsetsMake(40, 20, 40, 40);
    right_box = [right_box resizableImageWithCapInsets:inset_right resizingMode:UIImageResizingModeStretch];
    _bubbleImage_right = [[UIImageView alloc] initWithImage:right_box];
    _bubbleImage_right.frame = CGRectMake(scrnW - (BubbleMaxWidth + MessagePadding * 2 + HeadSideLength),
                                          MessagePadding, BubbleMaxWidth, HeadSideLength);
    [_msgContent_right addSubview:_bubbleImage_right];
}


-(void)configmsgContentFrame: (CDChatMessage)data{
    
}

@end
