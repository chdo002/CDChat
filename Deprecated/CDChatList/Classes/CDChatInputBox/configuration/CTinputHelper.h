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
+(NSDictionary<NSString *,UIImage *> *)defaultEmoticonDic;
+(void)setDefaultEmoticonDic:(NSDictionary<NSString *,UIImage *> *)dic;
    
    
#pragma mark 图片资源
+(NSDictionary<NSString *,UIImage *> *)defaultImageDic;
+(void)setDefaultImageDic:(NSDictionary<NSString *,UIImage *> *)dic;
    
    
@end
