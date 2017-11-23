//
//  ChatHelpr.m
//  CDChatList
//
//  Created by chdo on 2017/11/17.
//

#import "ChatHelpr.h"
#import "CDChatMacro.h"
#import "CDBaseMsgCell.h"

@implementation ChatHelpr

#pragma mark  表情替换

+(NSDictionary *)emoticonDic {
    static NSMutableDictionary *dic;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        // 表情bundle地址
        NSString *emojiBundlePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Expression.bundle"];
        // 表情键值对
        NSDictionary<NSString *, id> *temp = [[NSDictionary alloc] initWithContentsOfFile:[emojiBundlePath stringByAppendingPathComponent:@"files/expressionImage_custom.plist"]];
        // 表情图片bundle
        NSBundle *bundle = [NSBundle bundleWithPath:emojiBundlePath];
        dic = [NSMutableDictionary dictionary];
        for (NSString *imagName in temp.allKeys) {
            UIImage *img = [UIImage imageNamed:temp[imagName] inBundle:bundle compatibleWithTraitCollection:nil];
            [dic setValue:img forKey:imagName];
        }
    });
    return dic;
}

+(void)matchEmoji:(NSMutableAttributedString *)msgStr{
    NSRegularExpression *regEmoji = [NSRegularExpression regularExpressionWithPattern:@"\\[[^\\[\\]]+?\\]" options:kNilOptions error:NULL];
    NSUInteger emoClipLength = 0;
    
    NSArray<NSTextCheckingResult *> *emoticonResults = [regEmoji matchesInString:msgStr.string options:kNilOptions range:NSMakeRange(0, msgStr.string.length)];
    for (NSTextCheckingResult *emo in emoticonResults) {
        if (emo.range.location == NSNotFound && emo.range.length <= 1) continue;
        NSRange range = emo.range;
        range.location -= emoClipLength;
        if ([msgStr yy_attribute:YYTextHighlightAttributeName atIndex:range.location]) continue;
        if ([msgStr yy_attribute:YYTextAttachmentAttributeName atIndex:range.location]) continue;
        NSString *emoString = [msgStr.string substringWithRange:range];
        UIImage *image = [ChatHelpr emoticonDic][emoString];
        if (!image) continue;
        NSMutableAttributedString *emoText = [NSMutableAttributedString yy_attachmentStringWithEmojiImage:image fontSize:MessageTextDefaultFontSize];
        
        [msgStr replaceCharactersInRange:range withAttributedString:emoText];
        emoClipLength += range.length - 1;
    }
}

+(void)matchUrl: (NSMutableAttributedString *) msgStr
   fetchActions: (YYTextAction (^)(void))getAction
{
    
    NSRegularExpression *regUrl = [NSRegularExpression regularExpressionWithPattern:@"((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)" options:kNilOptions error:NULL];

    NSArray<NSTextCheckingResult *> *emoticonResults = [regUrl matchesInString:msgStr.string options:kNilOptions range:NSMakeRange(0, msgStr.string.length)];
    
    for (int i = 0; i < emoticonResults.count; i++) {
        
        NSTextCheckingResult *rest = emoticonResults[i];
        if (rest.range.location == NSNotFound && rest.range.length <= 1) continue;
        NSRange range = rest.range;
        if ([msgStr yy_attribute:YYTextHighlightAttributeName atIndex:range.location]) continue;
        if ([msgStr yy_attribute:YYTextAttachmentAttributeName atIndex:range.location]) continue;
        NSString *emoString = [msgStr.string substringWithRange:range];
        
        
        NSMutableAttributedString *urlString = [[NSMutableAttributedString alloc] initWithString:emoString];
//
//        urlString.yy_underlineColor = urlString.yy_color;
//        urlString.yy_underlineStyle = NSUnderlineStyleSingle;
//        urlString.yy_lineSpacing = 6;
//        urlString.yy_maximumLineHeight = MessageTextDefaultFontSize + 10;
//        urlString.yy_minimumLineHeight = MessageTextDefaultFontSize + 10;
//        urlString.yy_paragraphSpacing = 1;
        [msgStr replaceCharactersInRange:range withAttributedString:urlString];
        
        
        [msgStr yy_setTextHighlightRange: range
                                   color: [UIColor blueColor]
                         backgroundColor: [UIColor lightGrayColor]
                               tapAction: getAction()];
    }
    
    
}

@end
