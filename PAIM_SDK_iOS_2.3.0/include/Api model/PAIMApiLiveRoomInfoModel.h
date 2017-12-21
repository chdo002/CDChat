//
//  PAIMApiLiveRoomInfoModel.h
//  PAIM_Demo
//
//  Created by 马俊炎 on 16/9/13.
//  Copyright © 2016年 PA. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *  获取直播间信息详情返回的模型
 */
@interface PAIMApiLiveRoomInfoModel : NSObject

@property (nonatomic,strong) NSString *albumUrl;            //直播间头像
@property (nonatomic,strong) NSString *createtime;          //创建时间
@property (nonatomic,strong) NSString *introduction;        //直播间简介
@property (nonatomic,strong) NSString *liveId;              //直播间ID
@property (nonatomic,strong) NSString *liveTopic;           //直播间主题
@property (nonatomic,strong) NSString *livename;            //直播间名称
@property (nonatomic,strong) NSString *notice;              //直播间公告
@property (nonatomic,strong) NSString *updatetime;          //更新时间

@end
