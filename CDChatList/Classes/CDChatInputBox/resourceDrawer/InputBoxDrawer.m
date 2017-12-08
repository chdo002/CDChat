//
//  InputBoxDrawer.m
//  CDChatList
//
//  Created by chdo on 2017/12/8.
//

#import "InputBoxDrawer.h"

NSString *const  InputBoxDrawerEMOJ = @"InputBoxDrawerEMOJ";

@interface InputBoxDrawer()
{
    CGSize iconSize;
}
@end

@implementation InputBoxDrawer


+(instancetype)share{
    
    static dispatch_once_t onceToken;
    static InputBoxDrawer *helper;
    
    dispatch_once(&onceToken, ^{
        helper = [[InputBoxDrawer alloc] init];
        helper->iconSize = CGSizeMake(30, 30);
    });
    return helper;
}

+(NSDictionary<NSString *,UIImage *> *)defaultImageDic{
    
    return nil;
}

-(UIImage *)emojIcon{
    
    UIGraphicsBeginImageContextWithOptions(iconSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
//    CGContextAddPath(context, rpath);
    
    // 设置填充色
    
    // 设置边框
    CGContextSetStrokeColorWithColor(context, [UIColor lightGrayColor].CGColor);
    
    CGContextSetLineWidth(context, 1);
    // 画边框
    CGContextDrawPath(context, kCGPathFillStroke);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
