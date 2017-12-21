//
//  PAIMUrlInterface.h
//  PAIM_Demo
//
//  Created by dumingqin on 15/4/23.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, UrlWithKey)
{
    LoginUrl,                    //登录url
    HostUrl,
    HostSpaceName,
    PublicSpaceName,
    ConferenceHost,
    PATXTNumLoginUrl,//天下通账号登录
    PAUserMixQueryURL,//用户混合查询
    PAQueryUserstatusURL,//查询好友状态
    PAGetUserInfoURL,//获取用户信息
    PAQueryOwnInfoURL,//同步用户信息
    PAUserEditURL,//用户信息修改
    PAEditrosternickURL,//修改好友备注名
    PAHttpSendMessageURL,//http发送消息
    PAHttpChagepushmodeURL,//http方式改变推送模式接口
    PAHttpRemoveOLMessageURL,//清理已拉取离线消息接口
    PAHttpRemoveOLineMessageURL,//清理已拉取在线消息接口
    PASyncRosterHttpURL,//联系人列表同步接口
    PAHttpGetOLineMessageURL,//拉取在线消息接口
    PASyncOfflineMsg,//获取离线消息接口
    PARemoveOfflineMsgNew,//移除离线新消息通知
    PAUserTokenSessionUrl,//持续登陆
    PANewBatchRosterDenyUrl,//清空新朋友推荐
    AddFriend_URL,//添加好友
    AddFriendVerificationUrl,// 验证好友
    RemoveRosterUrl,// 删除好友
    QueryNearbyListUrl,// 附近的人
    CancelNearbyLocationUrl,// 清楚附近的人
    QueryFootPrintUrl,// 查询服务器状态
    kAddToOrRemoveBlackList_URL,// 添加/移出黑名单
    QueryFriendValidateMsgUrl,//查询添加好友验证消息
    queryincrementrosterUrl,//拉取好友
    queryrosterUrl,//分页拉取好友
    offlineMessageUrL,//拉取离线消息
    removeOfflineMessageURL,//移除离线消息
    FriendDetailURL,//联系人详情
    UpLoadPhoneListURL,//上传通讯录url
    NewbatchrosterdenyURL,//批量拒绝好友
    FriendRecommendURL,//好友推荐(可能认识的人,平安有缘人)
    kCreatGroupURL,                  //创建群同时邀请好友进群
    kGroupListURL,                   //群列表
    kMemberListURL,                   //群成员列表
    kInviteJoinGroupURL,             //邀请好友进群
    kMemberJoinGroupURL,            //成员加入群
    kMemberQuitGroupURL,            //成员主动退出群
    kKickMemberURL,                      //移除群聊
    kUpdateGroupNameURL,          //修改群名称
    kUpdateNickNameURL,            //修改群昵称
    kSetPortraitURL,                   //设置群头像
    kGroupInfoURL,                   //获取群信息
    PAIncrementMembersHttpsURL,           //增量获取群成员
    kSYNCGROUP_MEMBER ,                   //增量获取群成员(新版)
    kSYNCGROUPLISTURL,                //增量获取群成员列表的接口
    kGroupMsgRemindSwitch,              //群消息提醒开关
    kGroupadrBookGroupSwitch,           //群保存到通讯录开关
    kGetAdrBookGroupList,               //获取已经保存到通讯录的群列表
    kGetMemberInfos,                    //获取群成员信息
    kSynGroupAndMemberInfo,             //同步群成员(new)
    kSynGroupAllChangeInfo,             //同步群变更过的信息
    kqueryAllPrivilege,
    ksetup,
    kquerydisturb,
    ksetupnodisturb,
    PAGetServerTime,                   //获取服务器时间
    kExptionOfflineMessageURL,
    PUBLIC_HOSTURL,
    publiclistURL,
    publicCustomizableListURL,
    publicAlbumURL,
    publicSearchURL,
    publiclistAssociateURL,
    publicAFMPAccountURL,                //批量关注公众号
    PAsyncPublicLinkUserURL,
    PAUpdateMySubAccountVersion,             //同步公众号
    k_API_KEY,
    HostPort,
    TalkingDataAppID,//talkingdata监控appID
    PAGetVersionsHttpURL,//获取版本信息
    kQiniutokenHttpsURL, // 获取七牛token
    kGetGroupSettingInfo,//获取群设置信息
    KgetGroupVersion, //获取群版本号
    PALogoutURL,//退出登录
    PAQueryCustomUserURL,//查询第三方用户信息
    PAAddFriendWithCustomIdURL,//根据customID加好友
    QueryHistoryUrl,//查询公众号历史消息
};

@interface PAIMUrlInterface : NSObject

/**
 *  初始化URL变量
 *
 */
+(void)initURLData;

/**
 *  通过key值找出相应的URL变量
 *
 *  @param key 需要找出的URL对应对Key值
 */
+(NSString*)findEnvUrl:(UrlWithKey)key;

@end
