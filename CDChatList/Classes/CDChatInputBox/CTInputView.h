//
//  CTInputView.h
//  CDChatList
//
//  Created by chdo on 2017/12/12.
//

#import <UIKit/UIKit.h>
#import "CTInputHeaders.h"


@interface NSArray (chinese)

- (NSString *)descriptionWithLocale:(id)locale;

@end

@interface NSDictionary (chinese)

- (NSString *)descriptionWithLocale:(id)locale;

@end


@interface CTInputView : UIView

@end
