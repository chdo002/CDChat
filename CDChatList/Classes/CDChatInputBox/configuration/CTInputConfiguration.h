//
//  CTInputConfiguration.h
//  CDChatList
//
//  Created by chdo on 2017/12/12.
//

#import <Foundation/Foundation.h>
#import "CTInPutMacro.h"


static CGFloat CTInputViewHeight = 50.0f;

@interface CTInputConfiguration : NSObject


/**
 文本框位置
 */
@property(nonatomic,assign) CGRect inputViewRect;


/**
 语音按钮位置
 */
@property(nonatomic,assign) CGRect voiceButtonRect;


/**
 emoji按钮位置
 */
@property(nonatomic,assign) CGRect emojiButtonRect;

/**
 ‘更多’按钮位置
 */
@property(nonatomic,assign) CGRect moreButtonRect;


// 只有输入框的配置
+(CTInputConfiguration*)defaultConfig;

// 添加输入语音功能
-(void)addVoice;

// 添加输入表情功能
-(void)addEmoji;

// 添加更多功能
-(void)addExtra:(NSDictionary *)info;

@end

