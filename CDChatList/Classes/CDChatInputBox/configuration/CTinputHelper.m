//
//  CTinputHelper.m
//  CDChatList
//
//  Created by chdo on 2017/12/12.
//

#import "CTinputHelper.h"
#import "CTInputConfiguration.h"
#import "CTInputBoxDrawer.h"

@interface CTinputHelper()

@property(nonatomic, strong) NSDictionary<NSString*, UIImage *> *emojDic;
@property(nonatomic, strong) NSDictionary<NSString*, UIImage *> *imageDic;
@property(nonatomic, strong) CTInputConfiguration *config;

/**
 @[ @[@"[微笑]",@"[呵呵]"],   @[@"[:微笑:",@":呵呵:"] ]
 */
@property(nonatomic, copy) NSArray<NSArray<NSString *> *> *emojiNameArr; // 表情图片名组成的数组  可对应多个集合
@property(nonatomic, copy) NSArray<NSString *> *emojiNameArrTitles;


@end

@implementation CTinputHelper

+(instancetype)share{
    
    static dispatch_once_t onceToken;
    static CTinputHelper *helper;
    
    dispatch_once(&onceToken, ^{
        helper = [[CTinputHelper alloc] init];
        helper->_config = [CTInputConfiguration defaultConfig];
        dispatch_async(dispatch_get_main_queue(), ^{
            helper->_imageDic = [CTInputBoxDrawer defaultImageDic];
        });
    });
    return helper;
}

#pragma mark 配置相关
+(CTInputConfiguration *)defaultConfiguration{
    return [CTinputHelper share].config;
}

+(void)setDefaultConfiguration:(CTInputConfiguration *)config{
    [CTinputHelper share].config = config;
}
#pragma mark  表情相关
// 表情字典
+(NSDictionary<NSString *,UIImage *> *)defaultEmoticonDic{
    return [CTinputHelper share].emojDic;
}

+(NSArray<NSArray<NSString *> *> *)emojiNameArr{
    return [CTinputHelper share].emojiNameArr;
}

+(NSArray<NSString *> *)emojiNameArrTitles{
    return [CTinputHelper share].emojiNameArrTitles;
}

//@[ @[@"[微笑]",@"[呵呵]"],   @[@"[:微笑:",@":呵呵:"] ]
+(void)setDefaultEmoticonDic:(NSDictionary<NSString *,UIImage *> *)dic
               emojiNameArrs:(NSArray<NSArray<NSString *> *> *)arrs
               emojiNameArrTitles:(NSArray<NSString *> *)arrsTitles{
    [CTinputHelper share]->_imageDic = [CTInputBoxDrawer defaultImageDic]; // 绘制图片资源
    [CTinputHelper share].emojDic = dic;    // 表情资源字典
    [CTinputHelper share].emojiNameArr = arrs; // 表情名数组
    [CTinputHelper share].emojiNameArrTitles = arrsTitles; // 表情名数组
}

#pragma mark  资源图片
+(NSDictionary<NSString *,UIImage *> *)defaultImageDic{
    return [CTinputHelper share].imageDic;
}
+(void)setDefaultImageDic:(NSDictionary<NSString *,UIImage *> *)dic{
    [CTinputHelper share].imageDic = dic;
}
@end
