//
//  PAIMApiFriends.h
//  PAIM_Demo
//
//  Created by Dmq on 15/5/15.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAIMApiFriendModel.h"
/*!
 @protocol PAIMApiFriendsDelegate
 @discussion 好友关系接口的Delegate
 */
@protocol PAIMApiFriendsDelegate <NSObject>
@optional
/*!
 *  查询好友成功
 *
 *  @param model 返回的好友model
 */
-(void)queryFriendSucceed:(PAIMApiFriendModel *)model;
/*!
 *  查询好友失败
 *
 *  @param errorMsg 返回的失败信息
 */
-(void)queryFriendFailed:(NSString *)errorMsg;
/*!
 *  加好友返回结果
 *
 *  @param result 成功or失败
 */
-(void)addFriendCallBack:(BOOL)result;
/*!
 *  删除好友返回结果
 *
 *  @param result 成功or失败
 */
-(void)deleteFriendCallBack:(BOOL)result;
/*!
 *  加入黑名单返回结果
 *
 *  @param result 成功or失败
 */
-(void)addToBlacklistCallBack:(BOOL)result;
/*!
 *  移除黑名单返回结果
 *
 *  @param result 成功or失败
 */
-(void)removeFromBlacklistCallBack:(BOOL)result;

/*!
 *  设置备注名
 *
 *  @param result 成功or失败
 */
-(void)setFriendNicknameResult:(BOOL)result;

/*!
 *  获取变更通讯录回调
 *
 *  @param changeFriends 变更通讯录数组[PAIMApiFriendModel, *]
 *  @param sPageNo 服务器返回页码
 *  @param sTotalPage 服务器返回总页数
 *  @param sVersion 服务器返回版本号
 *  @param error 错误信息
 */
- (void)queryChangeFriendsResult:(NSArray<PAIMApiFriendModel *> *)changeFriends sPageNo:(int)sPageNo sTotalPage:(int)sTotalPage sVersion:(NSString *)sVersion error:(NSError *)error;

@end

/*!
 @class PAIMApiMessage
 
 @abstract 好友关系接口.
 
 */
@interface PAIMApiFriends : NSObject
/*!
 @property
 @abstract PAIMApiFriends代理
 */
@property (nonatomic,assign) id<PAIMApiFriendsDelegate> delegate;
/*!
 *  获取好友列表
 *
 *  @return 返回字典 包含［状态（YES为成功、NO为失败）、好友数据（一个model数据类型的数组）］
 */
-(NSDictionary *)getFriendsList;
/*!
 *  获取黑名单列表
 *
 *  @return 返回字典 包含［状态（YES为成功、NO为失败）、黑名单数据（一个model数据类型的数组）］
 */
-(NSDictionary *)getBlackList;
/*!
 *  根据jid获取好友详情
 *
 *  @param friendID 用户jid
 *
 *  @return 返回model数据
 */

+ (PAIMApiFriendModel *)fetchFriendInfoByFriendID:(NSString *)friendID;
/*!
 *   根据手机号查询好友
 *
 *  @param phoneNum 手机号
 *
 */
-(void)queryFriendWithPhoneNum:(NSString *)phoneNum;
/*!
 *  根据customID查找好友
 *
 *  @param coustomId 用户id
 *  @param sourcesys 用户系统来源
 */
-(void)queryFriendwithCustomID:(NSString *)coustomId sourcesys:(NSString *)sourcesys;

/**
 查询用户信息
 
 @param userName im的用户id
 */
-(void)queryUserInfoWithUserName:(NSString *)userName;

/**
 查询用户信息
 
 @param userName im的用户id
 @param fromServer YES:直接从服务器查
 @param completeBlock 完成回调(PAIMApiFriendModel, NSError)
 */
- (void)queryUserInfoWithUserName:(NSString *)userName fromServer:(BOOL)fromServer completeBlcok:(void(^)(PAIMApiFriendModel *friendModel, NSError *error))completeBlock;

/*!
 *  根据用户JID加好友
 *
 *  @param friendJid 用户jid
 *  @param nickName  用户备注名
 *
 */
