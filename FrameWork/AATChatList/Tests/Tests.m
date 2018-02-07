//
//  Tests.m
//  Tests
//
//  Created by chdo on 2018/2/5.
//  Copyright © 2018年 aat. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "CDChatList.h"

#import "MsgModel.h"
#import "CellCaculator.h"

@interface Tests : XCTestCase

@end

@implementation Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    
}

- (void)testPerformanceExample {
    
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:50];
    
    for (int i = 0; i < 50; i++) {
        MsgModel *model = [[MsgModel alloc] init];
        model.msg = @"12341234aoisjfoisjdfoij";
        [arr addObject:model];
    }
    
    [self measureBlock:^{
        for (MsgModel *model in arr) {
            CGSize size =  [CellCaculator sizeForTextMessage:model];
        }
    }];
}

-(NSString *)randomStr{
    
}

@end
