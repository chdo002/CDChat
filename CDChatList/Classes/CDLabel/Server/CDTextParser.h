//
//  CDTextParser.h
//  CDLabel
//
//  Created by chdo on 2017/12/1.
//

#import <Foundation/Foundation.h>
#import "CTData.h"

@interface CDTextParser : NSObject
// 表情
+(NSMutableArray *)matchImage:(NSMutableAttributedString *)str configuration:(CTDataConfig)config;

// 链接
+(NSMutableArray *)matchLink:(NSMutableAttributedString *)str configuration:(CTDataConfig)config;
// 邮箱
+(NSMutableArray *)matchEmail:(NSMutableAttributedString *)str configuration:(CTDataConfig)config;
// 号码
+(NSMutableArray *)matchPhone:(NSMutableAttributedString *)str configuration:(CTDataConfig)config;
@end
