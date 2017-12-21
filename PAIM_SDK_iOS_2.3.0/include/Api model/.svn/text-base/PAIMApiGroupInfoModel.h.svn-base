//
//  PAIMApiGroupInfoModel.h
//  PAIM_Lib
//
//  Created by chenshaojie on 15/5/21.
//  Copyright (c) 2015年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PAIMApiGroupInfoModel : NSObject

@property (nonatomic, strong) NSString *groupID;        //群ID
@property (nonatomic, strong) NSString *nickName;       //群昵称
@property (nonatomic, strong) NSString *albumUrl;       //群头像
@property (nonatomic, strong) NSString *ownerID;        //群主的ID
@property (nonatomic, strong) NSArray *members;         //群成员
@property (nonatomic, assign) NSUInteger groupType;     //是否是内置群
@property (nonatomic, assign) BOOL isMember;            //是否是群组成员
@property (nonatomic, assign) BOOL msgSwitchOn;         //新消息通知
@property (nonatomic, assign) BOOL isSave;              //是否保存到通讯录
@property (nonatomic, assign) NSInteger maxusers;       //群聊的最大人数
@property (nonatomic, assign) Group_nameStatus nameStatus;   //是否自动设置群名称

- (id)initWithGroupID:(NSString *)groupID
             nickName:(NSString *)nickName
             albumUrl:(NSString *)albumUrl
              ownerID:(NSString *)ownerID
              members:(NSArray *)members
            groupType:(NSUInteger)groupType
             isMember:(BOOL)isMember
          msgSwitchOn:(BOOL)msgSwitchOn
               isSave:(BOOL)isSave
             maxusers:(NSInteger)maxusers
           nameStatus:(Group_nameStatus)nameStatus;
@end
