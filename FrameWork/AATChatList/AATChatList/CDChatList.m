//
//  CDChatList.m
//  CDChatList
//
//  Created by chdo on 2017/10/25.
//

#import "CDChatList.h"
#import "CDTextTableViewCell.h"
#import "CDImageTableViewCell.h"
#import "CDSystemTableViewCell.h"
#import "CDAudioTableViewCell.h"
#import "CellCaculator.h"
#import "CDChatMacro.h"
#import "CTClickInfo.h"
#import "ChatHelpr.h"
#import "AATUtility.h"

typedef enum : NSUInteger {
    CDHeaderLoadStateInitializting, // 界面初始化中
    CDHeaderLoadStateNoraml,        // 等待下拉加载
    CDHeaderLoadStateLoading,       // 加载中
    CDHeaderLoadStateFinished,      // 加载结束
} CDHeaderLoadState;

#define LoadingH  50

@interface CDChatList()<UITableViewDelegate, UITableViewDataSource>
{
    CGFloat originInset;
    CGFloat pullToLoadMark; // 下拉距离超过这个，则开始计入加载方法
}
@property(assign, nonatomic) CDHeaderLoadState loadHeaderState;
@property(weak,   nonatomic) UIActivityIndicatorView *indicatro;

@end

@implementation CDChatList

#pragma mark 生命周期
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.delegate = self;
    self.dataSource = self;
    self.estimatedRowHeight = 0;
    self.estimatedSectionHeaderHeight = 0;
    self.estimatedSectionFooterHeight = 0;
    
    self.backgroundColor =  isChatListDebug ? CRMHexColor(0xB5E7E1) : CRMHexColor(0xEBEBEB);
    if (!isChatListDebug) {
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    self.loadHeaderState = CDHeaderLoadStateInitializting;
    
    // 注册cell类
    [self registerClass:[CDTextTableViewCell class] forCellReuseIdentifier:@"textcell"];
    [self registerClass:[CDImageTableViewCell class] forCellReuseIdentifier:@"imagecell"];
    [self registerClass:[CDSystemTableViewCell class] forCellReuseIdentifier:@"syscell"];
    [self registerClass:[CDAudioTableViewCell class] forCellReuseIdentifier:@"audiocell"];
    // 下拉loading视图
    CGRect rect = CGRectMake(0, -LoadingH, ScreenW(), LoadingH);
    UIActivityIndicatorView *indicatr = [[UIActivityIndicatorView alloc] initWithFrame:rect];
    indicatr.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self addSubview:indicatr];
    [indicatr startAnimating];
    self.indicatro = indicatr;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:CHATLISTDOWNLOADLISTFINISH object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:CHATLISTCLICKMSGEVENTNOTIFICATION object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotification:) name:CTCLICKMSGEVENTNOTIFICATION object:nil];
    return self;
}

