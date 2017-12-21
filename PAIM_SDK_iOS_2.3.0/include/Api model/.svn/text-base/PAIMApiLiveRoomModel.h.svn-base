//
//  PAIMApiLiveRoomModel.h
//  PAIM_Demo
//
//  Created by 马俊炎 on 16/8/30.
//  Copyright © 2016年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface PAIMApiLiveRoomModel : NSObject <NSCoding>

@property (nonatomic,strong) NSString *liveId;                  //直播间ID
@property (nonatomic,strong) NSString *liveName;                //直播间名称
@property (nonatomic,strong) NSString *liveTopic;               //直播间主题
@property (nonatomic,strong) NSString *introduction;            //直播间简介
@property (nonatomic,strong) NSString *notice;                  //直播间公告
@property (nonatomic,strong) NSString *updateTime;              //更新时间
@property (nonatomic,strong) NSString *subscribeNumber;         //关注人数
@property (nonatomic,strong) NSString *onlineNumber;            //在线人数
@property (nonatomic,strong) NSString *anchorUsername;          //主播username
@property (nonatomic,strong) NSString *anchorNickname;          //主播昵称
@property (nonatomic,strong) NSString *anchorAlbumurl;          //主播头像
@property (nonatomic,strong) NSString *anchorCritique;          //优势点评
@property (nonatomic,strong) NSString *anchorTitle;             //主播头衔

@property (nonatomic,strong) NSString *createTime;              //创建时间
@property (nonatomic,strong) NSString *anchorIntroduction;      //主播简介

@property (nonatomic,strong) NSString *subscribe;                   //是否关注  1:关注  0:未关注
@property (nonatomic,strong) NSString *subscribeTime;           //关注时间
@property (nonatomic,strong) NSString *stickTime;               //置顶时间
@property (nonatomic,strong) NSString *quitRoomTime;      //退出直播间时间

@property (nonatomic,strong) NSDictionary *extendField;              //预留扩展字段

//是否置顶
- (BOOL)isStick;

//直播间是否无效
-(BOOL)isLiveRoomInvalid;

@end
