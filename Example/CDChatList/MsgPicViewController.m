//
//  MsgPicViewController.m
//  CDChatList_Example
//
//  Created by chdo on 2018/4/29.
//  Copyright © 2018年 chdo002. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "MsgPicViewController.h"
#import <SDWebImage/SDImageCache.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface MsgPicViewController ()
{
    UIScrollView *scrol;
    UIImage *currentImg;
    CGRect currentRect;
}
@end

@implementation MsgPicViewController

+(void)addToRootViewController:(UIImage *)img in :(CGRect)imgRectIntTableView from: (CDChatMessageArray) msgs{
    
    MsgPicViewController *msgVc = [[MsgPicViewController alloc] init];
    msgVc.img = img;
    msgVc.imgRectIntTableView = imgRectIntTableView;
    msgVc.msgs = msgs;
    
    msgVc.view.backgroundColor = [UIColor clearColor];
    msgVc.view.frame = [UIScreen mainScreen].bounds;
    
    [msgVc willMoveToParentViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    [[UIApplication sharedApplication].keyWindow.rootViewController addChildViewController:msgVc];
    [[UIApplication sharedApplication].keyWindow addSubview:msgVc.view];
    
    
    UIImageView *currentImg = [[UIImageView alloc] initWithImage:img];
    
    CGRect newe =  [msgVc.view convertRect:imgRectIntTableView toView:msgVc.view];
    currentImg.frame = newe;
    currentImg.contentMode = UIViewContentModeScaleAspectFit;
    [msgVc.view addSubview:currentImg];
    
    [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:1 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        currentImg.frame = msgVc.view.bounds;
        msgVc.view.backgroundColor = [UIColor blackColor];
    } completion:^(BOOL finished) {
        [currentImg removeFromSuperview];
        [msgVc didMoveToParentViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
    }];
    
}

-(void)willMoveToParentViewController:(UIViewController *)parent{
    
    scrol = [[UIScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    scrol.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:scrol];
    
    uint cot = 0;
    
    for (CDChatMessage msg in self.msgs) {
        if (msg.msgType == CDMessageTypeImage){
            cot++;
        }
    }
    scrol.contentSize = CGSizeMake(cot * ScreenWidth, 0);
    scrol.alwaysBounceHorizontal = YES;
    scrol.alwaysBounceVertical = YES;
    scrol.pagingEnabled = YES;
    [scrol addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:nil];
    
    for (int i = 0; i < self.msgs.count; i++) {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
        img.contentMode = UIViewContentModeScaleAspectFit;
        [img sd_setImageWithURL:[NSURL URLWithString:self.msgs[i].msg] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
            if (error) {
                [img sd_setImageWithURL:[NSURL URLWithString:self.msgs[i].messageId] placeholderImage:nil completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if (error) {
                        
                    }
                }];
            }
        }];
        
        [scrol addSubview:img];
    }
    
    [scrol setHidden:YES];
}

-(void)didMoveToParentViewController:(UIViewController *)parent{
    [scrol setHidden:NO];
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGFloat offsetY = ((NSValue *)change[NSKeyValueChangeNewKey]).CGPointValue.y;
        CGFloat offsetY_lod = ((NSValue *)change[NSKeyValueChangeOldKey]).CGPointValue.y;
        
        NSLog(@"%d", offsetY >= offsetY_lod);
        
//        if (offsetY < 0){
//            CGFloat transY = ABS(offsetY / ScreenHeight);
//            if (transY > 0.02) {
//                self.view.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
//            }
//        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

@end