-(void)didMoveToSuperview{
    UIViewController *viewController =  self.viewController;
    if (self.viewController) {
        viewController.automaticallyAdjustsScrollViewInsets = NO;
        //适配
        if (@available(iOS 11, *)) {
            self.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        pullToLoadMark = -LoadingH;
        if (viewController.navigationController) {
            originInset = NaviH() - self.frame.origin.y;
            self.scrollIndicatorInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        } else {
            originInset = 0;
        }
    }
    if (!self.superview) {
        return;
    }
}

#pragma mark 通知
-(void)receiveNotification:(NSNotification *)noti{
    
    if ([noti.name isEqualToString:CHATLISTDOWNLOADLISTFINISH]) {
        // 下载图片完成通知
        CDChatMessage msgData = noti.object;
        [self updateMessage:msgData];
        
    } else if ([noti.name isEqualToString:CHATLISTCLICKMSGEVENTNOTIFICATION]) {
        
        // 点击消息中可点击区域的通知
        ChatListInfo *info = noti.object;
        if (info.eventType == ChatClickEventTypeIMAGE){
            CGRect cellRect = [info.containerView.superview convertRect:info.containerView.frame toView:self];
            info.msgImageRectInTableView = cellRect;
            if ([self.msgDelegate respondsToSelector:@selector(chatlistClickMsgEvent:)]) {
                [self.msgDelegate chatlistClickMsgEvent:info];
            }
        }
    } else if ([noti.name isEqualToString:CTCLICKMSGEVENTNOTIFICATION]){
        CTClickInfo *info = noti.object;
        ChatListInfo *chatInfo = [ChatListInfo eventFromChatListInfo:info];
        if (chatInfo){
            [self.msgDelegate chatlistClickMsgEvent:chatInfo];
        }
    }
}

#pragma mark 数据源变动

/**
 监听数据源改变
 
 @param msgArr 数据源
 */
-(void)setMsgArr:(CDChatMessageArray)msgArr{
    
    [self configTableData:msgArr completeBlock:^(CGFloat totalHeight){
            
        [self relayoutTable:NO];
        
        // 小于tableview高度时，不出现loading，不可下拉加载
        if (self.bounds.size.height >= totalHeight) {
            self.loadHeaderState = CDHeaderLoadStateFinished;
        } else {
            self.loadHeaderState = CDHeaderLoadStateNoraml;
            CGFloat newTopInset = LoadingH + originInset;
            CGFloat left = self.contentInset.left;
            CGFloat right = self.contentInset.right;
            CGFloat bottom = self.contentInset.bottom;
            [self setContentInset:UIEdgeInsetsMake(newTopInset, left, right, bottom)];
        }
    }];
}

/**
 更新数据源中的某条消息
 
 @param message 消息
 */
-(void)updateMessage:(CDChatMessage)message{
    
    // 找到消息ID
    NSInteger msgIndex = -1;
    for (int i = 0; i < _msgArr.count; i++) {
        if ([message.messageId isEqualToString:_msgArr[i].messageId]) {
            msgIndex = i;
            break;
        }
    }
    if (msgIndex < 0) return;
    if (!_msgArr) return;
    
    // 更新数据源
    NSMutableArray *mutableMsgArr = [NSMutableArray arrayWithArray:_msgArr];
    [mutableMsgArr replaceObjectAtIndex:msgIndex withObject:message];
    _msgArr = [mutableMsgArr copy];
    
    // 若待更新的cell在屏幕上方，则可能造成屏幕抖动，需要手动调回contentoffset
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:msgIndex inSection:0];
    CGRect rect_old = [self rectForRowAtIndexPath:index]; // cell所在位置
    CGFloat cellOffset = rect_old.origin.y + rect_old.size.height;
    CGPoint contentOffset = self.contentOffset;
    BOOL needAdjust = cellOffset < contentOffset.y;
    
    [self reloadData];
    if (needAdjust) {
        CGRect rect_new = [self rectForRowAtIndexPath:index]; // cell新的位置
        CGFloat adjust = rect_old.size.height - rect_new.size.height;
        [self setContentOffset:CGPointMake(0, self.contentOffset.y - adjust)];
    }
}

/**
 添加新的数据到底部
 */
