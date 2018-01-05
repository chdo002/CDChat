//
//  CDLabel.m
//  CDLabel
//
//  Created by chdo on 2017/12/1.
//

/*
 http://eim-talk-stg.dmzstg.pingan.com.cn/appim-pir/talk?weAppNo=PAKDZS_09&businessType=KDZS&encryptStr=clientImNo=2E703B3776D5E60A2615DC0CB4B|customerNo=|customerName=|nickName=&extraInfo={%22umId%22:%22LIUFEI004%22,%22flag%22:%22Y%22,%22phoneNumber%22:%2213501020305%22,%22managerName%22:%22%E8%B7%AF%E4%BA%BA%E7%94%B2%22}#
 
 正在为您转接人工服务
 
 */

#import "CDLabel.h"
#import "MagnifiterView.h"
#import "CTHelper.h"
#import "CDLabelMacro.h"
#import "CoreTextUtils.h"
#import "CTClickInfo.h"



@interface SelectionAnchor: UIImageView
+(SelectionAnchor *)anchor:(BOOL)isTop lineHeight:(CGFloat) lineHeight;
@end

@implementation SelectionAnchor

+(SelectionAnchor *)anchor:(BOOL)isTop lineHeight:(CGFloat) lineHeight{
    
    SelectionAnchor *anc = [[SelectionAnchor alloc] initWithFrame:CGRectMake(0, 0, 10, lineHeight + 10)];
    UIImage *img = [anc cursorWithFontHeight:lineHeight isTop:isTop];
    anc.image = img;
    anc.contentMode = UIViewContentModeScaleAspectFit;
    return anc;
}



- (UIImage *)cursorWithFontHeight:(CGFloat)height isTop:(BOOL)top {
    
    CGFloat pinWidth = 10.0f;
    // 22
    CGRect rect = CGRectMake(0, 0, pinWidth, height + pinWidth);
    UIColor *color = RGB(28, 107, 222);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    // draw point
    if (top) {
        CGContextAddEllipseInRect(context, CGRectMake(0, 0, pinWidth, pinWidth));
    } else {
        CGContextAddEllipseInRect(context, CGRectMake(0, height, pinWidth, pinWidth));
    }
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillPath(context);
    // draw line
    [color set];
    CGContextSetLineWidth(context, 2);
    CGContextMoveToPoint(context, pinWidth * 0.5, 0);
    CGContextAddLineToPoint(context, pinWidth * 0.5, height + pinWidth);
    CGContextStrokePath(context);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end





NSString *const  CTCLICKMSGEVENTNOTIFICATION = @"CTCLICKMSGEVENTNOTIFICATION";

typedef enum CTDisplayViewState : NSInteger {
    CTDisplayViewStateNormal,       // 普通状态
    CTDisplayViewStateSelecting,    // 拖动中，  隐藏菜单
    CTDisplayViewStateSelected      // 拖动完成，需要弹出复制菜单
}CTDisplayViewState;

#define ANCHOR_TARGET_TAG 1

@interface CDLabel()<UIGestureRecognizerDelegate>

@property (nonatomic) NSInteger selectionStartPosition; // 选择起点下标
@property (nonatomic) NSInteger selectionEndPosition;   // 选择终点下标

@property (nonatomic) CTDisplayViewState state;
@property (strong, nonatomic) SelectionAnchor *leftSelectionAnchor;
@property (strong, nonatomic) SelectionAnchor *rightSelectionAnchor;
@property (strong, nonatomic) MagnifiterView *magnifierView;


@property(nonatomic, strong) UIGestureRecognizer *tapRecognizer;
@property(nonatomic, strong) UIGestureRecognizer *longPressRecognizer;
@property(nonatomic, strong) UIGestureRecognizer *panRecognizer;
@end

@implementation CDLabel

#pragma mark -------------------------初始化-------------------------

- (id)init {
    [self setupGestures];
    _selectionStartPosition = 0;
    _selectionEndPosition = 0;
    return [self initWithFrame:CGRectZero];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    _selectionStartPosition = 5;
    _selectionEndPosition = 1;
    [self setupGestures];
    
    return self;
}

- (MagnifiterView *)magnifierView {
    if (_magnifierView == nil) {
        _magnifierView = [[MagnifiterView alloc] init];
        _magnifierView.viewToMagnify = self;
    }
    return _magnifierView;
}
-(UIImageView *)leftSelectionAnchor{
    if (!_leftSelectionAnchor) {
        _leftSelectionAnchor = [SelectionAnchor anchor:YES lineHeight:[UIFont systemFontOfSize:self.data.config.textSize].lineHeight];
    }
    if (!_leftSelectionAnchor.superview) {// 若没有在父视图上，则默认在起点位置
        [self addSubview:_leftSelectionAnchor];
    }
    return _leftSelectionAnchor;
}
-(UIImageView *)rightSelectionAnchor{
    if (!_rightSelectionAnchor) {
        _rightSelectionAnchor = [SelectionAnchor anchor:NO lineHeight:[UIFont systemFontOfSize:self.data.config.textSize].lineHeight];
    }
    if (!_rightSelectionAnchor.superview) {
        [self addSubview:_rightSelectionAnchor];
    }
    return _rightSelectionAnchor;
}

- (void)setupGestures {
    
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(userTapGestureDetected:)];
    [self addGestureRecognizer:_tapRecognizer];
    _tapRecognizer.delegate = self;
    
    
    _longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(userLongPressedGuestureDetected:)];
    [self addGestureRecognizer:_longPressRecognizer];
    _longPressRecognizer.delegate = self;
    
    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(userPanGuestureDetected:)];
    [self addGestureRecognizer:_panRecognizer];
    _panRecognizer.delegate = self;
    
    
    self.userInteractionEnabled = YES;
}



