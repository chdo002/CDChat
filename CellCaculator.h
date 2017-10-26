//
//  CellCaculator.h
//  CDChatList
//
//  Created by chdo on 2017/10/26.
//

#import <UIKit/UIKit.h>
#import "CDChatListProtocols.h"

@interface CellCaculator : NSObject

+(void)caculatorAllCellHeight:(NSArray *)msgArr;

/**
 获取cell高度，优先从modal中的缓存获取，否则计算cell高度，并缓存在modal中
 
 @return cell高度
 */
+(CGFloat)fetchCellHeight:(id<MessageModalProtocal>)data;

@end
