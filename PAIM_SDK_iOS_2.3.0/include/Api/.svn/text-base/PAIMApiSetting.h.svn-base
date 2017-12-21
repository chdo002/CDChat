//
//  PAIMApiSetting.h
//  PAIM_Demo
//
//  Created by ShiMac on 15/5/14.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, SET_TPYE) {

    SET_SUCCESS     ,     //设置成功
    SET_ERRORPARAM  ,     //参数错误
    SET_ERRORSERVICE,     //服务器异常
    SET_BINDED      ,     //号码被自己绑定
    SET_OCCUPIED    ,     //该号码已被占用
    SET_INCORRECTFORMAT,  //电话号码格式非法
};

@protocol PAIMApiSettingDelegate;

@interface PAIMApiSetting : NSObject

/*!
 *  修改个人信息  
 *  
 *  nil不修改  ""清空  其他修改
 *
 *  @param name           昵称
 *  @param realName       真实姓名
 *  @param phoneNum       手机号码
 *  @param sex            性别
 *  @param region         地区
 *  @param albumFilePath  头像   支持本地文件地址和网络链接图片地址
 *  @param signature      签名
 */
-(void)setUserInfoName:(NSString *)name
              realName:(NSString *)realName
          mobillephone:(NSString *)phoneNum
                   sex:(NSString *)sex
                region:(NSString *)region
         albumFilePath:(NSString *)albumFilePath
             signature:(NSString *)signature;

@property(nonatomic,assign)id<PAIMApiSettingDelegate> delegate;

@end

@protocol PAIMApiSettingDelegate <NSObject>

/*!
 *  设置个人信息回调
 */
@required
-(void)settingUserInfoCallBack:(SET_TPYE)state apiModel:(PAIMApiFriendModel *)model;
@end
