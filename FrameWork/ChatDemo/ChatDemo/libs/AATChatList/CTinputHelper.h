//
//  CTinputHelper.h
//  CDChatList
//
//  Created by chdo on 2017/12/12.
//

#import <Foundation/Foundation.h>
#import "CTInputConfiguration.h"

@interface CTinputHelper : NSObject

    
#pragma mark 组件配置相关
+(CTInputConfiguration *)defaultConfiguration;
+(void)setDefaultConfiguration:(CTInputConfiguration *)config;
    
#pragma mark  表情相关
/**
表情字典
@return <NameString: UIImage>
*/
// 表情字典
+(NSDictionary<NSString *,UIImage *> *)defaultEmoticonDic;

// 表情名数组
+(NSArray<NSArray<NSString *> *> *)emojiNameArr;

+(void)setDefaultEmoticonDic:(NSDictionary<NSString *,UIImage *> *)dic
               emojiNameArrs:(NSArray<NSArray<NSString *> *> *)arrs ////@[ @[@"[微笑]",@"[呵呵]"],   @[@"[:微笑:",@":呵呵:"] ]
          emojiNameArrTitles:(NSArray<NSString *> *)arrsTitles;

    
#pragma mark 图片资源
+(NSDictionary<NSString *,UIImage *> *)defaultImageDic;
+(void)setDefaultImageDic:(NSDictionary<NSString *,UIImage *> *)dic;
    
    
@end
