//
//  ChatListInfo.h
//  CDChatList
//
//  Created by chdo on 2017/11/23.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ChatClickEventTypeURL,
    ChatClickEventTypeIMAGE,
    ChatClickEventTypePHONE,
    ChatClickEventTypeEMAIL,
    ChatClickEventTypeCOMMAND,
} ChatClickEventType;

/**
 点击事件
 */
@interface ChatListInfo: NSObject

/**
 文字容器
 */
@property (nonatomic, strong, nullable) UIView *containerView;

/**
 全部消息字符
 */
@property (nonatomic, copy, nonnull) NSString *msgText;

/**
 点击文字range
 */
@property (nonatomic, assign) NSRange range;

/**
 点击区域在containerView中的位置
 */
@property (nonatomic, assign) CGRect clicedkRect;

/**
 事件类型
 */
@property (nonatomic, assign) ChatClickEventType eventType;


/*-------链接-------*/
/**
 链接文本
 */
@property (nonatomic, copy, nullable) NSString *msglink;

/**
 链接文本在tableview中的位置
 */
@property (nonatomic, assign) CGRect msglinkRectInTableView;


/*-------图片-------*/
/**
 图片
 */
@property (nonatomic, strong, nullable) UIImage *image;

/**
 图片在tableview中的位置
 */
@property (nonatomic, assign) CGRect msgImageRectInTableView;

+(ChatListInfo *_Nullable)info:(ChatClickEventType)type
                 containerView:(UIView *_Nullable)view
              msgText:(NSString *_Nullable)msgText
                 link:(NSString *_Nullable)link
                 rnag:(NSRange)rang
            clickRect:(CGRect) rect;


-(void)sendMessage;
@end
