//
//  CTMoreKeyBoard.m
//  CDChatList
//
//  Created by chdo on 2017/12/15.
//

#import "CTMoreKeyBoard.h"
#import "Utility.h"

@implementation CTMoreKeyBoard

+(instancetype)share{
    
    static dispatch_once_t onceToken;
    static CTMoreKeyBoard *single;
    
    dispatch_once(&onceToken, ^{
        single = [[CTMoreKeyBoard alloc] init];
        single.backgroundColor = [UIColor blueColor];
        single.frame = CGRectMake(0, 0, ScreenW(), ScreenH() * 0.3);
    });
    return single;
}

+(CTMoreKeyBoard *)keyBoard{
    return [CTMoreKeyBoard share];
}



@end
