//
//  CTInputView.h
//  CDChatList
//
//  Created by chdo on 2017/12/12.
//

#import <UIKit/UIKit.h>
#import "CTInputHeaders.h"

@protocol CTInputViewProtocol <NSObject>

-(void)inputViewWillUpdateFrame:(CGRect)newFrame animateDuration:(double)duration animateOption:(NSInteger)opti;
// 输出文字
-(void)inputViewPopSttring:(NSString *)string; //
// 输出命令
-(void)inputViewPopCommand:(NSString *)string; //
// 输出音频
-(void)inputViewPopAudioath:(NSURL *)path; //

@end

@interface CTInputView : UIView
@property(nonatomic, weak) id<CTInputViewProtocol>delegate;
@end
