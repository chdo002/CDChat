//
//  MainViewController.m
//  CDChatList_Example
//
//  Created by chdo on 2017/11/7.
//  Copyright © 2017年 chdo002. All rights reserved.
//

#import "MainViewController.h"
#import "CDChatList_Example-Swift.h"
#import <CDChatList/CDChatList.h>

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *dic;
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
    
    [ChatHelpr setDefaultEmoticonDic:dic];
    
    
    [ChatHelpr defaultConfiguration].environment = 1;
}
/*
 
 
 //
 //  TestSecViewController.m
 //  CoreTextDemo
 //
 //  Created by chdo on 2017/11/30.
 //  Copyright © 2017年 TangQiao. All rights reserved.
 //
 
 #import "TestSecViewController.h"
 #import "TestView.h"
 
 #import "CTFrameParserConfig.h"
 #import "CTFrameParser.h"
 
 
 @interface TestSecViewController ()
 
 @end
 
 @implementation TestSecViewController
 
 - (void)viewDidLoad {
 [super viewDidLoad];
 
 UIImageView *imagev = [[UIImageView alloc] initWithImage:[self crea]];
 imagev.frame = CGRectMake(100, 100, 22, 40);
 
 [self.view addSubview:imagev];
 }
 
 -(UIImage *)crea{
 // 22 * 40 真实环境
 CGSize size = CGSizeMake(22, 40);
 
 UIGraphicsBeginImageContextWithOptions(size, NO, 0);
 
 CGContextRef context = UIGraphicsGetCurrentContext();
 
 UIColor *color1 = [UIColor redColor];
 CGContextSetFillColorWithColor(context, color1.CGColor);//填充颜色
 
 
 [self moveToPoint:context point:6 pointy:5]; // 1
 [self addLineToPoint:context point:6 pointy:15]; // 2
 [self addLineToPoint:context point:1 pointy:18]; // 3
 CGContextAddQuadCurveToPoint(context, 0, 20, 1, 21); // 4
 [self addLineToPoint:context point:6 pointy:24];  // 5
 [self addLineToPoint:context point:6 pointy:35];  // 6
 
 [self addLineToPoint:context point:11 pointy:40]; // 7
 
 //    [self moveToPoint:context point:0 pointy:0];
 //    [self addLineToPoint:context point:0 pointy:40];
 //    [self addLineToPoint:context point:22 pointy:0];
 CGContextClosePath(context);//封闭路径
 
 UIColor *fillcolor = [UIColor blackColor];
 CGContextSetFillColorWithColor(context, fillcolor.CGColor);//填充色
 
 CGContextDrawPath(context, kCGPathFill);//根据坐标
 
 
 UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
 
 UIGraphicsEndImageContext();
 return image;
 }
 
 -(void)moveToPoint:(CGContextRef)cot point:(CGFloat)x pointy: (CGFloat) y{
 CGContextMoveToPoint(cot, x, y);
 }
 
 -(void)addLineToPoint:(CGContextRef)cot point:(CGFloat)x pointy: (CGFloat) y{
 CGContextAddLineToPoint(cot, x, y);
 }
 
 -(void)addCurToPoint:(CGContextRef)cot{
 //    CGPathAddArc(<#CGMutablePathRef  _Nullable path#>, <#const CGAffineTransform * _Nullable m#>, <#CGFloat x#>, <#CGFloat y#>, <#CGFloat radius#>, <#CGFloat startAngle#>, <#CGFloat endAngle#>, <#bool clockwise#>)
 //
 //    CGPathAddArcToPoint(<#CGMutablePathRef  _Nullable path#>, <#const CGAffineTransform * _Nullable m#>, <#CGFloat x1#>, <#CGFloat y1#>, <#CGFloat x2#>, <#CGFloat y2#>, <#CGFloat radius#>)
 }
 
 @end

 
 
 */

@end
