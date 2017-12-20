//
//  ForViewController.m
//  CDChatList_Example
//
//  Created by chdo on 2017/12/19.
//  Copyright © 2017年 chdo002. All rights reserved.
//

#import "ForViewController.h"

@interface ForViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    NSArray *arr;
}
@end

@implementation ForViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    arr = @[@"1",@"2",@"3",@"4"];
    
    

    UITableView *vv = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:vv];
    
    vv.delegate = self;
    vv.dataSource = self;
    
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    }
    
    cell.contentView.backgroundColor = [UIColor cyanColor];
    cell.textLabel.text = arr[indexPath.row];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

@end
