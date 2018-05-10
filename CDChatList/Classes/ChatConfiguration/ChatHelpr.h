//
//  ChatHelpr.h
//  CDChatList
//
//  Created by chdo on 2017/11/17.
//

#import <Foundation/Foundation.h>
#import "ChatConfiguration.h"

@interface ChatHelpr : NSObject

@property(nonatomic, class, readonly, strong) ChatHelpr *share;

#pragma mark 图片资源
@property(nonatomic, strong) NSDictionary<NSString*, UIImage *> *emojDic;
@property(nonatomic, strong) NSDictionary<NSString*, UIImage *> *imageDic;

#pragma mark 组件配置相关
@property(nonatomic, strong) ChatConfiguration *config;

@end
