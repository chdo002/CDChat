//
//  CellCaculator.h
//  CDChatList
//
//  Created by chdo on 2017/10/26.
//

#import <UIKit/UIKit.h>
#import "CDChatListProtocols.h"

@interface CellCaculator : NSObject


/**
 计算所有的cell高度

 @param msgArr 消息数组
 */
+(void)caculatorAllCellHeight:(NSArray<id<MessageModalProtocal>> *)msgArr callBack:(void(^)(void))completeBlock;

/**
 获取单个cell高度，优先从modal中的缓存获取，否则计算cell高度，并缓存在modal中
 
 @return cell高度
 */
+(CGFloat)fetchCellHeight:(id<MessageModalProtocal>)data;

@end
