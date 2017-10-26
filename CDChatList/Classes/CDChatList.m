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

@property (nonatomic, weak)UIActivityIndicatorView *loadingIndicator;

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

-(UIActivityIndicatorView *)loadingIndicator{
    if (!_loadingIndicator) {
        UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loadingIndicator = indicator;
    }
    return _loadingIndicator;
}


-(void)didMoveToSuperview{
        dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD showHUDAddedTo:self animated:YES];
        });
    [self layoutSubviews];
//    self.loadingIndicator.frame = self.bounds;
//    [self addSubview:self.loadingIndicator];
//    [self.loadingIndicator startAnimating];
}


/**
 监听数据源改变

 @param msgArr 数据源
 */
-(void)setMsgArr:(NSArray<id<MessageModalProtocal>> *)msgArr{
   
    if (msgArr.count == 0) {
        _msgArr = msgArr;
        [self reloadData];
    } else {
        dispatch_async(dispatch_get_global_queue(0, 0), ^{
            
            [CellCaculator caculatorAllCellHeight:msgArr callBack:^{
                _msgArr = msgArr;
                [self reloadData];
                [MBProgressHUD hideHUDForView:self animated:YES];
                if (msgArr.count == 0) {
                    return;
                }
                // 异步让tableview滚到最底部
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSIndexPath *index = [NSIndexPath indexPathForRow:msgArr.count - 1  inSection:0];
                    [self scrollToRowAtIndexPath:index atScrollPosition:UITableViewScrollPositionBottom animated:YES];
                });
            }];
        });
    }
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
