//
//  CusomNewsCell.m
//  CDChatList_Example
//
//  Created by chdo on 2018/8/31.
//  Copyright © 2018年 chdo002. All rights reserved.
//

#import "CustomNewsCell.h"
#import "Masonry.h"
NSString *const CustomNewsCellReuseId = @"CustomNewsCellReuseId";

@interface CustomNewsCell()

@end

@implementation CustomNewsCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.text = @"这是新闻title";
    [self.bubbleImage_left addSubview:titleLabel];
    
    UILabel *subTitle = [[UILabel alloc] init];
    subTitle.text = @"这是subtitle啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊";
    subTitle.textColor = [UIColor lightGrayColor];
    subTitle.font = [UIFont systemFontOfSize:12];
    subTitle.numberOfLines = 0;
    [self.bubbleImage_left addSubview:subTitle];
    
    
    UIImageView *imagev = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"thum"]];
    [self.bubbleImage_left addSubview:imagev];
    
    
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bubbleImage_left).offset(15);
        make.top.equalTo(self.bubbleImage_left).offset(15);
    }];
    
    [subTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bubbleImage_left).offset(15);
        make.top.equalTo(titleLabel).offset(10);
        make.bottom.equalTo(self.bubbleImage_left).offset(-15);
        make.right.equalTo(self.bubbleImage_left).offset(-100);
    }];
    
    
    [imagev mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bubbleImage_left).offset(15);
        make.right.equalTo(self.bubbleImage_left).offset(-15);
        make.bottom.equalTo(self.bubbleImage_left).offset(-15);
        make.width.equalTo(imagev.mas_height);
    }];
    
    return self;
}

- (void)configCellByData:(CDChatMessage)data table:(CDChatListView *)table{
    [super configCellByData:data table:table];
    
//    [self layoutIfNeeded];
}
@end
