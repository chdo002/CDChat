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

/**
 左侧文字label
 */
@property(nonatomic, strong) UILabel *textContent_left;

/**
 右侧文字label
 */
@property(nonatomic, strong) UILabel *textContent_right;

@end

@implementation CDTextTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    // 左侧气泡中添加label
    self.textContent_left = [[UILabel alloc] init];
    self.textContent_left.numberOfLines = 0;
    self.textContent_left.backgroundColor = MsgTextContentBackGroundColor;
    self.textContent_left.frame = CGRectMake(BubbleSharpAnglehorizInset,
                                             BubbleRoundAnglehorizInset, 0, 0);
    [self.bubbleImage_left addSubview:self.textContent_left];
    
    
    // 右侧气泡中添加label
    self.textContent_right = [[UILabel alloc] init];
    self.textContent_right.numberOfLines = 0;
    self.textContent_right.backgroundColor = MsgTextContentBackGroundColor;
    self.textContent_right.frame = CGRectMake(BubbleRoundAnglehorizInset,
                                              BubbleRoundAnglehorizInset, 0, 0);
    [self.bubbleImage_right addSubview:self.textContent_right];
    
    return self;
}

#pragma mark MessageCellDelegate

- (void)configCellByData:(CDChatMessage)data {
    [super configCellByData:data];

    if (data.isLeft) {
        // 左侧
        //     设置消息内容的总高度
        [self configText_Left:data];
    } else {
        // 右侧
        // 设置消息内容的总高度
        [self configText_Right:data];
    }
}

-(void)configText_Left:(CDChatMessage)data{

    CGRect bubbleRec = [super updateMsgContentFrame_left:data];
    
    // 给label复制文字内容
    self.textContent_left.attributedText = data.msg_attributed;
    CGRect textRect = self.textContent_left.frame;
    textRect.size.width = bubbleRec.size.width - BubbleSharpAnglehorizInset - BubbleRoundAnglehorizInset;
    textRect.size.height = bubbleRec.size.height - BubbleRoundAnglehorizInset * 2;
    self.textContent_left.frame = textRect;
}

-(void)configText_Right:(CDChatMessage)data{
    
    CGRect bubbleRec = [super updateMsgContentFrame_right:data];
    
    // 给label复制文字内容
    self.textContent_right.attributedText = data.msg_attributed;
    CGRect textRect = self.textContent_right.frame;
    textRect.size.width = bubbleRec.size.width - BubbleSharpAnglehorizInset - BubbleRoundAnglehorizInset;
    textRect.size.height = bubbleRec.size.height - BubbleRoundAnglehorizInset * 2;
    self.textContent_right.frame = textRect;
}
@end
