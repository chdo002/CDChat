//
//  CDTextTableViewCell.m
//  CDChatList
//
//  Created by chdo on 2017/10/25.
//

#import "CDTextTableViewCell.h"

@implementation CDTextTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = CRMHexColor(0x808080);
    return self;
}

#pragma mark MessageCellDelegate

/**
 计算cell高度
 @return cell高度
 */
+(CGFloat)heightForMessage{
    return 50.0f;
}



@end
