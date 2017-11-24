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
#pragma mark  表情HTML

+(NSMutableAttributedString *)matchHTML:(NSMutableAttributedString *)msgStr{
    

    NSString *originStr = [msgStr.string copy];
    
    
    originStr = [originStr stringByReplacingOccurrencesOfString:@"</span>" withString:@""];
    originStr = [originStr stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n\r"];
    originStr = [originStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    originStr = [originStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];

    
    
//    NSData *data = [originStr dataUsingEncoding:NSUnicodeStringEncoding];
//    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
//    msg_attributeText = [[NSMutableAttributedString alloc] initWithData:data
//                                                                options:options
//                                                     documentAttributes:nil
//                                                                  error:nil];
//    / 去掉所有HTML标签 不包括a标签
    NSRegularExpression *replaceReg = [NSRegularExpression regularExpressionWithPattern:@"<(?!a)(?!/a).*?>" options:0 error:nil];
    NSString *cleanStr = [replaceReg stringByReplacingMatchesInString:originStr options:0 range: NSMakeRange(0, originStr.length) withTemplate:@""];
    
    return [[NSMutableAttributedString alloc] initWithString:cleanStr attributes:msgStr.yy_attributes];
}

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
    NSRegularExpression *regUrl = [NSRegularExpression regularExpressionWithPattern:@"((((((H|h){1}(T|t){2}(P|p){1})(S|s)?|ftp)://)(([a-zA-Z0-9_-]+\\.?)+|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3})|((([a-zA-Z_-]+\\.)|[\\d]+\\.)+[a-zA-Z0-9#_-]+))|((((H|h){1}(T|t){2}(P|p){1})(S|s)?|ftp)://)?(((([a-zA-Z_-]+\\.)|[\\d]+\\.)+[a-zA-Z0-9#_-]+)|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]+)?)(:[0-9]+)?(/[a-zA-Z0-9\\&%_\\./-~-#]*)?)" options:kNilOptions error:NULL];

    NSArray<NSTextCheckingResult *> *regResults = [regUrl matchesInString:msgStr.string options:kNilOptions range:NSMakeRange(0, msgStr.string.length)];
    
    for (int i = 0; i < regResults.count; i++) {
        
        NSTextCheckingResult *rest = regResults[i];
        if (rest.range.location == NSNotFound && rest.range.length <= 1) continue;
        NSRange range = rest.range;
        if ([msgStr yy_attribute:YYTextHighlightAttributeName atIndex:range.location]) continue;
        if ([msgStr yy_attribute:YYTextAttachmentAttributeName atIndex:range.location]) continue;
        
        NSString *emoString = [msgStr.string substringWithRange:range];
        
        NSMutableAttributedString *urlString = [[NSMutableAttributedString alloc] initWithString:emoString];
        [msgStr replaceCharactersInRange:range withAttributedString:urlString];
        
        [msgStr yy_setTextHighlightRange: range
                                   color: [UIColor blueColor]
                         backgroundColor: [UIColor lightGrayColor]
                               tapAction: getAction()];
    }
    
    
}

@end
