//
//  PAIMApiLogin.h
//  PAIM_Demo
//
//  Created by Dmq on 15/5/14.
//  Copyright (c) 2015年 PA. All rights reserved.
//
typedef NS_ENUM(NSUInteger, stateType) {
    loginSucceed,        //登录成功
    ParamError,          //参数错误
    userNotExist,        //用户不存在
    operateFailed,       //操作失败
    operateTooFast,      //操作频繁
    loginFail            //登录失败
};
@protocol PAIMApiLoginDelegate <NSObject>
@optional
/*!
 *  登录回调
 *
 *  @param state 登录返回状态
 *  @param isHeadImg 是否有头像
 */
-(void)loginCallBack:(stateType)state isHeadImg:(BOOL)isHeadImg;
/*!
 *  退出登录回调
 *
 *  @param isSucceed 是否退出成功
 */
-(void)logoutCallBack:(BOOL)isSucceed;

@end

#import <Foundation/Foundation.h>

@interface PAIMApiLogin : NSObject

@property (nonatomic,assign) id<PAIMApiLoginDelegate> delegate;
/*!
 *  登录
 *
 *  @param sign  签名 （该字符串的内容为token和type组成的json字符串）
 *  @param userInfoJsonData  由customid、name、sourcesys和timestamp组成的json字符串
 *  @param isSyn 是否同步
 */
-(void)loginWithSign:(NSString *)sign WithUserInfoData:(NSString *)userInfoJsonData isSyncronize:(BOOL)isSyn;

/*!
 * 持续登录 （需在主线程调用）
 *
 * @param isSyn 是否同步
 */
- (BOOL)lastLoginWithSyncronize:(BOOL)isSyn;

/*!
 *  退出登录
 */
-(void)logout;
@end
