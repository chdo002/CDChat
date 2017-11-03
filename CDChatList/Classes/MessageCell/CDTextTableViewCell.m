//
//  CDTextTableViewCell.m
//  CDChatList
//
//  Created by chdo on 2017/10/25.
//

#import "CDTextTableViewCell.h"
#import "CDChatMacro.h"
#import "CDChatList.h"

@interface CDTextTableViewCell()

@property(nonatomic, strong) UILabel *msgContent;

@end

@implementation CDTextTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    
    return self;
}

#pragma mark MessageCellDelegate

- (void)configCellByData:(id<MessageModalProtocal>)data {
    
    self.msgModal = data;
    
    self.textLabel.text = data.msg;
    
    
    // 设置消息内容的总高度
    CGRect msgRect = self.msgContent_left.frame;
    msgRect.size.height = data.cellHeight;
    self.msgContent_left.frame = msgRect;
    
    // 设置气泡的高度和宽度
    
    CGRect bubbleRec = self.bubbleImage_left.frame;
    bubbleRec.size.width = data.bubbleWidth;
    bubbleRec.size.height = data.cellHeight - MessagePadding * 2;
    self.bubbleImage_left.frame = bubbleRec;
    
    
//    UIColor *color = data.modalInfo[@"color"];
//    self.backgroundColor = [UIColor whiteColor];
}

@end
