//
//  PAIMMessageDataType.h
//  PAIM_Lib
//
//  Created by chenshaojie on 15/5/18.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#ifndef PAIM_Lib_Header_h
#define PAIM_Lib_Header_h

/*!
 @abstract 消息类型定义
 @constant MESSAGE_TEXT           普通文本消息 0
 @constant MESSAGE_IMAGE          图片消息 1
 @constant MESSAGE_VOICE          语音消息 2
 @constant MESSAGE_VIDEO          视频消息 3
 @constant MESSAGE_LOCATIONIMAGE  地理位置消息 4
 @constant MESSAGE_FRIENDCARD     名片消息 5
 @constant MESSAGE_DYNADICFACE    动态表情 6
 @constant MESSAGE_PUBLICAD       公共帐号广告 7
 @constant MESSAGE_MENUEVENT      公共菜单操作命令 8
 @constant MESSAGE_HYPERLINK      带超链接的文本消息 9
 @constant MESSAGE_WEBVIEW        webview显示链接 10
 @constant MESSAGE_PROMPT         提示消息加入群等
 @constant MESSAGE_TEMPLATE       模板消息 12
 @constant MESSAGE_SINGLE         单图文消息 13
 @constant MESSAGE_TESTGAME       测试游戏 14
 @constant MESSAGE_ORDER          出单消息 15
 @constant MESSAGE_CONGRATS       发送祝福消息 16
 @constant MESSAGE_BIRTHDAY       生日祝福消息/新人入司 17
 @constant MESSAGE_ASKLICAI       问理财消息 18
 @constant MESSAGE_THIRDPARTY     第三方消息 19 //15到18在老版本中有使用，所以这里从19开始
 @constant MESSAGE_EXTEND         扩展消息 20
 @constant MESSAGE_LIVE_NOTICE    直播间公告
 @constant MESSAGE_BILLING        系统通知类型(如开单)，不加入聊天
 */
typedef NS_ENUM(NSUInteger, MESSAGE_TYPE) {
    MESSAGE_TEXT,           
    MESSAGE_IMAGE,          
    MESSAGE_VOICE,          
    MESSAGE_VIDEO,          
    MESSAGE_LOCATIONIMAGE,  
    MESSAGE_FRIENDCARD,     
    MESSAGE_DYNADICFACE,    
    MESSAGE_PUBLICAD,       
    MESSAGE_MENUEVENT,      
    MESSAGE_HYPERLINK,      
    MESSAGE_WEBVIEW,        
    MESSAGE_PROMPT,         
    MESSAGE_TEMPLATE,       
    MESSAGE_SINGLE,         
    MESSAGE_TESTGAME,       
    MESSAGE_ORDER,          
    MESSAGE_CONGRATS,       
    MESSAGE_BIRTHDAY,       
    MESSAGE_ASKLICAI,
    MESSAGE_THIRDPARTY = 19,
    MESSAGE_EXTEND,
    MESSAGE_LIVE_NOTICE,
    MESSAGE_BILLING = 23,
};

/*!
 @abstract 聊天类型
 @constant CHAT               点对点聊天
 @constant GROUP_CHAT         群聊
 @constant PUBLIC             公众帐号,或者固定群
 @constant PUBLIC_MENU        公众帐号（特殊键盘
 @constant LIVE_ROOM        直播间聊天
 @constant INTERACTION_ROOM        互动区聊天
 */
typedef NS_ENUM(NSUInteger, CHAT_TYPE) {
    CHAT,
    GROUP_CHAT,   //增加群成员
    PUBLIC,                  
    PUBLIC_MENU,
    INITGROUP_CHAT,//发起群聊
    LIVE_ROOM = 99,
    INTERACTION_ROOM
};


/*!
 @abstract 发送、接收标志
 @constant PROTO_SEND       发
 @constant PROTO_RECEIVE    收
 */
typedef NS_ENUM(NSUInteger, MSG_PROTO) {
    PROTO_SEND,           
    PROTO_RECEIVE         
};

/*!
 @abstract 消息发送状态类型定义
 @constant MESSAGE_STATE_Normal 消息默认状态
 @constant MESSAGE_SENDING      消息发送中
 @constant MESSAGE_SUCCESS      消息发送成功
 @constant MESSAGE_FAILED       消息发送失败
 */
typedef NS_ENUM(NSUInteger, MESSAGE_STATE) {
    MESSAGE_STATE_Normal = 0,
    MESSAGE_SENDING=1,      
    MESSAGE_SUCCESS,        
    MESSAGE_FAILED
};


/*!
 @abstract Cell类型
 @constant kChatCell                  普通聊天Cell
 @constant kProfileNotifyCell         未设置头像提示Cell
 @constant kContactCell               联系人Cell
 */
typedef NS_ENUM(NSUInteger, ChatCellType) {
    kChatCell,                  
//    kProfileNotifyCell,         
//    kContactCell
};

/*!
 @abstract 联系人类型
 @constant FRIEND_ISNORMAL      正常联系人
 @constant FRIEND_ISBLACKED     黑名单联系人
 @constant FRIEND_ISDELETED     联系人已被删除
 @constant FRIEND_ISUNKOWN      未知联系人
 */
typedef NS_ENUM(NSUInteger, FRIEND_TYPE) {
    FRIEND_ISNORMAL,         
    FRIEND_ISBLACKED,        
    FRIEND_ISDELETED,        
    FRIEND_ISUNKOWN
};


