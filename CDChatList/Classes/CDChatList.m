//
//  CDChatList.m
//  CDChatList
//
//  Created by chdo on 2017/10/25.
//

#import "CDChatList.h"

#import "CDTextTableViewCell.h"

@interface CDChatList()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation CDChatList


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    
    self.backgroundColor = [UIColor blackColor];
    self.dataSource = self;
    self.delegate = self;
    self.msgArr = [NSArray array];
    [self registerClass:[CDTextTableViewCell class] forCellReuseIdentifier:@"cell"];
    return self;
}



/**
 监听数据源改变

 @param msgArr 数据源
 */
-(void)setmsgArr:(NSArray *)msgArr{
    _msgArr = msgArr;
    
    [self reloadData];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell<MessageCellProtocal> *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _msgArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [CDTextTableViewCell heightForMessage];
}


@end
