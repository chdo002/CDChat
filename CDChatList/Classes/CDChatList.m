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

#define LoadingH  50

@interface CDChatList()<UITableViewDelegate, UITableViewDataSource>
{
    BOOL isLoadingMore; // 是否正在下拉加载状态中
}

/**
 是否可以下拉加载
 
 默认不可以，
 数据加载完成后可以
 
 */
@property(assign, nonatomic) BOOL canloadMore;

@end

@implementation CDChatList

#pragma mark 生命周期
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = CRMHexColor(0x808080);
    self.dataSource = self;
    self.delegate = self;
    
    self.canloadMore = false;
    isLoadingMore = false;
    
    [self registerClass:[CDTextTableViewCell class] forCellReuseIdentifier:@"cell"];
    
    // 下拉loading视图
    CGRect rect = CGRectMake(0, -LoadingH, scrnW, LoadingH);
    UIActivityIndicatorView *indicatro = [[UIActivityIndicatorView alloc] initWithFrame:rect];
    [self addSubview:indicatro];
    [indicatro startAnimating];
    
    return self;
}

-(void)didMoveToSuperview{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD showHUDAddedTo:self animated:YES];
    });
    [self layoutSubviews];
}


#pragma mark 数据源变动

/**
 监听数据源改变
 
 @param msgArr 数据源
 */
-(void)setMsgArr:(NSArray<id<MessageModalProtocal>> *)msgArr{
    
    [self configTableData:msgArr completeBlock:^{
        [MBProgressHUD hideHUDForView:self animated:YES];
        [self relayoutTable:NO];
    }];
}


/**
 添加数据到顶部
 */
-(void)addMessagesToTop: (NSArray<id<MessageModalProtocal>> *)newTopMsgArr{
    // 新消息有10个 则有可能还有新消息，否则就不可以加载了
    self.canloadMore = newTopMsgArr.count == 10;
    
    
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


/**
 所有table数据源修改，最终都会走这里
 更新tableData数据，计算所有cell高度，并reloadData

 @param msgArr 新的消息数组
 @param callBack 完成回调
 */
-(void)configTableData:(NSArray<id<MessageModalProtocal>> *)msgArr completeBlock:(void(^)(void))callBack{
    
    self.canloadMore = NO;
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

-(void)setCanloadMore:(BOOL)canloadMore{
    _canloadMore = canloadMore;
    CGFloat newTopInsert = canloadMore ? self.contentInset.top + LoadingH : self.contentInset.top;
    [self setContentInset:UIEdgeInsetsMake(newTopInsert, 0, 0, 0)];
}

#pragma mark UI变动

/**
 table滚动到底部

 @param animated 是否有动画
 */
-(void)relayoutTable:(BOOL)animated{
    if (self.msgArr.count == 0) {
        return;
    }
    //
    if (self.tracking) {
        return;
    }
    // 异步让tableview滚到最底部
    dispatch_async(dispatch_get_main_queue(), ^{
        NSIndexPath *index = [NSIndexPath indexPathForRow:self.msgArr.count - 1  inSection:0];
        [self scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:animated];
        
//        for (id<MessageModalProtocal>data in self.msgArr) {
//        }
//        CGFloat newOffset = self.contentSize.height - self.frame.size.height;
//        NSLog(@"到底%d",newOffset);
//        if (newOffset > 0) {
//            [self setContentOffset:CGPointMake(0, newOffset) animated:animated];
//        }
    });
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = self.contentOffset.y;
    CGFloat insetTop = self.contentInset.top;
    
    CGFloat minus = insetTop + offsetY;
    
    if (minus < LoadingH) {
        NSLog(@"keyil");
    }
}

#pragma mark table 代理
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
//    return 50;
    return [CellCaculator fetchCellHeight:_msgArr[indexPath.row]];
}


@end
