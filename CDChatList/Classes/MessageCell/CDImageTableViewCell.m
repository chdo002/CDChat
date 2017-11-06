//
//  CDImageTableViewCell.m
//  CDChatList
//
//  Created by chdo on 2017/11/6.
//

#import "CDImageTableViewCell.h"

@interface CDImageTableViewCell()

/**
 图片_左侧
 */
@property(nonatomic, strong) UIImageView *imageContent_left;

/**
 图片_右侧侧
 */
@property(nonatomic, strong) UIImageView *imageContent_right;


@end;

@implementation CDImageTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    [self initLeftImageContent];
    [self initRightImageContent];
    
    return self;
}

-(void)initLeftImageContent{
    // 将气泡图换位透明图
    UIImage *left_box = BundleImage(@"bg_mask_left");
    UIEdgeInsets inset_left = UIEdgeInsetsMake(BubbleSharpAngleHeighInset,
                                               BubbleSharpAnglehorizInset,
                                               BubbleRoundAnglehorizInset,
                                               BubbleRoundAnglehorizInset);
    
    left_box = [left_box resizableImageWithCapInsets:inset_left resizingMode:UIImageResizingModeStretch];
    self.bubbleImage_left.image = left_box;
    
    // 在气泡图下面添加信息图片
    self.imageContent_left = [[UIImageView alloc] initWithFrame:self.bubbleImage_left.frame];
    self.imageContent_left.contentMode = UIViewContentModeScaleAspectFit;
    self.imageContent_left.backgroundColor = [UIColor brownColor];
    [self.msgContent_left insertSubview:self.imageContent_left belowSubview:self.bubbleImage_left];
}

-(void)initRightImageContent{
    // 将气泡图换位透明图
    UIImage *right_box = BundleImage(@"bg_mask_right");
    UIEdgeInsets inset_right = UIEdgeInsetsMake(BubbleSharpAngleHeighInset,
                                                BubbleRoundAnglehorizInset,
                                                BubbleRoundAnglehorizInset,
                                                BubbleSharpAnglehorizInset);
    right_box = [right_box resizableImageWithCapInsets:inset_right
                                          resizingMode:UIImageResizingModeStretch];
    self.bubbleImage_right.image = right_box;
    
    // 在气泡图下面添加信息图片
    self.imageContent_right = [[UIImageView alloc] initWithFrame:self.bubbleImage_right.frame];
    self.imageContent_right.contentMode = UIViewContentModeScaleAspectFit;
    self.imageContent_right.backgroundColor = CRMHexColor(0x808080);
    [self.msgContent_right insertSubview:self.imageContent_right
                            belowSubview:self.bubbleImage_right];
}

-(void)configCellByData:(CDChatMessage)data{
    [super configCellByData:data];
    
    [self.msgContent_left setHidden:NO];
    [self.msgContent_right setHidden:YES];
    
    // 左侧
    // 设置消息内容的总高度
    [self configImage_Left:data];
    
    // 右侧
    // 设置消息内容的总高度
    [self configImage_Right:data];    
}

-(void)configImage_Left:(CDChatMessage)data {
    CGRect bubbleRec = [super updateMsgContentFrame_left:data];
    self.imageContent_left.frame = bubbleRec;
}

-(void)configImage_Right:(CDChatMessage)data {
    CGRect bubbleRec = [super updateMsgContentFrame_right:data];
    self.imageContent_right.frame  =bubbleRec;
}
@end
