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

-(void)inputViewPopSttring:(NSString *)string; //
-(void)inputViewPopCommand:(NSString *)string; //
-(void)inputViewPopAudio:(NSData *)data path:(NSString *)path; //

@end

@interface CTInputView : UIView
@property(nonatomic, weak) id<CTInputViewProtocol>delegate;
@end
