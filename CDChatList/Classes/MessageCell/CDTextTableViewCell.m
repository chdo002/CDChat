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

@property(nonatomic, strong) UILabel *textContent_left;
@property(nonatomic, strong) UILabel *textContent_right;

@end

@implementation CDTextTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    // 左侧气泡中添加label
    self.textContent_left = [[UILabel alloc] init];
    self.textContent_left.backgroundColor = [UIColor redColor];
    self.textContent_left.frame = CGRectMake(BubbleSharpAnglehorizInset, BubbleRoundAnglehorizInset, 0, 0);
    [self.bubbleImage_left addSubview:self.textContent_left];
    
    // 右侧气泡中添加label
    self.textContent_right = [[UILabel alloc] init];
    self.textContent_right.backgroundColor = [UIColor redColor];
    self.textContent_right.frame = CGRectMake(BubbleSharpAnglehorizInset, BubbleRoundAnglehorizInset, 0, 0);
    [self.bubbleImage_right addSubview:self.textContent_right];
    
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
    
//    CGRect bubbleRec = self.bubbleImage_left.frame;
//    bubbleRec.size.width = data.bubbleWidth;
//    bubbleRec.size.height = data.cellHeight - MessagePadding * 2;
//    self.bubbleImage_left.frame = bubbleRec;
//
//    // 文字内容
//    self.textContent_left.text = data.msg;
//    CGRect textRect = self.textContent_left.frame;
//    textRect.size.width = bubbleRec.size.width - BubbleSharpAnglehorizInset - BubbleRoundAnglehorizInset;
//    textRect.size.height = bubbleRec.size.height - BubbleRoundAnglehorizInset * 2;
//    self.textContent_left.frame = textRect;
    
    CGRect bubbleRec = self.bubbleImage_right.frame;
    bubbleRec.size.width = data.bubbleWidth;
    bubbleRec.size.height = data.cellHeight - MessagePadding * 2;
    
    
    
//    UIColor *color = data.modalInfo[@"color"];
//    self.backgroundColor = [UIColor whiteColor];
}

@end
