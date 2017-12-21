//
//  Macro.h
//  PAIMTest
//
//  Created by linshengqin on 15/6/11.
//  Copyright (c) 2015年 linshengqin. All rights reserved.
//

#ifndef PAIMTest_Macro_h
#define PAIMTest_Macro_h
//条件编译，ChatViewController需要
#define CHATVIEWCONTROLLER

#if __IPHONE_OS_VERSION_MAX_ALLOWED > __IPHONE_7_1
#define RequestAlwaysAuthorization(a) [a requestAlwaysAuthorization]
#else
#define RequestAlwaysAuthorization(a) ((void)0)
#endif

#define PACHATLocalizedString(nonstring) [NSString locationString:nonstring]

#define kIOSVersions [[[UIDevice currentDevice] systemVersion] floatValue] //获得iOS版本
#define kScreenWidth          [[UIScreen mainScreen] bounds].size.width           //(e.g. 320)
#define kScreenSize           [[UIScreen mainScreen] bounds].size                 //(e.g. 320,480)
#define kScreenHeight  (kIOSVersions>=7.0 ? [[UIScreen mainScreen] bounds].size.height + 64 : [[UIScreen mainScreen] bounds].size.height)
#define ScreenHeight  [[UIScreen mainScreen] bounds].size.height  //屏幕高度
#define kBackgroudColor       [UIColor colorWithRed:239.0f/255.0f green:239.0f/255.0f blue:245.0f/255.0f alpha:1.0f]
#define kUIWindow    [[[UIApplication sharedApplication] delegate] window] //获得window
#define kApplicationHeight    [[UIScreen mainScreen] applicationFrame].size.height//不包含状态bar的高度(e.g. 460)
#define kTableRowTitleSize       14
#define kContentHeight           (kApplicationHeight - kNavigationBarHeight)
#define kNavigationBarHeight     44
#define kShowGropInfo                       @"ShowGropInfo"                       //显示群组
#define kGroupId                            @"kGroupId"                           //群id
#define kIOS7OffHeight (kIOSVersions>=7.0 ? 64 : 0)
#define maxPopLength             215
#define kTabBarHeight            49
/*========聊天发布的内容长度限制=======*/
#define CONTENTMAXLENGTH 2000
#define kNavigationheightForIOS7 64
#define MAXIMAGECOUNT 9
#define kStatusBarHeight         20
#define kSwitchButtonTintColor   [UIColor orangeColor]
#define kButtonFontSize       [UIFont systemFontOfSize:19]            //按钮字体大小
#define kBlackFontAndAlpha(fontAlpha)   [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:fontAlpha]                                                        //黑色字体,透明度
#define kUnderStatusBarStartY (kIOSVersions>=7.0 ? 20 : 0)                 //7.0以上stautsbar不占位置，内容视图的起始位置要往下20
#define kTextFontSize         [UIFont systemFontOfSize:16]            //正文字体大小
#define kStatementFontSize    [UIFont systemFontOfSize:12]            //陈述字体大小


//群消息通知
#define kNotificationSetGroupNotice                   @"kNSetGroupNoticeRequest"              //群公告消息
#define kNotificationOfAcceptRoom                   @"kAcceptRoomRequest"              //群邀请接受消息
#define kNotificationDeleteMemberSuccess            @"DeleteMemberSuccess"              //删除群成员成功
#define kNotifyConversationRefreshed            @"kNotifyConversationRefreshed"             //消息会话刷新
#define kNotifyMessageStateChanged         @"kNotifyMessageStateChanged"        //消息发送状态更新
#define kApplicationTerminateNotification   @"kApplicationTerminateNotification"  //程序结束保存数据
#define kNotifyOfflineMessageStart @"kNotifyOfflineMessageStart"
#define kNotifyOfflineMessageOver            @"kNotifyOfflineMessageOver"             //离线消息获取完通知
#define kNotifyNewFriendBadgeNumberRefreshed    @"kNotifyNewFriendBadgeNumberRefreshed"   //新朋友badge通知
#define kHttpNetworkConnected               @"kHttpNetworkConnected"
#define kNetworkConnecting                 @"kNetworkConnecting"
#define kPersistLoginFailed                 @"persistLoginFailed"                       //持续登陆失败
#define kNotificationOfChangeGroupNameSuccess        @"changeGroupNamesuccss"            //群名称修改成功
#define kNotifyUpdateFriend                     @"kNotifyUpdateFriend"                     //更新好友
#define kNotifyThrowBackChangeInfo                      @"kNotifyThrowBackChangeInfo"               //返回增量好友的信息
#define kNotifyDownloadMessageRefresh         @"kNotifyDownloadMessageRefresh"        //图片,视频 ,语音消息(下载成功后,通知bubblechat刷新界面)
#define kNotifyNewMessageRemindSetting     @"kNotifyNewMessageRemindSetting" //新消息通知
#define kNotificationOfGetDisscusionName            @"observerdisscussioname"          //监测讨论组名称
#define kNotifyConversationBadgeNumberRefreshed @"kNotifyConversationBadgeNumberRefreshed"  //未读消息刷新
#define KUpdateGroupMemberProgress                  @"updateGroupMemberProgress"        //群成员消息
#define kNotifyMessageInsert               @"kNotifyMessageInsert"              //插入消息
#define kNotifyMessageDeleted              @"kNotifyMessageDeleted"             //消息删除
#define kNotifyChatSettingBackground       @"kNotifyChatSettingBackground"      //设置聊天背景
#define kNotifyAddGroupByOtherPeople       @"kNotifyAddGroupByOtherPeople"      //被加入群的通知，便于刷新右侧按钮
#define kNotificationOfOutRoom                      @"outofroombyothers"                //自己被人踢出群组
#define kNotificationShowNickName          @"showNickName"
#define kDismissAllModelView  @"kDismissAllModelView"
#define kNetworkDisconnect                  @"kNetworkDisconnect"            //网络断开
#define kTerminateCurPlaying                @"kTerminateCurPlaying"        //终止语音播放
#define kNotifyModifyRemarkNameSuccess     @"kNotifyModifyRemarkNameSuccess"    //修改备注名成功
#define kNotificationGroupInviteMember              @"kNotificationGroupInviteMember"  //加入群notify消息
#define kNotifyNewFriendRefreshed               @"kNotifyNewFriendRefreshed"              //新朋友通知
#define kSynchGroupSuccess                           @"kSynchGroupSuccess"             //同步单个群群成员成功（版本号为0）
#define kSyncGroupInfoFinished                      @"kSyncGroupInfoFinished"        //群信息同步请求完成通知

