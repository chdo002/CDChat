//
//  ChatHelpr.m
//  CDChatList
//
//  Created by chdo on 2017/11/17.
//

#import "ChatHelpr.h"

@interface ChatHelpr()
@property(nonatomic, strong) NSMutableDictionary<NSString*, UIImage *> *emojDic;
@end

@implementation ChatHelpr

+(instancetype)share{
    static dispatch_once_t onceToken;
    static ChatHelpr *helper;
    dispatch_once(&onceToken, ^{
        helper = [[ChatHelpr alloc] init];
    });
    return helper;
}

+(void)loadImageDic: (NSMutableDictionary<NSString*, UIImage *> *)emjDic{
    [ChatHelpr share].emojDic = emjDic;
}

#pragma mark  表情替换
+(NSDictionary *)emoticonDic {
    
    if ([ChatHelpr share].emojDic) {
        return [ChatHelpr share].emojDic;
    }
    
    static NSMutableDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 表情bundle地址
        NSString *emojiBundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Expression.bundle"];
        // 表情键值对
        NSDictionary<NSString *, id> *temp = [[NSDictionary alloc] initWithContentsOfFile:[emojiBundlePath stringByAppendingPathComponent:@"files/expressionImage_custom.plist"]];
        // 表情图片bundle
        NSBundle *bundle = [NSBundle bundleWithPath:emojiBundlePath];
        dic = [NSMutableDictionary dictionary];
        for (NSString *imagName in temp.allKeys) {
            UIImage *img = [UIImage imageNamed:temp[imagName] inBundle:bundle compatibleWithTraitCollection:nil];
            [dic setValue:img forKey:imagName];
        }
    });
    return dic;
}

@end
