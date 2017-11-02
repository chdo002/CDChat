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
    
    self.backgroundColor = [UIColor whiteColor];
    
    // 消息时间初始化
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
    
    // left bubble初始化
    
//    _msgContent_left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, scrnW, 50)];
//    _msgContent_left.backgroundColor = MsgBackGroundColor;
//    [self addSubview:_msgContent_left];
    
    UIImage *left_box = BundleImage(@"left_box");
    UIEdgeInsets inset = UIEdgeInsetsMake(40, 40, 40, 40);
    [left_box resizableImageWithCapInsets:inset resizingMode:UIImageResizingModeStretch];
    _bubbleImage = [[UIImageView alloc] initWithImage:left_box];
    [_msgContent_left addSubview:_bubbleImage];
    
    
    
    
    return self;
}

@end
