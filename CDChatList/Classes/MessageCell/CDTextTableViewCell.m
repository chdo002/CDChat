//
//  CDTextTableViewCell.m
//  CDChatList
//
//  Created by chdo on 2017/10/25.
//

#import "CDTextTableViewCell.h"
#import "CDChatMacro.h"

@interface CDTextTableViewCell()

@property(nonatomic, strong) id<MessageModalProtocal> msgModal;

@end

@implementation CDTextTableViewCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = CRMRadomColor(0x808080);
    return self;
}

#pragma mark MessageCellDelegate

- (void)configCellByData:(id<MessageModalProtocal>)data {
    self.msgModal = data;
    self.textLabel.text = data.msg;
}

@end
