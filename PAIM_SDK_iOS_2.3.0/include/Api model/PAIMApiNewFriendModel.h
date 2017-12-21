//
//  PAIMApiNewFriendModel.h
//  PAIMLib - 新朋友
//
//  Created by 卢逸煌(外包) on 2017/7/7.
//  Copyright © 2017年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PAIMApiNewFriendModel : NSObject

@property (nonatomic,retain) NSString *jid;             //jid
@property (nonatomic,retain) NSString* sex;             //性别
@property (nonatomic,retain) NSString* album;           //个人相册
@property (nonatomic,assign) NewUserState state;        //好友状态
@property (nonatomic,retain) NSString *name;            //名称
@property (nonatomic,retain) NSString *nickName;        //备注名
@property (nonatomic,retain) NSString *validationMsg;   //验证消息
@property (nonatomic,retain) NSString *albumUrl;        //头像
@property (nonatomic,retain) NSString* mobilePhone;     //手机
@property (nonatomic,retain) NSString* signature;       //个性签名
@property (nonatomic,retain) NSString* region;          //地区
@property (nonatomic,retain) NSString* channel;         //好友来源
@property (nonatomic,assign) READ_STATE read;           //新好友已查看
@property (nonatomic,retain) NSString* heartID;         //心号
@property (nonatomic,assign) FRIEND_TYPE friendType;    //好友类型｛正常/黑名单..）
@property (nonatomic,assign) FriendFromType source;     //来源
@property (nonatomic,strong) NSString *t_name;
@property (nonatomic,assign) NSInteger distance;
@property (nonatomic,strong) NSString *friendDescription; //来源详情(显示到UI)
@property (nonatomic,strong) NSDate *date;                //第一次创建的时间(用来排序)
//@property (nonatomic,copy) NSString *newFriendDescription;
@property (nonatomic,assign) BOOL hasCache;

// 好友验证消息 NSDictionary  jid body
- (NSArray *) getMessageValid;
- (NSArray *) getMessageValidExt;
- (void) setMessageValid:(NSDictionary *)dic;
- (NSString *) getOneMessage;
- (NSString *) getChannelExt;
- (BOOL) hasChannel;


/**
 *  初始化新朋友Model
 *
 *  @param jid_           用户jid
 *  @param name_          名称
 *  @param albumUrl_      头像
 *  @param nickName_      备注名
 *  @param state_         好友状态
 *  @param validationMsg_ 验证消息
 *  @param mobilePhone_   手机号
 *  @param sex_           性别
 *  @param album_         个人相册
 *  @param region_        地区
 *  @param signature_     个性签名
 *  @param read_          好友已查看
 *  @param friendType_    好友类型（正常/黑名单...）
 *  @param source_        好友来源
 *  @param distance_
 *  @param hasCache_
 *
 *  @return 返回实例
 */
- (id)initWithJid:(NSString *)jid_
             name:(NSString *)name_
         albumUrl:(NSString *)albumUrl_
         nickName:(NSString *)nickName_
            state:(NewUserState)state_
    validationMsg:(NSString *)validationMsg_
      mobilePhone:(NSString *)mobilePhone_
              sex:(NSString *)sex_
            album:(NSString *)album_
           region:(NSString *)region_
        signature:(NSString *)signature_
             read:(READ_STATE)read_
       friendType:(FRIEND_TYPE)friendType_
           source:(FriendFromType)source_
          heartID:(NSString *)heartID_
friendDescription:(NSString *)friendDescription_;


/**
 *  另一种初始化新朋友Model 缺省state（好友状态）= NewUserState_noAdd
 read（好友已读）= MESSAGE_READ
 friendType（好友类型）= FRIEND_ISNORMAL
 source（好友来源）= FriendFromType_Normal
 *
 *  @param jid_           用户jid
 *  @param name_          名称
 *  @param albumUrl_      头像
 *  @param nickName_      备注名
 *  @param validationMsg_ 验证消息
 *  @param mobilePhone_   手机号
 *  @param sex_           性别
 *  @param album_         个人相册
 *  @param region_        地区
 *  @param signature_     个性签名
 *  @param source_        好友来源
 *  @param distance_
 *  @param hasCache_
 *
 *  @return 返回实例
 */

- (id)initWithJid:(NSString *)jid_
             name:(NSString *)name_
         albumUrl:(NSString *)albumUrl_
         nickName:(NSString *)nickName_
    validationMsg:(NSString *)validationMsg_
      mobilePhone:(NSString *)mobilePhone_
              sex:(NSString *)sex_
            album:(NSString *)album_
           region:(NSString *)region_
        signature:(NSString *)signature_
          heartID:(NSString *)heartID_
friendDescription:(NSString *)friendDescription_;


/**
 *  获取新朋友提示描述
 *
 *  @return 获取提示描述
 */
- (NSString *)getNewFriendDescription;

@end
