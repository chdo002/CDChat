//
//  UITool.h
//  Utility
//
//  Created by chdo on 2017/12/8.
//

#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIView+CRM.h"
#import "AATHUD.h"
#import "NSString+Extend.h"
// 系统版本号
double CRMDeviceSystemVersion(void);

CGSize CRMScreenSize(void);

/**
 颜色
 */
UIColor *CRMHexColor(int hexColor); // 16位颜色
UIColor *CRMRadomColor(void); //随机色
//UIColor *RGB(CGFloat A, CGFloat B, CGFloat C);


/**
 尺寸
 */
CGFloat NaviH(void);
CGFloat ScreenW(void);
CGFloat ScreenH(void);


//
NSInteger CRMFileSizeByFileUrl(NSURL *filePath);
NSInteger CRMFileSizeByFilePath(NSString *filePath);


#define WeakObj(o) __weak typeof(o) o##Weak = o;
#define StrongObj(o) __weak typeof(o) o##Strong = o;


#define RGB(A, B, C)    [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha:1.0]
#define RGBA(A, B, C, alp)    [UIColor colorWithRed:A/255.0 green:B/255.0 blue:C/255.0 alpha: alp]
