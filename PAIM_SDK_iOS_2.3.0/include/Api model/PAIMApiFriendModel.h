//
//  PAIMApiFriendModel.h
//  PAIM_Lib
//
//  Created by chenshaojie on 15/5/21.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PAIMApiFriendModel : NSObject

@property (nonatomic, strong) NSString* friendID;
@property (nonatomic, strong) NSString* name;            //昵称
@property (nonatomic, strong) NSString* nickName;        //备注名
@property (nonatomic, strong) NSString* heartID;         //心号
@property (nonatomic, strong) NSString* sex;             //性别
@property (nonatomic, strong) NSString* albumUrl;        //头像url
@property (nonatomic, strong) NSString* mobilePhone;     //手机
@property (nonatomic, strong) NSString* signature;       //个性签名
@property (nonatomic, strong) NSString* region;          //地区
@property (nonatomic, strong) NSString* fullPinYin;      //联系人拼音（根据界面显示来，存备注名或者昵称）
@property (nonatomic, strong) NSString* sectionName;     //联系人SectionName(用于tableView index Name)
@property (nonatomic, assign) FRIEND_TYPE friendType;    //好友类型｛正常/黑名单..）
@property (nonatomic, assign) CHAT_TYPE userType;        //用户类型

@property (nonatomic,retain) NSString *userRole; //人员组织架构信息
@property (nonatomic,retain) NSString *authstatus; //用户状态 比如 0:在职、1:离职
@property (nonatomic, strong) NSString* customId;
/*********以下为公众账号属性********/
@property (nonatomic, strong) NSDate *createTime;
@property (nonatomic, strong) NSDate *updateTime;
@property (nonatomic, strong) NSString* describe;        //公共帐号说明
@property (nonatomic, assign) BOOL hidden;               //公众账号是否隐藏(主要是“身边”这个功能的公众号与普通公众号一起返回，用hidden来作标记)
@property (nonatomic, assign) BOOL enable;                //是否启用公众账号，1.启用    0.禁用
@property (nonatomic, assign) CancelAttention_Status cancelAttentionStatus; //是否显示取消关注按钮 0:显示 1:不显示

/*********以下为群成员属性********/
@property (nonatomic, strong) NSString* groupID;         //所在群id
@property (nonatomic, strong) NSString* groupNickName;   //所在群昵称
@property (nonatomic, strong) NSString* role;            //role 角色 10：群主 20: 非群主
@property (nonatomic, assign) NSUInteger groupType;      //群类型
@property (nonatomic, assign) Member_status memberStatus;    //激活状态


/**
 *  初始化与个人相关信息
 *
 *  @param friendID           friendID
 *   */
- (id)initWithFriendID:(NSString *)friendID
            friendName:(NSString *)friendName
              nickName:(NSString *)nickName
              albumUrl:(NSString *)albumUrl
           mobilePhone:(NSString *)mobilePhone
             signature:(NSString *)signature
                region:(NSString *)region
            friendType:(FRIEND_TYPE)friendType
              userType:(CHAT_TYPE)userType
                   sex:(NSString *)sex;


/**
 *  初始化与群相关信息
 *
 *  @param friendID           friendID
 *   */
- (id)initWithFriendID:(NSString *)friendID
            friendName:(NSString *)friendName
              nickName:(NSString *)nickName
              albumUrl:(NSString *)albumUrl
           mobilePhone:(NSString *)mobilePhone
             signature:(NSString *)signature
                region:(NSString *)region
            friendType:(FRIEND_TYPE)friendType
              userType:(CHAT_TYPE)userType
               groupID:(NSString *)groupID
         groupNickName:(NSString *)groupNickName
                  role:(NSString *)role
             groupType:(NSUInteger)groupType
          memberStatus:(Member_status)memberStatus
                   sex:sex;

/**
 *  初始化与公众号相关信息
 *
 *  @param friendID           friendID
 *   */
- (id)initWithFriendID:(NSString *)friendID
            friendName:(NSString *)friendName
              nickName:(NSString *)nickName
              albumUrl:(NSString *)albumUrl
           mobilePhone:(NSString *)mobilePhone
             signature:(NSString *)signature
                region:(NSString *)region
            friendType:(FRIEND_TYPE)friendType
              userType:(CHAT_TYPE)userType
                   sex:(NSString *)sex
              describe:(NSString *)describe
                hidden:(BOOL)hidden
                enable:(BOOL)enable;


- (NSString *)getChatUserName;

- (NSString *)getNameToDisplay;

- (NSString *)jid2user;

@end