#pragma mark -------------------------数据源变动-------------------------

- (void)setData:(CTData *)data {
    _data = data;
    self.layer.contents = (__bridge id)data.contents.CGImage;
    self.state = CTDisplayViewStateNormal;
}

- (void)setState:(CTDisplayViewState)state {
    if (_state == state) {
        return;
    }
    _state = state;
    
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    
    if ([gestureRecognizer isKindOfClass:UITapGestureRecognizer.class]) {
        return NO;
    }
    if ([gestureRecognizer isKindOfClass:UILongPressGestureRecognizer.class]) {
        return YES;
    }
    
    if ([gestureRecognizer isKindOfClass:UIPanGestureRecognizer.class]) {
        
        if (self.state == CTDisplayViewStateNormal){
            return NO;
        }
        
        if (self.state == CTDisplayViewStateSelected){
            return YES;
        }
    }
    return NO;
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *vv = [super hitTest:point withEvent:event];
    if (!vv) {
        self.selectionStartPosition = 0;
        self.selectionEndPosition = 0;
        [self.leftSelectionAnchor removeFromSuperview];
        [self.rightSelectionAnchor removeFromSuperview];
        [self setNeedsDisplay];
    }
    return vv;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL res = [super pointInside:point withEvent:event];
    if (!res) {
        self.selectionStartPosition = 0;
        self.selectionEndPosition = 0;
        [self.leftSelectionAnchor removeFromSuperview];
        [self.rightSelectionAnchor removeFromSuperview];
        [self setNeedsDisplay];
    }
    return res;
}

#pragma mark -------------------------绘图-------------------------

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    
    // 文字重新绘制
    [self.data.contents drawInRect:self.bounds];
    
    // 绘制选择区域
    //    [self drawTempRect];
    [self drawSelectionArea];
}
#pragma mark 绘制填充区域
- (void)drawSelectionArea {
    
    // 没有文字被选择，则不绘制
    if (_selectionEndPosition <= 0) {
        return;
    }
    
    CGAffineTransform transform =  CGAffineTransformMakeTranslation(0, self.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.f, -1.f);
    
    CTFrameRef textFrame = self.data.ctFrame;
    CFArrayRef lines = CTFrameGetLines(self.data.ctFrame);
    if (!lines) {
        return;
    }
    
    CFIndex count = CFArrayGetCount(lines);
    // 获得每一行的origin坐标
    CGPoint origins[count];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0,0), origins);
    
    for (int i = 0; i < count; i++) {
        // ------------------------画选中区域------------------------
        //每一行的origin
        CGPoint linePoint = origins[i];
        // CTLine
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        // 行信息
        CGFloat ascent, descent, leading, width, offset_left, offset_right;
        width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
        // 当position不在line中时，offset为0
        offset_left = CTLineGetOffsetForStringIndex(line, _selectionStartPosition, NULL);
        offset_right = CTLineGetOffsetForStringIndex(line, _selectionEndPosition, NULL);
        
        CGFloat selectWidth = 0;
        if (offset_left == 0 && offset_right == 0) {
            selectWidth = 0;
        } else if (offset_left == 0 && offset_right != 0) {
            selectWidth = offset_right;
        } else if (offset_left != 0 && offset_right == 0) {
            selectWidth = width - offset_left;
        } else {
            selectWidth = offset_right - offset_left;
        }
        CGRect lineRect = CGRectMake(linePoint.x + offset_left,
                                     linePoint.y - descent,
                                     selectWidth,
                                     ascent + descent + self.data.config.lineSpace);
        
        lineRect = CGRectApplyAffineTransform(lineRect, transform);
        
        
        [self fillSelectionAreaInRect:lineRect];
        
        
        // ------------------------移动锚点------------------------
        
        CFRange rag = CTLineGetStringRange(line);
        
        if (_selectionStartPosition >= rag.location && _selectionStartPosition <= rag.location + rag.length) {
            CGRect leftFrame = self.leftSelectionAnchor.frame;
            leftFrame.origin = CGPointMake(offset_left - 5, linePoint.y - descent);
            leftFrame = CGRectApplyAffineTransform(leftFrame, transform);
            self.leftSelectionAnchor.frame = leftFrame;
        }
        
        if (_selectionEndPosition >= rag.location && _selectionEndPosition <= rag.location + rag.length) {
            CGRect leftFrame = self.rightSelectionAnchor.frame;
            leftFrame.origin = CGPointMake(offset_right - 5, linePoint.y - descent - 10);
            leftFrame = CGRectApplyAffineTransform(leftFrame, transform);
            self.rightSelectionAnchor.frame = leftFrame;
        }
    }
    
}