/*!
 @abstract 下载类型
 @constant DOWNLOAD_THUMBNAILS          缩略图
 @constant DOWNLOAD_VIDEOFRAME          视频第一帧
 @constant DOWNLOAD_ORIGINAL            全量
 */
typedef NS_ENUM(NSUInteger, DOWNLOAD_STYLE) {
    DOWNLOAD_THUMBNAILS,                 
    DOWNLOAD_VIDEOFRAME,                 
    DOWNLOAD_ORIGINAL
};


/*!
 @abstract 群类型
 @constant Normal_group   普通群
 @constant Work_group     内置工作群
 @constant Employer_group 平安员工群
 */
typedef NS_ENUM(NSUInteger, Room_group) {
    Normal_group = 0,
    Work_group = 1,
    Employer_group = 2,
    Default_group = 30
};


/*!
 @abstract 设置群名称状态
 @constant GroupName_Auto         自动设置群名称
 @constant GroupName_NotAuto      不自动设置群名称
 */
typedef NS_ENUM(NSInteger,Group_nameStatus)
{
    GroupName_Auto,         
    GroupName_NotAuto
};

/*!
 @abstract 群成员激活状态
 @constant Status_acitvated  激活
 @constant Status_dead       未激活
 */
typedef NS_ENUM(NSUInteger, Member_status) {
    Status_acitvated,
    Status_dead
};

/*!
 @abstract 聊天键盘类型
 @constant NORMAL_TYPE 文字输入
 @constant VOICE_TYPE  语音输入
 */
typedef NS_ENUM(NSUInteger, PreKeyboardType) {
    NORMAL_TYPE,
    VOICE_TYPE
};

//消息已读状态类型定义
typedef NS_ENUM(NSUInteger, READ_STATE) {
    MESSAGE_READ,               //消息已读
    MESSAGE_UNREAD,             //消息未读
    MESSAGE_AUDIO_UNREAD        //语音消息未读
};

typedef NS_ENUM(NSUInteger, Message_From_Type) {
    Message_Normal=1,           //正常
    Message_Relay =2,           //转发
    Message_Conversation =3,    //会话
    Message_SearchResult =4,    //搜索
};

//键盘的类型
typedef NS_ENUM(NSUInteger, FaceToolType) {
    FaceToolType_Normal=0,      //普通键盘
    FaceToolType_Public,        //公众帐号键盘
    FaceToolType_LiveRoom       //直播间帐号键盘
};

typedef NS_ENUM(NSUInteger,PasteType){
    Paste_Text,
    Paste_Image,
    Paste_Voice,
    Paste_Location,
};

typedef NS_ENUM(NSUInteger,StrangerWaringType) {
    StrangerWaringDelete = 1, //删除的联系人
    StrangerWaringNone        //陌生人
};

typedef NS_ENUM(NSUInteger, Face_Type) {
    Face_QQ, //QQ表情
    Face_Emoji,  //产品挑选的emoji
};

//用于识别从哪里进入联系人详细
typedef NS_ENUM(NSUInteger, Detail_Type) {
    Detail_Normal=0,
    Detail_Search, // 从搜索来
    Detail_Stranger,// 局外的，陌生的
    Detail_BlackList,//从黑名单列表进入
    Detail_Group    //群
};

/*!
 @abstract 取消关注按钮显示与否
 @constant CANCELATTENTION_UNSHOW      不显示取消关注
 @constant CANCELATTENTION_SHOW        显示取消关注
 */
typedef NS_ENUM(NSInteger,CancelAttention_Status)
{
    CANCELATTENTION_SHOW,
    CANCELATTENTION_UNSHOW
};

/*!
 @abstract 取消关注按钮显示与否
 @constant LiveRoomEditPropertyEnumLiveTopic      直播间主题
 @constant LiveRoomEditPropertyEnumIntroduction   直播间简介
 @constant LiveRoomEditPropertyEnumIntroduction   直播间公告
 */
typedef NS_ENUM(NSInteger,LiveRoomModelEnum){
    LiveRoomEditPropertyEnumLiveTopic = 1,
    LiveRoomEditPropertyEnumIntroduction,
    LiveRoomEditPropertyEnumNotice
};
/*!
 @abstract 取消关注按钮显示与否
 @constant LivingRoom    直播
 @constant Interaction   互动
 */
typedef NS_ENUM(NSInteger,RoomTalkType ){
    LivingRoom = 0,
    Interaction ,
};

//新朋友类型
typedef NS_ENUM(NSUInteger, NewUserState) {
    NewUserState_noAdd = 1,     //加为好友
    NewUserState_no,            //等待验证
    NewUserState_yes,           //通过验证
    NewUserState_alreadyAdd,    //已添加
};

//好友来源
typedef NS_ENUM(NSUInteger, FriendFromType) {
    FriendFromType_Normal = 0,   // 默认值
    FriendFromType_Contact =1,   //来自手机通讯录   1
    FriendFromType_Scan,         //来自扫一扫       2
    FriendFromType_Search,       //来自搜索        3
    FriendFromType_Group,        //来自群聊       4
    FriendFromType_E_Friend,     // 橙E好友         5
    FriendFromType_Nearby,       //附近的人    6
    FriendFromType_Birthday,     //同月同日生日      7
    FriendFromType_MeanwhileWork,//同年月同月同日入公司 8
    FriendFromType_Schoolfellow, //校友             9
    FriendFromType_Fellow,       //老乡 10
    FriendFromType_CommonGroup,  //群友       11
    FriendFromType_CommonFriends,//共同好友  12
    FriendFromType_Max
};

#endif
