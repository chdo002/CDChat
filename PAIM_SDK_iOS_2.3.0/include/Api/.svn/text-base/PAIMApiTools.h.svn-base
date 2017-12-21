//
//  PAIMApiTools.h
//  PAIM_Demo
//
//  Created by Dmq on 15/6/10.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PAIMApiMessageModel.h"
#import <CoreLocation/CoreLocation.h>
/*!
 @class PAIMApiTools
 
 @abstract 工具类.
 
 */
@interface PAIMApiTools : NSObject

/*!
 *  获取自己的jid
 *
 *  @return 返回jid
 */
+(NSString *)getMyJID;
/*!
 *  获取自己的username
 *
 *  @return 返回username
 */
+(NSString *)getMyUserName;
/*!
 *   获取当前的loginSession
 *
 *  @return 返回loginSession
 */
+(NSString *) getLoginSession;
/*!
 *  设置cookie
 */
+(void)setCookie;
/*!
 *  设置userAgent
 */
+(void)setUserAgent;
/*!
 *  获取最后登录用户的信息
 *
 *  @return 返回一个字典类型的用户信息
 */
+(NSDictionary *)getLastLoginUserInfo;
/*!
 *  设置要发送消息model
 *
 *  @param model 消息model
 */
+(void)setSendMessageModel:(PAIMApiMessageModel *)model;
/*!
 *  是否播放消息声音（默认播放声音）
 *
 *  @param play YES:播放 NO:不播放
 */

+(void)playMessageSound:(BOOL)play;
/*!
 *  被@好友jid数组
 *
 *  @param 无
 */
+(NSMutableArray *)getRemindFriendUserName;

/*!
 *  往数组中增加被@好友的jid
 *
 *  @param friendUserName 被@好友的jid
 */
+(void)setRemindFriendUserName:(NSString *)friendUserName;

/*!
 *  被@好友的昵称数组
 *
 *  @param 无
 */
+(NSMutableArray *)getRemindFriendNameArr;

/*!
 *  往数组中增加被@好友的昵称
 *
 *  @param  friendName 被@好友的昵称
 */
+(void)setRemindFriendNameArr:(NSString *)friendName;

/*!
 *  GPS坐标系转换
 *
 *  @param  yGps 转换前的经度
 */
+(CLLocationCoordinate2D)paimTransGPS:(CLLocationCoordinate2D)yGps;

/*!
 *  获取消息大图的URL
 *
 *  @param model 消息模型
 */
+(void) requestLargePhotoUrlForMessageModel:(PAIMApiMessageModel *)msgModel completion:(void (^)(PAIMApiMessageModel *model,NSString *url,NSError *error))aCompletion;

/*!
 *  设置通知免打扰
 *
 *  @param enabled YES:开启免打扰   NO:关闭免打扰
 *  @param finish  操作结果  YES:成功   NO:失败
 */
+ (void) setDNDServiceEnabled:(BOOL)enabled    finish:(void (^)(BOOL result,NSError *error))finish;

/*!
 *   查询通知免打扰的是否开启
 *
 *  @param finish  error为nil查询成功  isON（YES:开启   NO:关闭）
 */
+ (void) queryDNDServiceIsEnabledWithFinish:(void (^)(BOOL isON,NSError *error))finish;

/*!
 *   查询加我为好友是需要验证是否开启
 *
 *  @param finish isON（YES:开启   NO:关闭）
 */
+ (void)queryFriendValidateIsEnabledWithFinish:(void (^)(BOOL isON,NSError *error))finish;

/*!
 *   设置加我为好友是需要验证是否开启
 *
 *  @param enable YES:开启   NO:关闭
 *  @param finish  操作结果  YES:成功   NO:失败
 */
+ (void)setupFriendValidateIsEnabled:(BOOL)enable finish:(void (^)(BOOL result,NSError *error))finish;

@end
