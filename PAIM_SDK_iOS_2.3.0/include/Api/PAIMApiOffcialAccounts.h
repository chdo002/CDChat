//
//  OffcialAccountsManager.h
//  PAIM_Demo
//
//  Created by Captain_Nemo on 15/4/29.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAIMApiFriendModel.h"

typedef NS_ENUM(NSUInteger, OffcialAccountsState) {
    OffcialAccountsState_Success = 0,   //请求成功
    OffcialAccountsState_ParamError,    //输入参数错误
    OffcialAccountsState_ConnectFailed, //网络错误
    OffcialAccountsState_Other	        //服务器异常
};

@interface PAIMApiOffcialAccounts : NSObject


/*!
 *  公众号列表
 *
 *  @return 数组 － （元素为PAFriendModel）
 *
 */
+(NSArray *)officialAccountsList;


/*!
 *  关注／取消关注公众号
 *
 *  @param offcialAccountsID 公众号id
 *  @param attention YES:关注此公众号  NO:取消关注此公众号
 *  @return resultBlock（OffcialAccountsState state）类型状态
 */
+(void)attentionOfficialAccountWithModel:(PAIMApiFriendModel *)friendModel withAction:(BOOL)attention block:(void(^)(OffcialAccountsState state))resultBlock;

/*!
 *  批量关注公众号
 *
 *  @param publicAccountIdArrayList 多个公众号
 *  @return resultBlock（OffcialAccountsState state）类型状态
 */
+(void)batchAttentionOfficialAccountWithPublicAccountIdArray:(NSArray *)publicAccountIdArray  block:(void(^)(OffcialAccountsState state))resultBlock;

/*!
 *  查询公众号信息
 *
 *  @param offcialAccountsID－公众号id
 *  @return sucessBlock(PAIMApiFriendModel *friendModel)：返回公众号相关信息（元素为PAIMApiFriendModel）  failBlock(OffcialAccountsState state)类型状态
 */
+(void)offcialsAccountsDetail:(NSString*)offcialAccountsID succBlock:(void(^)(PAIMApiFriendModel *friendModel))sucessBlock failedBlock:(void (^)(OffcialAccountsState state))failBlock;


/*!
 *  搜索公众号
 *
 *  @param searchStr：搜索的关键字
 *  @return searchSuccBlock(NSArray *friendModelArray) ：搜索结果数组的元素为PAIMApiFriendModel子类对象 failBlock(OffcialAccountsState state)类型状态
 */
+(void)officialAccountsSearch:(NSString *)searchStr succBlock:(void (^)(NSArray *friendModelArray))searchSuccBlock failBlock:(void(^)(OffcialAccountsState state))failBlock;

/*!
 *  发送公众号菜单命令
 *
 *  @param reciever       消息接收者
 *  @param chatType       聊天类型
 *  @param command        聊天命令
 *  @param conversationID 聊天ID
 */
+ (void)sendCommandMessageTo:(NSString *)reciever
                    WithType:(CHAT_TYPE)chatType
                     command:(NSString *)command
              conversationID:(NSString *)conversationID;



@end
