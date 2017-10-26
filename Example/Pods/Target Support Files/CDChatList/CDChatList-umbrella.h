#ifdef __OBJC__
#import <UIKit/UIKit.h>
#else
#ifndef FOUNDATION_EXPORT
#if defined(__cplusplus)
#define FOUNDATION_EXPORT extern "C"
#else
#define FOUNDATION_EXPORT extern
#endif
#endif
#endif

#import "CDChatList.h"
#import "CDChatListProtocols.h"
#import "CDChatMacro.h"
#import "CDTextTableViewCell.h"
#import "MessageModal.h"

FOUNDATION_EXPORT double CDChatListVersionNumber;
FOUNDATION_EXPORT const unsigned char CDChatListVersionString[];