-(void)addFriendWithFriendJID:(NSString *)friendJid withNickName:(NSString *)nickName;
/*!
 *  根据customid加好友
 *
 *  @param customID  用户id
 *  @param sourcesys 用户系统来源
 */
-(void)addFriendWithCustomID:(NSString *)customID sourcesys:(NSString *)sourcesys;
/*!
 *  根据jid删除好友（从服务端删除）
 *
 *  @param friendJid 好友的jid
 */
-(void)deleteFriendWithFriendJID:(NSString *)friendJid;
/*!
 *  根据jid从本地数据库删除好友
 *
 *  @param friendJid 好友jid
 */
+(BOOL)deleteFriendFromLocalDBWithJID:(NSString *)friendJid;
/*!
 *  根据jid设置备注名
 *
 *  @param nickName  备注名
 *  @param friendJid 好友jid
 */
-(void)setFriendNickname:(NSString *)nickName withFriendJID:(NSString *)friendJid;
/*!
 *  加入黑名单
 *
 *  @param friendJid 好友jid
 */
-(void)addToBlacklistWithJID:(NSString *)friendJid;
/*!
 *  移除黑名单
 *
 *  @param friendJid 好友jid
 */
-(void)removeFromBlacklistWithJID:(NSString *)friendJid;
/*!
 *  查询是否是黑名单好友
 *
 *  @param  friendID 好友ID
 *
 *  @return YES      黑名单好友
 */
+(BOOL)isBlackFriend:(NSString *)friendID;
/*!
 *  从缓存获取好友详情
 *
 *  @param  friendID            好友jid
 *
 *  @return PAIMApiFriendModel* 好友model
 */
+(PAIMApiFriendModel *)fetchFriendInfoFromCacheByFriendID:(NSString *)friendID;
/*!
 *  将好友mod加入缓存中
 *
 *  @param friendID   好友jid
 *  @param friendInfo 好友model
 */
+(void)addToCacheWithFriendID:(NSString *)friendID andFriendInfo:(PAIMApiFriendModel *)friendInfo;
/**
 *  获取好友详情
 *
 *  @param friendID 好友JID
 *
 *  @return PAIMApiFriendModel* 好友model
 */
+(PAIMApiFriendModel *)fetchFriendInfoFromCacheAndDBByFriendID:(NSString *)friendID;

/*!
 *  获取通讯录版本号
 *
 *  @return NSString 通讯录版本号
 */
+ (NSString *)getContactVesion;

/**
 *  获取变更通讯录信息
 *
 *  @param version 版本号
 *  @param pageNo 当前页码
 *  @param pageSize 每页多少条
 */
- (void)queryChangeFriendsWithContactVesion:(NSString *)version pageNo:(NSUInteger)pageNo pageSize:(NSUInteger)pageSize;

#pragma mark - NewFriend
/**
 *  获取新朋友列表
 *
 *  @param  index  表示数据库起始查询索引
 *  @param  count  表示从索引开始的需要查询的个数
 *  @return 新朋友列表
 */
+(NSArray*)fetchNewFriendList:(NSInteger)index withCount:(NSInteger)count;

/**
 *  获取新朋友列表的人数
 *
 *  @param isTotoal YES：所有，NO：状态 2和4之间
 *  @return 新朋友列表的人数
 */
+(NSInteger)getNewFriendCount:(BOOL)isTotoal;

/**
 *  更新新朋友bageNumber为零
 *
 *  @return success
 */
+(BOOL)setNewFriendBadgeNumberZero;

/**
 *  计算新朋友bageNumber
 *
 *  @return badge
 */
+(NSUInteger)getNewFriendBadgeNumber;

/**
 *  删除新朋友
 *
 *  @param jid 删除新朋友jid
 *
 *  @return success
 */
+(BOOL)deleteNewFriendbyJID:(NSString *)jid;

/*!
 *  添加新好友验证
 *
 *  @param jid 好友JID。Jid由用户username+"@"+域名组成。
 *  @param finish 操作结果 YES:成功 NO:失败
 */
+ (void)addNewFriendWithJid:(NSString *)jid completionBlock:(void (^)(BOOL result, NSError *error))finish;

@end
