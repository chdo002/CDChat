//
//  CDTextTableViewCell.m
//  CDChatList
//
//  Created by chdo on 2017/10/25.
//

#import "CDTextTableViewCell.h"
#import "ChatMacros.h"
#import "CDChatListView.h"
#import "CDLabel.h"
#import "ChatHelpr.h"

@interface CDTextTableViewCell()

/**
 左侧文字label
 */
@property(nonatomic, strong) CDLabel *textContent_left;

/**
 右侧文字label
 */
@property(nonatomic, strong) CDLabel *textContent_right;

@end

@implementation CDTextTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    // 左侧气泡中添加label
    self.textContent_left = [[CDLabel alloc] init];
    self.textContent_left.frame = CGRectMake(BubbleSharpAnglehorizInset,
                                             BubbleRoundAnglehorizInset, 0, 0);
    [self.bubbleImage_left addSubview:self.textContent_left];
    self.bubbleImage_left.clipsToBounds = NO;
    
    // 右侧气泡中添加label
    self.textContent_right = [[CDLabel alloc] init];
    self.textContent_right.frame = CGRectMake(BubbleRoundAnglehorizInset,
                                              BubbleRoundAnglehorizInset, 0, 0);
    [self.bubbleImage_right addSubview:self.textContent_right];
    self.bubbleImage_right.clipsToBounds = NO;
    
    return self;
}

#pragma mark MessageCellDelegate

- (void)configCellByData:(CDChatMessage)data table:(CDChatListView *)table{
    [super configCellByData:data table:table];

    if (data.isLeft) {
        // 左侧
        //     设置消息内容, 并调整UI
        [self configText_Left:data];
    } else {
        // 右侧
        //     设置消息内容, 并调整UI
        [self configText_Right:data];
    }
}

-(void)configText_Left:(CDChatMessage)data{
    CGRect bubbleRec = self.bubbleImage_left.frame;
    
    // 给label复制文字内容
    self.textContent_left.data = data.textlayout;
    CGRect textRect = self.textContent_left.frame;
    textRect.size.width = bubbleRec.size.width - BubbleSharpAnglehorizInset - BubbleRoundAnglehorizInset;
    textRect.size.height = data.textlayout.height;
    self.textContent_left.frame = textRect;
}

-(void)configText_Right:(CDChatMessage)data{
    
    CGRect bubbleRec = self.bubbleImage_right.frame;
    
    // 给label复制文字内容
    self.textContent_right.data = data.textlayout;
    CGRect textRect = self.textContent_right.frame;
    textRect.size.width = bubbleRec.size.width - BubbleSharpAnglehorizInset - BubbleRoundAnglehorizInset;
    textRect.size.height = data.textlayout.height;
    self.textContent_right.frame = textRect;
}


@end
