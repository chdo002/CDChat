//
//  CTHelper.h
//  CDLabel
//
//  Created by chdo on 2017/12/4.
//


#import <UIKit/UIKit.h>
@interface CTHelper : NSObject
/**
 配置表情字典
 
 @param emjDic 表情名->image
 */
+(void)loadImageDic: (NSDictionary<NSString*, UIImage *> *)emjDic;

+(NSDictionary *)emoticonDic;

@end
