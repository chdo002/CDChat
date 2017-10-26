//
//  CDChatList.m
//  CDChatList
//
//  Created by chdo on 2017/10/25.
//

#import "CDChatList.h"
#import "CDTextTableViewCell.h"

#import "CellCaculator.h"

#import "CDChatMacro.h"

@interface CDChatList()<UITableViewDelegate, UITableViewDataSource>

{
//    dispatch_queue_t tableViewUpateQueue;
}

@end

@implementation CDChatList


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
//    tableViewUpateQueue = dispatch_queue_create("viewUpate", DISPATCH_QUEUE_SERIAL);
    
//    self.backgroundColor = CRMHexColor(0xC0C0C0);
    
    self.backgroundColor = [UIColor whiteColor];
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
-(void)setMsgArr:(NSArray<id<MessageModalProtocal>> *)msgArr{
    
    _msgArr = msgArr;
    
    

    [self reloadData];
    if (msgArr.count == 0) {
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        NSIndexPath *index = [NSIndexPath indexPathForRow:msgArr.count - 1  inSection:0];
        [self scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    });
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell<MessageCellProtocal> *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _msgArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CellCaculator fetchCellHeight:_msgArr[indexPath.row]];
}


@end
