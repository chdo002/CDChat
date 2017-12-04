//
//  ChatMessageMatch.m
//  CDChatList
//
//  Created by chdo on 2017/11/26.
//

#import "ChatMessageMatch.h"
#import "ChatHelpr.h"
#import "CDChatMacro.h"
#import "CDBaseMsgCell.h"

@implementation ChatMessageMatch
#pragma mark  HTML替换
//+(NSMutableAttributedString *)matchHTML:(NSMutableAttributedString *)msgStr{
//    
//    
//    NSString *originStr = [msgStr.string copy];
//    
//    
//    originStr = [originStr stringByReplacingOccurrencesOfString:@"</span>" withString:@""];
//    originStr = [originStr stringByReplacingOccurrencesOfString:@"<br/>" withString:@"\n\r"];
//    originStr = [originStr stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
//    originStr = [originStr stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
//    
//    
//    
//    //    NSData *data = [originStr dataUsingEncoding:NSUnicodeStringEncoding];
//    //    NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
//    //    msg_attributeText = [[NSMutableAttributedString alloc] initWithData:data
//    //                                                                options:options
//    //                                                     documentAttributes:nil
//    //                                                                  error:nil];
//    //  去掉所有HTML标签 不包括a标签
//    NSRegularExpression *replaceReg = [NSRegularExpression regularExpressionWithPattern:@"<(?!a)(?!/a).*?>" options:0 error:nil];
//    NSString *cleanStr = [replaceReg stringByReplacingMatchesInString:originStr options:0 range: NSMakeRange(0, originStr.length) withTemplate:@""];
//    
//    return [[NSMutableAttributedString alloc] initWithString:cleanStr attributes:msgStr.yy_attributes];
//}
//
//#pragma mark  表情替换
//
//+(void)matchEmoji:(NSMutableAttributedString *)msgStr{
//    
//    NSRegularExpression *regEmoji = [NSRegularExpression regularExpressionWithPattern:@"\\[[^\\[\\]]+?\\]" options:kNilOptions error:NULL];
//    
//    NSUInteger emoClipLength = 0;
//    NSArray<NSTextCheckingResult *> *emoticonResults = [regEmoji matchesInString:msgStr.string options:kNilOptions range:NSMakeRange(0, msgStr.string.length)];
//    for (NSTextCheckingResult *emo in emoticonResults) {
//        if (emo.range.location == NSNotFound && emo.range.length <= 1) continue;
//        NSRange range = emo.range;
//        range.location -= emoClipLength;
//        // 有表情或匹配过，则跳过
//        if ([msgStr yy_attribute:YYTextHighlightAttributeName atIndex:range.location]) continue;
//        if ([msgStr yy_attribute:YYTextAttachmentAttributeName atIndex:range.location]) continue;
//        NSString *emoString = [msgStr.string substringWithRange:range];
//        UIImage *image = [ChatHelpr emoticonDic][emoString];
//        if (!image) continue;
//        
//        NSMutableAttributedString *emoText = [NSMutableAttributedString yy_attachmentStringWithEmojiImage:image
//           fontSize:MessageTextDefaultFontSize];
//        
//        [msgStr replaceCharactersInRange:range withAttributedString:emoText];
//        emoClipLength += range.length - 1;
//    }
//}
//
//
//#pragma mark 固定字长匹配
///**
// ================================================================================================================
// =============================================--->固定字长匹配<---=================================================
// ================================================================================================================
// */
//+(void)matchFixedStr: (NSMutableAttributedString *) msgStr
//                with: (NSRegularExpression *)reg
//        fetchActions: (YYTextAction (^)(void))getAction
//{
//    NSArray<NSTextCheckingResult *> *regResults = [reg matchesInString:msgStr.string options:kNilOptions range:NSMakeRange(0, msgStr.string.length)];
//    
//    for (int i = 0; i < regResults.count; i++) {
//        NSTextCheckingResult *rest = regResults[i];
//        if (rest.range.location == NSNotFound && rest.range.length <= 1) continue;
//        NSRange range = rest.range;
//        // 有表情或匹配过，则跳过
//        if ([msgStr yy_attribute:YYTextHighlightAttributeName atIndex:range.location]) continue;
//        if ([msgStr yy_attribute:YYTextAttachmentAttributeName atIndex:range.location]) continue;
//        NSString *targetStr = [msgStr.string substringWithRange:range];
//        NSMutableAttributedString *targetString = [[NSMutableAttributedString alloc] initWithString:targetStr];
//        [msgStr replaceCharactersInRange:range withAttributedString:targetString];
//        [msgStr yy_setTextHighlightRange:range
//                                   color:[UIColor blueColor]
//                         backgroundColor:[UIColor lightGrayColor]
//                               tapAction:getAction()];
//    }
//}
//
//#pragma mark URL匹配
//+(void)matchUrl: (NSMutableAttributedString *) msgStr
//   fetchActions: (YYTextAction (^)(void))getAction
//{
//    NSRegularExpression *regUrl = [NSRegularExpression regularExpressionWithPattern:@"((((((H|h){1}(T|t){2}(P|p){1})(S|s)?|ftp)://)(([a-zA-Z0-9_-]+\\.?)+|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3})|((([a-zA-Z_-]+\\.)|[\\d]+\\.)+[a-zA-Z0-9#_-]+))|((((H|h){1}(T|t){2}(P|p){1})(S|s)?|ftp)://)?(((([a-zA-Z_-]+\\.)|[\\d]+\\.)+[a-zA-Z0-9#_-]+)|([0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}\\.[0-9]{1,3}))(:[0-9]+)?)(:[0-9]+)?(/[a-zA-Z0-9\\&%_\\./-~-#]*)?)" options:kNilOptions error:NULL];
//    [self matchFixedStr:msgStr with:regUrl fetchActions:getAction];
//}
//
//#pragma mark 电话号码匹配
//+(void)matchPhone: (NSMutableAttributedString *) msgStr
//     fetchActions: (YYTextAction (^)(void))getAction
//{
//    NSRegularExpression *regPhone = [NSRegularExpression regularExpressionWithPattern:@"\\d{3}-\\d{8}|\\d{3}-\\d{7}|\\d{4}-\\d{8}|\\d{4}-\\d{7}|1+[0-9]+\\d{5,10}|\\d{8}|\\d{7}\\d{6}" options:kNilOptions error:NULL];
//    [self matchFixedStr:msgStr with:regPhone fetchActions:getAction];
//}
//
//#pragma mark 邮箱匹配
//+(void)matchEmail: (NSMutableAttributedString *) msgStr
//     fetchActions: (YYTextAction (^)(void))getAction{
//    NSRegularExpression *regEmail = [NSRegularExpression regularExpressionWithPattern:@"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}" options:kNilOptions error:NULL];
//    [self matchFixedStr:msgStr with:regEmail fetchActions:getAction];
//}
@end
