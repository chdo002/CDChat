//
//  CDSystemTableViewCell.m
//  CDChatList
//
//  Created by chdo on 2017/11/13.
//

#import "CDSystemTableViewCell.h"
#import "CDChatMacro.h"
#import "CDBaseMsgCell.h"

@interface CDSystemTableViewCell()
@property(nonatomic, strong) UILabel *sysInfoLbael;
@end

@implementation CDSystemTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.backgroundColor = MsgBackGroundColor;
    
    self.sysInfoLbael = [[UILabel alloc] init];
    self.sysInfoLbael.font = SysInfoMessageFont;
    self.sysInfoLbael.textAlignment = NSTextAlignmentCenter;
    self.sysInfoLbael.textColor = [UIColor whiteColor];
    self.sysInfoLbael.layer.cornerRadius = 5;
    self.sysInfoLbael.clipsToBounds = YES;
    self.sysInfoLbael.backgroundColor = CRMHexColor(0xCECECE);
    [self addSubview:self.sysInfoLbael];
    
    return self;
}
- (void)configCellByData:(CDChatMessage)data {
    self.sysInfoLbael.text = data.msg;
    self.sysInfoLbael.frame = CGRectMake(0, 0, data.bubbleWidth, data.cellHeight - SysInfoPadding * 1.2);
    self.sysInfoLbael.center = CGPointMake(scrnW / 2, data.cellHeight / 2);
}

@end
