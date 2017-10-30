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

typedef enum : NSUInteger {
    CDHeaderLoadStateInitializting, // 界面初始化中
    CDHeaderLoadStateNoraml,        // 等待下拉加载
    CDHeaderLoadStateLoading,       // 加载中
    CDHeaderLoadStateFinished,      // 加载结束
} CDHeaderLoadState;

#define LoadingH  50

@interface CDChatList()<UITableViewDelegate, UITableViewDataSource>
{
    CGFloat originTopInsert;
}
@property(assign, nonatomic) CDHeaderLoadState loadHeaderState;

@end

@implementation CDChatList

#pragma mark 生命周期
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = CRMHexColor(0x808080);
    self.dataSource = self;
    self.delegate = self;
    
    self.loadHeaderState = CDHeaderLoadStateInitializting;
    
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

#pragma mark 原始TopInsert
-(void)configOriginTopInsert: (CGFloat)topInsert{
    if (!originTopInsert) {
        originTopInsert = topInsert;
    }
}

-(CGFloat)fetchOriginTopInsert{
    if (originTopInsert) {
        return originTopInsert;
    } else {
        return 0;
    }
}

#pragma mark 数据源变动

/**
 监听数据源改变
 
 @param msgArr 数据源
 */
-(void)setMsgArr:(CDChatMessageArray)msgArr{
    
    [self configTableData:msgArr completeBlock:^(CGFloat totalHeight){
        
        [MBProgressHUD hideHUDForView:self animated:YES];
        
        [self relayoutTable:NO];
        
        // 小于tableview高度时，不出现loading，不可下拉加载
        if (self.bounds.size.height >= totalHeight) {
            self.loadHeaderState = CDHeaderLoadStateFinished;
        } else {
            self.loadHeaderState = CDHeaderLoadStateNoraml;
            CGFloat newTopInset = self.contentInset.top + LoadingH;
            CGFloat left = self.contentInset.left;
            CGFloat right = self.contentInset.right;
            CGFloat bottom = self.contentInset.bottom;
            [self setContentInset:UIEdgeInsetsMake(newTopInset, left, right, bottom)];
        }
    }];
}
//
///**
// 添加数据到顶部
// */
//-(void)addMessagesToTop: (CDChatMessageArray)newTopMsgArr {
//
//    if (!self.msgArr) {
//        _msgArr = [NSMutableArray array];
//    }
//
//    NSMutableArray *arr = [NSMutableArray arrayWithArray:newTopMsgArr];
//    [arr addObjectsFromArray:self.msgArr];
//
//    [self configTableData:arr completeBlock:^(CGFloat totalHeight){
//       [MBProgressHUD hideHUDForView:self animated:YES];
//    }];
//}

/**
 添加新的数据到底部
 */
-(void)addMessagesToBottom: (CDChatMessageArray)newBottomMsgArr{
    
    if (!self.msgArr) {
        _msgArr = [NSMutableArray array];
    }
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:self.msgArr];
    [arr addObjectsFromArray:newBottomMsgArr];
    
    [self configTableData:arr completeBlock:^(CGFloat totalHeight){
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
-(void)configTableData: (CDChatMessageArray)msgArr
         completeBlock: (void(^)(CGFloat))callBack{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if (msgArr.count == 0) {
            _msgArr = msgArr;
            [self reloadData];
            callBack(0);
        } else {
            dispatch_async(dispatch_get_global_queue(0, 0), ^{
                [CellCaculator caculatorAllCellHeight:msgArr callBackOnMainThread:^(CGFloat totalHeight) {
                    _msgArr = msgArr;
                    [self reloadData];
                    callBack(totalHeight);
                }];
            });
        }
    });
}

-(void)setLoadHeaderState:(CDHeaderLoadState)loadHeaderState{
    
    if (loadHeaderState == CDHeaderLoadStateFinished) {
        CGFloat newTopInset = self.contentInset.top - LoadingH;
        CGFloat left = self.contentInset.left;
        CGFloat right = self.contentInset.right;
        CGFloat bottom = self.contentInset.bottom;
        [self setContentInset:UIEdgeInsetsMake(newTopInset, left, right, bottom)];
    }
    _loadHeaderState = loadHeaderState;
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
    });
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = self.contentOffset.y;
    CGFloat insetTop = self.contentInset.top;
    
    CGFloat minus = insetTop + offsetY;
    if (minus > LoadingH) {
        return;
    }
    
//    if (self.dragging) {
//        return;
//    }
    
    if (self.loadHeaderState == CDHeaderLoadStateNoraml) {
        self.loadHeaderState = CDHeaderLoadStateLoading;
        
        CDChatMessage lastMsg = self.msgArr.lastObject;
        
        [self.msgDelegate loadMoreMsg:lastMsg callback:^(CDChatMessageArray newMessages) {
            if (newMessages.count < 10) {
                self.loadHeaderState = CDHeaderLoadStateFinished;
            } else {
                self.loadHeaderState = CDHeaderLoadStateNoraml;
            }
            
            if (!self.msgArr) {
                _msgArr = [NSMutableArray array];
            }
        
            NSMutableArray *arr = [NSMutableArray arrayWithArray:newMessages];
            [arr addObjectsFromArray:self.msgArr];
            
            [self configTableData:arr completeBlock:^(CGFloat totalHeight){
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    NSIndexPath *index = [NSIndexPath indexPathForRow:newMessages.count inSection:0];
//                    [self scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionTop animated:NO];
//                });
                
                [CellCaculator caculatorAllCellHeight:arr callBackOnMainThread:^(CGFloat totalHeight) {
//                    _msgArr = msgArr;
//                    [self reloadData];
//                    callBack(totalHeight);
                    self.msgArr = arr;
                    NSMutableArray *newIndexs = [NSMutableArray array];
                    for (int i = 0; i < newMessages.count;  i++) {
                        NSIndexPath *idx = [NSIndexPath indexPathForRow:i inSection:0];
                        [newIndexs addObject:idx];
                    }
                    [self insertRowsAtIndexPaths:[newIndexs copy] withRowAnimation:UITableViewRowAnimationBottom];
                }];
            }];
            
        }];
    }
}

#pragma mark table 代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell<MessageCellProtocal> *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    CDChatMessage data = self.msgArr[indexPath.row];
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
