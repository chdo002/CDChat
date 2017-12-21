//
//  PAIMApiAppEvent.h
//  PAIM_Demo
//
//  Created by Ian on 15/5/21.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, NET_WORK_STATE)
{
    NO_NET_WORK     = 0, //无网络
    NET_WORK_WWAN   = 1, //移动运营商网络
    NET_WORK_WiFi   = 2  //WIFI
};

@protocol PAIMApiAppEventDelegate <NSObject>

@optional
/*!
 *  被其他的设备踢出
 *
 *  @param error  错误类型
 */
- (void)appLoginOutByOtherDevice:(NSError *)error;

/*!
 * APP网络状态回调
 *
 *  @param networkState  返回应用程序的网络状态
 */
- (void)appNetworkStateNotify:(NET_WORK_STATE)networkState;

@end


@interface PAIMApiAppEvent : NSObject

@property (nonatomic,assign) id<PAIMApiAppEventDelegate> logOutByOtherDeviceDelegate;


/*!
 *  创建 PAIMApiAppEvent 单例对象
 *
 *  @param deviceToken  设置推送的DeviceToken
 */
+ (PAIMApiAppEvent *)shareInstance;

/*!
 *  设置推送的DeviceToken
 *
 *  @param deviceToken  设置推送的DeviceToken
 */
-(void)setDeviceToken:(NSData *)deviceToken;

/*!
 *  设置被挤下线的Delegate
 *
 *  @param loginOutDelegate 被挤下线的Delegate
 */
-(void)setLogoutByOtherDeviceDelegate:(id<PAIMApiAppEventDelegate>)loginOutDelegate;

/*!
 *  设置有无网络的接收的Delegate
 *
 *  @param networkObserverDelegate 应用程序网络状态回调的Delegate
 */
- (void)setNetWorkStateObserver:(id<PAIMApiAppEventDelegate>)networkObserverDelegate;

/**
 *  移除相关delegate
 *
 *  @param delegate
 */
-(void)removeAppEventObserver:(id<PAIMApiAppEventDelegate>)delegate;

/*!
 *  监听持续登录状态
 *
 *  @param sBlock 返回持续登录状态、返回码
 */
-(void)listenPersistLoginState:(void (^)(BOOL isSuccess,NSInteger code))sBlock;

/**
 *  监听Socket状态接收器，object返回 成功:1 失败:-1 连接中:0
 *  @param reciever 接收器，即接收的方法。
 *  @param observer 接收器所在的类，通常传self即可。
 */
- (void)listenSocketStateRecieverWithSelector:(SEL)reciever onObserver:(id)observer;

/**
 *  移除监听Socket状态接收器
 *  @param observer 接收器所在的类，通常传self即可。
 */
- (void)removeListenSocketStateWithObserver:(id)observer;

@end
