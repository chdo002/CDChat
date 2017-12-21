//
//  PAIMLib.h
//  PAIMLib
//
//  Created by chenshaojie on 15/4/22.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface PAIMLib : NSObject

+ (PAIMLib *)share;

/**
 * 设置AppId
 *
 *  @param appId  为当前宿主分配的AppId的值
 */
- (void)setAppId:(NSString *)appId;

/**
 * 设置Debug日志的开关
 *
 *  @param isLog 表示日志是否打开的标志
 */
- (void)openDebugLog:(BOOL)isLog;

/**
 * 设置环境变量(老域名)
 *
 *  @param environment 设置应用系统的环境变量  0为开发 1为测试 2为生产
 */
- (void)setEnv:(NSInteger)environment;


/**
 设置环境变量
 
 @param environment 设置应用系统的环境变量  0为开发 1为测试 2为生产
 @param isNew 是否使用新域名
 */
- (void)setEnv:(NSInteger)environment useNewDomain:(BOOL)isNew;

/**
 * 获取环境变量
 *
 *  @param  0为开发 1为测试 2为生产
 */
- (NSInteger)getEnv;

/**
 * 设置deviceID
 *
 *  @param deviceID [TalkingData getDeviceID]
 */
-(void)setDeviceID:(NSString*)deviceID;

/**
 * 设置resourceType
 *
 *  @param resourceType
 */
-(void)setResourceType:(NSString*)resourceType;

/*!
 *  是否启动自动登录  app启动时自动登录
 *
 *  @param on YES : 开启   NO:不开启   默认NO
 */
-(void) autoLogin:(BOOL)on;

/*!
 *  开启自动持续登录（前后台切换、网络切换、app重启时自动触发持续登录）可在登录成功回调方法中设置
 *
 *  @param on YES : 开启   NO:不开启   默认NO
 */
-(void) openAutoPersistLogin:(BOOL)on;

/**
 * 获取版本号
 *
 *  @param 无
 */
- (NSString *)getVersionString;

/**
 * 根据登陆用户信息
 * 判断是否持续登陆
 *
 */
- (BOOL) haveUserLoginInfo;

/**
 *
 * 清除用户信息
 *
 */
- (void) clearUserLoginInfo;

/*!
 *  是否关闭声音提醒
 *
 *  @param off YES:关闭  NO:开启  默认:NO
 */
-(void) closeSoundReminder:(BOOL)off;

/*!
 *  是否关闭震动提醒
 *
 *  @param off YES:关闭  NO:开启 默认:NO
 */
-(void) closeVibrateReminder:(BOOL)off;

/*!
 *  振动提醒是否开启
 *
 *  @return YES:开启  NO:关闭
 */
-(BOOL) isMessageVibrateReminderOn;

/*!
 *  声音提醒是否开启
 *
 *  @return YES:开启  NO:关闭
 */
-(BOOL) isMessageSoundReminderOn;

/*!
 *  加我为好友时需要验证是否开启
 *
 *  @return YES:开启  NO:关闭
 */
-(BOOL) isAddFriendVerifyReminderOn;

/*!
 *  加我为好友时需要验证 功能是否开启
 *
 *  @return YES:开启  NO:关闭
 */
- (BOOL)isOpenVerifyFriendRelationship;

/**
 设置sourceSys
 
 @param sys <#sys description#>
 */
- (void)setSourceSys:(NSString *)sys;
@end