//添加好友确定button notification
#define kAddFriendConfirmNotification           @"kAddFriendNotification"
#define kAddFriendCancelNotification            @"kAddFriendCanceNotification"
#define PAPushIntoBlacklist                     @"PushIntoBlacklist"                     //拉入黑名单
#define PARemoveFromBlacklist                   @"RemoveFromBlacklist"                   //移除黑名单
#define PAIsPushIntoBlacklist                   @"isPushIntoBlacklist"                   //是否拉入黑名单
#define kNotificationOfChangRoomNickName            @"changeroomnicknamesuccess"        //修改群昵称成功
#define kNotificationOfCreateRoomFail               @"createroomfail"                   //创建群组失败
#define kNotifyLoginSuccess                     @"kNotifyLoginSuccess"                      //登录成功
#define kNotifyFriendDetailRefreshed            @"kNotifyFriendDetailRefreshed"            //修改好友详情
#define kNotifyFinishedCountChange                  @"ios03knorifyfinishcountchange"       //修改个人信息成功
#define kNotifyRemoveBackListSuccess @"RemoveBackListSuccess"                   //移出黑名单成功
#define kNotifyRemoveBackListFail    @"RemoveBackListFail"                      //移出黑名单失败
#define kNotifiLogout                       @"NotifiLogout"               //退出登录成功


//直播间功能
#define kNotifyRoomInfoChangeRefreshed            @"kNotifyRoomInfoChangeRefreshed"            //修改直播间列表
#define kNotifyRoomAnchorChange            @"kNotifyRoomAnchorChange"            //修改直播间主播
#endif

#define kUpdateLoadingIndicatorFromRoster @"updateLoadingIndicatorFromRoster" //同步联系人进度，object=1为全部完成

#define kNotifyConversationBadgeNumberSingleRefreshed @"kNotifyConversationBadgeNumberSingleRefreshed" //单个会话未读数更新

#define kImageMessageUseLimitSize // 聊天图片cell显示是否使用限制Size，注释此行不使用

#define kNetConnectTimeOut 2 //网络连接超时

#define kGroupNoticeCommand @"GROUP_NOTICE_CREATED"

//搜索取消按钮的颜色
#define IMSearchMainColor [UIColor colorWithRed:252.0f/255.0f green:105.0f/255.0f blue:33.0f/255.0f alpha:1.0f]

typedef NS_ENUM(NSUInteger, RETURN_CODE_TYPE){
    RETURN_CODE_SUCCESS = 200,  //操作成功
    RETURN_CODE_OPERATION_FAILED = 601,   //操作失败
    RETURN_CODE_PARAM_ERROR = 602,   //参数不合法或不正确
    RETURN_CODE_USER_NOT_EXIST = 605,       //用户不存在
    
    RETURN_CODE_LOGIN_SESSION_INVALID_606 = 606,    //loginsession错误
    RETURN_CODE_LOGIN_SESSION_INVALID_611 = 611,
    RETURN_CODE_LOGIN_SESSION_INVALID_1111 = 1111,
    
    RETURN_CODE_OPERATE_TOO_FAST = 888,     //操作频繁
    RETURN_CODE_WAIT_FOR_MINUTE = 889,       //操作频繁，稍后重试
    RETURN_CODE_NOT_ANCHOR = 4000,  //非直播间主播
    RETURN_CODE_CAN_NOT_CANCEL = 4001,     //直播间主播不能取消关注直播间
    RETURN_CODE_SPEAKING_FORBIDED = 4002,       //直播间成员被禁言
    RETURN_CODE_ROOM_NOT_EXIST = 4003,        //直播间不存在
    RETURN_CODE_ANCHOR_NOT_EXIST = 4004,        //主播不存在
    RETURN_CODE_INVALID_SOURCESYS = 4005,       //sourcesys与直播间sourcesys不对应
    RETURN_CODE_AUDIENCE_FULL = 4006,           //超出 关注／直播间在线 的最大数量
    RETURN_CODE_TEXT_TOO_LONG = 4007,           //文字字符长度过长
    RETURN_CODE_FORBIDDED_WORD = 4008           //发言包含敏感词
};