#pragma mark 长按手势
- (void)userLongPressedGuestureDetected:(UILongPressGestureRecognizer *)recognizer {
    
    CGPoint curPoint = [recognizer locationInView:self];
    if (!CGRectContainsPoint(self.bounds, curPoint)){
        return;
    }
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.selectionStartPosition = 0;
            self.selectionEndPosition = self.data.msgString.length;
            self.state = CTDisplayViewStateSelected;
            [self setNeedsDisplay];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            //            self.magnifierView.touchPoint = curPoint;
        }
            break;
        default:
        {
            //            [self.magnifierView removeFromSuperview];
        }
            break;
    }
}



#pragma mark 拖动手势
- (void)userPanGuestureDetected:(UIGestureRecognizer *)recognizer {
    
    if (self.state == CTDisplayViewStateNormal) {
//        NSLog(@"不在拖动态");
        return;
    }
    
    
    CGPoint loc = [recognizer locationInView:self];
    
    if (!CGRectContainsPoint(self.frame, loc)){
        [self.magnifierView removeFromSuperview];
//        NSLog(@"在视图上");
    } else {
//        NSLog(@"不在视图上");
    }
    
    BOOL inLeft = CGRectContainsPoint(expangRectToRect(self.leftSelectionAnchor.frame, CGSizeMake(60, 150)), loc);
    BOOL inRight = CGRectContainsPoint(expangRectToRect(self.rightSelectionAnchor.frame, CGSizeMake(60, 50)), loc);
    
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            self.magnifierView.touchPoint = loc;
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            self.state = CTDisplayViewStateSelecting;
            
            // 获得文字的index
            CTLinkConfig config = [CoreTextUtils touchContentOffsetInView:self atPoint:loc data:self.data];
            
            if (config.index == -1) {
//                NSLog(@"不能拖了");
                return;
            }
            
            if (inLeft) {
                if (config.index >= _selectionEndPosition) {
//                    NSLog(@"不能拖了");
                    return;
                }
                _selectionStartPosition = config.index;
                self.magnifierView.touchPoint = loc;
            } else {
                if (config.index <= _selectionStartPosition) {
                    return;
                }
                _selectionEndPosition = config.index;
                self.magnifierView.touchPoint = loc;
            }
            
            [self setNeedsDisplay];
            
        }
            break;
        default:
        {
            self.state = CTDisplayViewStateSelected;
            [self.magnifierView removeFromSuperview];
        }
            break;
    }
    
}

#pragma mark 点击手势
- (void)userTapGestureDetected:(UIGestureRecognizer *)recognizer {
    
}

#pragma mark  ------------------工具方法------------------

CGRect expangRectToRect(CGRect originR, CGSize target){
    CGFloat mdX = CGRectGetMidX(originR);
    CGFloat mdY = CGRectGetMidY(originR);
    return  CGRectMake(mdX - target.width * 0.5, mdY - target.height * 0.5, target.width, target.height);
}

#pragma mark 工具方法 填充context颜色
- (void)fillSelectionAreaInRect:(CGRect)rect {
    
    UIColor *bgColor = RGBA(81, 110, 222, 0.6);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, bgColor.CGColor);
    CGContextFillRect(context, rect);
}

#pragma mark 菜单相关方法
- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    
    if (action == @selector(copy:) || action == @selector(selectAll:)) {
        return YES;
    }
    return NO;
}

- (BOOL)canBecomeFirstResponder {
    return YES;
}

- (void)copy:(UIMenuController *)menu
{
    //复制文字到剪切板
    if (!self.data.msgString) return;
    //复制文字到剪切板
    UIPasteboard * paste = [UIPasteboard generalPasteboard];
    paste.string = self.data.msgString;
}

- (void)selectAll:(UIMenuController *)menu
{
    
}

@end

