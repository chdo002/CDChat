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
#import <MBProgressHUD/MBProgressHUD.h>

@interface CDChatList()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation CDChatList


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
//    self.backgroundColor = CRMHexColor(0xC0C0C0);
    
    self.backgroundColor = [UIColor whiteColor];
    self.dataSource = self;
    self.delegate = self;
    [self registerClass:[CDTextTableViewCell class] forCellReuseIdentifier:@"cell"];
        
    return self;
}

-(void)didMoveToSuperview{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:self animated:YES];
    });
    [self layoutSubviews];
}


/**
 更新tableData数据，计算所有cell高度，并reloadData

 @param msgArr 新的消息数组
 @param callBack 完成回调
 */
-(void)configTableData:(NSArray<id<MessageModalProtocal>> *)msgArr completeBlock:(void(^)(void))callBack{
    dispatch_async(dispatch_get_main_queue(), ^{
        if (msgArr.count == 0) {
            _msgArr = msgArr;
            [self reloadData];
            callBack();
        } else {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [CellCaculator caculatorAllCellHeight:msgArr callBackOnMainThread:^{
                    _msgArr = msgArr;
                    [self reloadData];
                    callBack();
                }];
            });
        }
    });
}

/**
 监听数据源改变

 @param msgArr 数据源
 */
-(void)setMsgArr:(NSArray<id<MessageModalProtocal>> *)msgArr{
//    [self addMessagesToBottom:msgArr];
    
    [self configTableData:msgArr completeBlock:^{
        [MBProgressHUD hideHUDForView:self animated:YES];
        [self relayoutTable:NO];
    }];
}


/**
 添加数据到顶部
 */
-(void)addMessagesToTop: (NSArray<id<MessageModalProtocal>> *)newTopMsgArr{
    
}

/**
 添加新的数据到底部
 */
-(void)addMessagesToBottom: (NSArray<id<MessageModalProtocal>> *)newBottomMsgArr{
    
    if (!self.msgArr) {
        _msgArr = [NSMutableArray array];
    }
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.msgArr];
    [arr addObjectsFromArray:newBottomMsgArr];
    
    [self configTableData:arr completeBlock:^{
        [MBProgressHUD hideHUDForView:self animated:YES];
        [self relayoutTable:YES];
    }];
}

-(void)relayoutTable:(BOOL)animated{
    if (self.msgArr.count == 0) {
        return;
    }
    // 异步让tableview滚到最底部
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *index = [NSIndexPath indexPathForRow:self.msgArr.count - 1  inSection:0];
        [self scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:animated];
    });
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell<MessageCellProtocal> *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    id<MessageModalProtocal> data = self.msgArr[indexPath.row];
    [cell configCellByData:data];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _msgArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [CellCaculator fetchCellHeight:_msgArr[indexPath.row]];
}


@end
