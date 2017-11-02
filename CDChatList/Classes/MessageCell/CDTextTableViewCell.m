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
//    UIColor *color = data.modalInfo[@"color"];
    self.backgroundColor = [UIColor whiteColor];

}

@end
