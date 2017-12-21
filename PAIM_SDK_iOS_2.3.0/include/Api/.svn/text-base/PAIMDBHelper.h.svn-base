//
//  PAIMDBHelper.h
//  PAIM_Demo
//
//  Created by xionglu on 17/3/7.
//  Copyright © 2017年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAIMApiFriendModel.h"
#import "PAIMApiMessageModel.h"

@interface PAIMDBHelper : NSObject

/*!
 *  插入好友模型到数据库 （数据库存在会做覆盖操作）
 *
 *  @param model  好友模型
 *
 *  @return 插入返回 YES：成功  NO：失败
 */
+(BOOL) insertFriendModel:(PAIMApiFriendModel *)model;

/*!
 *  本地删除好友
 *
 *  @param jid 好友jid
 *
 *  @return YES：成功  NO：失败
 */
+(BOOL) deleteFriendWithJid:(NSString *)jid;

/*!
 *  创建群，数据库插入群信息
 *
 *  @param groupInfo   群信息
 *                                          groupId   必填
 *                                          groupName 选填
 *                                          groupType   选填 默认0
 *                                          maxUsers     选填 默认200
 *                                          createTime  时间戳格式
 *  @param memberJids 群成员jid
 *
 *  @return YES：成功  NO：失败
 */
+(BOOL) insertGroupWithInfo:(NSDictionary *)groupInfo memberJids:(NSArray *)memberJids;

/*!
 *  添加群成员
 *
 *  @param memberIdList  群成员Id（用户JID）
 *  @param groupId    群id
 *
 *  @return YES：成功  NO：失败
 */
+(BOOL) insertMembers:(NSArray *)memberIdList intoGroup:(NSString *)groupId;

/*!
 *  删除群成员
 *
 *  @param jid     成员Jid
 *  @param groupId 群Id
 *
 *  @return YES：成功  NO：失败
 */
+(BOOL)deleteMember:(NSString *)jid fromGroup:(NSString *)groupId;

/*!
 *  退出群
 *
 *  @param groupId 群id
 *
 *  @return YES：成功  NO：失败
 */
+(BOOL) quitGroupWithGid:(NSString *)groupId;
/*!
 *  本地数据库插入消息，若没有回话会自动生成回话
 *
 *  @param messageModel 消息模型
 *
 *  @return YES：成功  NO：失败
 */
+(BOOL) insertMessage:(PAIMApiMessageModel *)messageModel;
@end
