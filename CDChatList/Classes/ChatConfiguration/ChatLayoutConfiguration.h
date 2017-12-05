//
//  ChatLayoutConfiguration.h
//  CDChatList
//
//  Created by chdo on 2017/12/5.
//

#import <UIKit/UIKit.h>

@interface ChatLayoutConfiguration : NSObject

// cell中消息中时间视图的高度（如果显示）
@property (nonatomic, assign) CGFloat MsgTimeH;

// 颜色


/**
 cell背景色
 */
@property (nonatomic, strong) UIColor *MsgBackGroundColor;




@end