-(void)addMessagesToBottom: (CDChatMessageArray)newBottomMsgArr{
    
    if (!_msgArr) {
        _msgArr = [NSMutableArray array];
    }
    
    NSMutableArray *arr = [NSMutableArray arrayWithArray:_msgArr];
    [arr addObjectsFromArray:newBottomMsgArr];
    
    [self configTableData:arr completeBlock:^(CGFloat totalHeight){
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
    [self mainAsyQueue:^{
        
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
    }];
}

-(void)setLoadHeaderState:(CDHeaderLoadState)loadHeaderState{
    
    if (loadHeaderState == CDHeaderLoadStateFinished) {
        UIEdgeInsets inset = UIEdgeInsetsMake(originInset, 0, 0, 0);
        [self setContentInset:inset];
        [self.indicatro stopAnimating];
    }
    _loadHeaderState = loadHeaderState;
}

#pragma mark UI变动

/**
 table滚动到底部

 @param animated 是否有动画
 */
-(void)relayoutTable:(BOOL)animated{
    if (_msgArr.count == 0) {
        return;
    }
    //
    if (self.tracking) {
        return;
    }
    
    // 异步让tableview滚到最底部
//    [self mainAsyQueue:^{
        NSIndexPath *index = [NSIndexPath indexPathForRow:_msgArr.count - 1  inSection:0];
        [self scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:animated];
//    }];
}


-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.dragging) {
        [[NSNotificationCenter defaultCenter] postNotificationName:CDChatListDidScroll object:nil];
    }
    
    CGFloat offsetY = self.contentOffset.y;
    if (offsetY >= pullToLoadMark) {
        return;
    }
    
    //  判断在普通状态，则进入加载更多方法
    if (self.loadHeaderState == CDHeaderLoadStateNoraml && scrollView.isDragging) {
        // 将当前状态设为加载中
        self.loadHeaderState = CDHeaderLoadStateLoading;
        
        // 当前最旧消息传给代理，调用获取上一段旧消息的方法
        CDChatMessage lastMsg = _msgArr.firstObject;
        if (![self.msgDelegate respondsToSelector:@selector(chatlistLoadMoreMsg: callback:)]) {
            return;
        }
        
        [self.msgDelegate chatlistLoadMoreMsg:lastMsg callback:^(CDChatMessageArray newMessages) {
           
            if (!_msgArr) {
                _msgArr = [NSMutableArray array];
            }
            
            if (!newMessages || newMessages.count == 0) {
                self.loadHeaderState = CDHeaderLoadStateFinished;
            }
            
            // 将旧消息加入当前消息数据中
            NSMutableArray *arr = [NSMutableArray arrayWithArray:newMessages];
            [arr addObjectsFromArray:_msgArr];
            // 计算消息高度
            [CellCaculator caculatorAllCellHeight:arr callBackOnMainThread:^(CGFloat totalHeight)
            {
                // 全部消息重新赋值
                _msgArr = arr;
                
                // 记录刷新table前的contentoffset.y
                CGFloat oldOffsetY = self.contentOffset.y;
                
                //刷新table
                [self reloadData];
                
                // 新消息的总高度
                CGFloat newMessageTotalHeight = 0.0f;
                for (int i = 0; i < newMessages.count; i++) {
                    newMessageTotalHeight = newMessageTotalHeight + _msgArr[i].cellHeight;
                }
                
                // 重新回到当前看的消息位置(把loading过程中，table的offset计算在中)
                [self setContentOffset:CGPointMake(0, newMessageTotalHeight + oldOffsetY)];
                
                // 异步调用
//                [self mainAsyQueue:^{
                    // 判断是否要结束下拉加载功能
//                    if (newMessages.count < 10) {
//                        self.loadHeaderState = CDHeaderLoadStateFinished;
//                    } else {
                        self.loadHeaderState = CDHeaderLoadStateNoraml;
//                    }
//                }];
            }];
        }];
    }
}

#pragma mark table 代理
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CDChatMessage data = _msgArr[indexPath.row];
    NSString *cellType = @"textcell";
    switch (data.msgType) {
        case CDMessageTypeImage:
            cellType = @"imagecell";
            break;
        case CDMessageTypeSystemInfo:
            cellType = @"syscell";
            break;
        case CDMessageTypeAudio:
            cellType = @"audiocell";
            break;
        default:
            cellType = @"textcell";
            break;
    }
    
    UITableViewCell<MessageCellProtocal> *cell = [tableView dequeueReusableCellWithIdentifier: cellType];
    [cell configCellByData:data];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _msgArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    CGFloat height = [CellCaculator fetchCellHeight:indexPath.row of:_msgArr];
    return height;
}

-(void)mainAsyQueue:(dispatch_block_t)block{
    dispatch_async(dispatch_get_main_queue(), ^{
        block();
    });
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


@end
