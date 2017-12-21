//
//  PAIMApiLiveModelUpdate.h
//  PAIM_Demo
//
//  Created by 马俊炎 on 16/8/30.
//  Copyright © 2016年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAIMApiLiveRoomModel.h"
#import "PAIMApiMessageModel.h"

@class PAIMApiAnchorInfoModel;
@interface PAIMApiLiveRoom : NSObject



/**
 *  单例，获取直播间对象
 *
 *  @return 直播间API对象实例
 */


+ (PAIMApiLiveRoom *)shareInstance;

/*!
 *  查询单个直播间详情
 *
 *  @param liveId 直播间id
 *
 *  @return 直播间详情模型
 */
-(PAIMApiLiveRoomModel *)fetchLiveRoomById:(NSString *)liveId;

/**
 *  获取所有已关注的直播间列表
 *
 *  @return 直播间列表数组
 */
- (NSArray *)fetchAllSubScribedLiveRoomList;

/**
 *  获取所有直播间列表
 *
 *  @return 直播间列表数组
 */
- (NSArray *)fetchAllLiveRoomList;

/**
 *  更新语音消息的已读状态
 *
 *  @param model 消息模型
 */
- (void)updateVoiceMessageReadState:(PAIMApiMessageModel *)model;

/**
 *  退出直播间
 *
 *  @param roomID    直播间ID
 *  @param isSuccess 操作回调
 */
- (void)quitLiveRoomWithliveId:(NSString *)liveId isSuccess:(void(^)(BOOL))isSuccess;

/**
 *  记录置顶直播间的时间
 *
 *  @param liveId    直播间ID
 */
- (BOOL)saveStickTimeWithLiveId:(NSString *)liveId;

/**
 *  取消置顶
 *
 *  @param liveId    直播间ID
 */
- (BOOL)cancelStickWithLiveId:(NSString *)liveId;

/**
 *  获取主播信息缓存
 *
 *  @param anchorUsername 主播名字
 *
 *  @return 缓存的主播信息
 */
- (PAIMApiAnchorInfoModel *)readCacheAnchorMessage:(NSString *)anchorUsername;

/**
 *  编辑直播间信息
 *
 *  @param liveId            直播间ID
 *  @param LiveRoomModelEnum 修改直播间信息类型
 *  @param content           内容
 *  @param isSuccess         操作回调
 */
- (void)modifyLiveRoomWithRoomId:(NSString *)liveId Set:(LiveRoomModelEnum)liveRoomProperty toValue:(NSString *)content isSuccess:(void(^)(BOOL))isSuccess;

/**
 *  获取主播信息详情
 *
 *  @param anchorName 主播用户名
 *  @param liveId     直播间ID
 */
- (void)queryAnthorInfoByAnthorName:(NSString *)anchorName LiveId:(NSString *)liveId resultCallBack:(void(^)(id, NSError *, NSInteger))resultCallBack;

/**
 *  获取直播间详情
 *
 *  @param liveId 直播间ID
 *
 *  @return 直播间信息模型
 */
- (void)queryLiveRoomInfoByLiveRoomId:(NSString *)liveId resultCallBack:(void(^)(id, NSError *, NSInteger))resultCallBack;


/**
 *  关注直播间
 *
 *  @param liveIds 直播间的Id
 *  @param isSuccess 是否成功回调
 */
- (void)subscribeLiveRoomByLiveId:(NSString *)liveId isSuccess:(void (^)(BOOL))isSuccess;

/**
 *  取消关注直播间
 *
 *  @param liveId 直播间ID
 *  @param isSuccess 是否成功回调
 */
- (void)unsubscribeLiveRoomByLiveId:(NSString *)liveId isSuccess:(void (^)(BOOL))isSuccess;

/**
 *  同步直播间列表
 *
 *  @param resultCallBack 数据更改
 */
- (void)synLiveRoomList:(void(^)(id,NSError *,NSInteger ))resultCallBack;

/**
 *  刷新在线、关注人数请求
 *
 *  @param liveIds 1个或多个直播间的ID
 *  @param resultCallBack 消息回调
 */
- (void)queryRefurbishNumberByLiveIds:(NSArray *)liveIds resultCallBack:(void(^)(id, NSError *, NSInteger))resultCallBack;

/**
 *  禁止发言
 *
 *  @param liveIds 直播间的Id
 *  @param username 禁止发言的username
 *  @param isSuccess 是否成功回调
 */
- (void)prohibitSpeakByLiveId:(NSString *)liveId username:(NSString *)username isSuccess:(void (^)(BOOL))isSuccess;

/**
 *  检查是否禁言
 *
 *  @param liveIds 直播间的Id
 *  @param username 检查禁言的username
 *  @param isSuccess 是否成功回调 - YES：已被禁言，NO：未禁言
 */
- (void)isProhibitSpeakByLiveId:(NSString *)liveId username:(NSString *)username isSuccess:(void (^)(BOOL))isSuccess;

/**
 *  注册直播间
 *
 *  @param   messageReciever         消息接收器，即接收消息的方法。
 *  @param   observer                消息接收器所在的类，通常传self即可。
 */
- (void)registLiveRoomMessageRecieverWithSelector:(SEL)messageReciever onObserver:(id)observer;

/**
 *  注销直播间
 *
 *  @param   observer                消息接收器所在的类，通常传self即可。
 */
- (void)resignLiveRoomMessageRecieverOnObserver:(id)observer;

/**
 *  注册互动区
 *
 *  @param   messageReciever         消息接收器，即接收消息的方法。
 *  @param   observer                消息接收器所在的类，通常传self即可。
 */
- (void)registInteractionMessageRecieverWithSelector:(SEL)messageReciever onObserver:(id)observer;

/**
 *  注销互动区
 *
 *  @param   observer                消息接收器所在的类，通常传self即可。
 */
- (void)resignInteractionMessageRecieverOnObserver:(id)observer;

/**
 *  进入直播间
 *
 *  @param liveId    直播间的ID
 *  @param type      直播间类型roomTalkType
 *  @param includeMessage  是否获取最新的消息
 *  @param isSuccess 是否成功的回调
 */
- (void)accessLiveRoomWithLiveId:(NSString *)liveId type:(RoomTalkType)type includeMessage:(BOOL)includeMessage isSuccess:(void (^)(BOOL))isSuccess;

/**
 *  同步上一页消息
 *
 *  @param liveId 直播间的Id
 *  @param type 直播间类型roomTalkType
 *  @param resultCallBack 消息回调
 */
- (void)synLiveRoomPreviousMsgByLiveId:(NSString *)liveId type:(RoomTalkType)type resultCallBack:(void(^)(id, NSError *, NSInteger))resultCallBack;

@end
