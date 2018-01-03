//
//  CDLabel.m
//  CDLabel
//
//  Created by chdo on 2017/12/1.
//


/*
 http://eim-talk-stg.dmzstg.pingan.com.cn/appim-pir/talk?weAppNo=PAKDZS_09&businessType=KDZS&encryptStr=clientImNo=E703B3776D5424B4B|customerNo=|customerName=|nickName=&extraInfo={%22umId%22:%22LIUFEI004%22,%22flag%22:%22Y%22,%22phoneNumber%22:%2213501020305%22,%22managerName%22:%22%E8%B7%AF%E4%BA%BA%E7%94%B2%22}#
 */
#import "CDLabel.h"
#import "MagnifiterView.h"
#import "CTHelper.h"
#import "CDLabelMacro.h"
#import "CoreTextUtils.h"
#import "CTClickInfo.h"

NSString *const  CTCLICKMSGEVENTNOTIFICATION = @"CTCLICKMSGEVENTNOTIFICATION";

typedef enum CTDisplayViewState : NSInteger {
    CTDisplayViewStateNormal,       // 普通状态
    CTDisplayViewStateTouching,     // 正在按下，需要弹出放大镜
    CTDisplayViewStateSelecting     // 选中了一些文本，需要弹出复制菜单
}CTDisplayViewState;

#define ANCHOR_TARGET_TAG 1

@interface CDLabel()<UIGestureRecognizerDelegate>

@property (nonatomic) NSInteger selectionStartPosition;
@property (nonatomic) NSInteger selectionEndPosition;
@property (nonatomic) CTDisplayViewState state;
@property (strong, nonatomic) UIImageView *leftSelectionAnchor;
@property (strong, nonatomic) UIImageView *rightSelectionAnchor;
@property (strong, nonatomic) MagnifiterView *magnifierView;

@end

@implementation CDLabel

- (id)init {
    [self setupEvents];
    return [self initWithFrame:CGRectZero];
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor whiteColor];
    [self setupEvents];
    return self;
}

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
    if (_state == CTDisplayViewStateNormal) {
        _selectionStartPosition = -1;
        _selectionEndPosition = -1;
        [self removeSelectionAnchor];
        [self removeMaginfierView];
        [self hideMenuController];
    } else if (_state == CTDisplayViewStateTouching) {
        if (_leftSelectionAnchor == nil && _rightSelectionAnchor == nil) {
            [self setupAnchors];
            // 移动光标位置
        }
    } else if (_state == CTDisplayViewStateSelecting) {
        if (_leftSelectionAnchor == nil && _rightSelectionAnchor == nil) {
            [self setupAnchors];
        }
        
        if (_leftSelectionAnchor.tag != ANCHOR_TARGET_TAG && _rightSelectionAnchor.tag != ANCHOR_TARGET_TAG) {
            [self removeMaginfierView];
            [self hideMenuController];
        }
    }
//    [self setNeedsDisplay];
}

- (MagnifiterView *)magnifierView {
    if (_magnifierView == nil) {
        _magnifierView = [[MagnifiterView alloc] init];
        _magnifierView.viewToMagnify = self;
        [self addSubview:_magnifierView];
    }
    return _magnifierView;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];

//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
//    CGContextTranslateCTM(context, 0, self.bounds.size.height);
//    CGContextScaleCTM(context, 1.0, -1.0);
//
//    if (self.state == CTDisplayViewStateTouching || self.state == CTDisplayViewStateSelecting) {
//        [self drawSelectionArea];
//        [self drawAnchors];
//    }
    
    [self drawSelectionArea];
}

- (void)setupEvents {
    
    UIGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(userTapGestureDetected:)];
    [self addGestureRecognizer:tapRecognizer];
    
    UIGestureRecognizer *longPressRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self
                                                                                action:@selector(userLongPressedGuestureDetected:)];
    [self addGestureRecognizer:longPressRecognizer];
    
    UIGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(userPanGuestureDetected:)];
    [self addGestureRecognizer:panRecognizer];
    
    self.userInteractionEnabled = YES;
}


- (void)setupAnchors {
    _leftSelectionAnchor = [self createSelectionAnchorWithTop:YES];
    _rightSelectionAnchor = [self createSelectionAnchorWithTop:NO];
    [self addSubview:_leftSelectionAnchor];
    [self addSubview:_rightSelectionAnchor];
}

#pragma mark 点击手势
- (void)userTapGestureDetected:(UIGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:self];
    if (_state == CTDisplayViewStateNormal) {
        // 图片点击事件
        for (CTImageData * imageData in self.data.imageArray) {
            /// 翻转坐标系，因为imageData中的坐标是CoreText的坐标系
            CGRect imageRect = imageData.imagePosition;
            CGPoint imagePosition = imageRect.origin;
            imagePosition.y = self.bounds.size.height - imageRect.origin.y - imageRect.size.height;
            /// 图片rect
            CGRect rect = CGRectMake(imagePosition.x, imagePosition.y, imageRect.size.width, imageRect.size.height);
            /// 检测点击位置 Point 是否在rect之内
            if (CGRectContainsPoint(rect, point)) {
                // 在这里处理点击后的逻辑
                [[CTClickInfo info:CTClickEventTypeIMAGE msgText:self.data.msgString containerView:self
                       clickedText:imageData.name textRang: imageData.range
                clickedTextContent:nil image:[CTHelper emoticonDic][imageData.name] imageRect:rect] sendMessage];
                return;
            }
        }
        // 链接点击事件
        CTLinkData *linkData = [CoreTextUtils touchLinkInView:self atPoint:point data:self.data];
        if (linkData) {
            [[CTClickInfo info:CTClickEventTypeTEXT msgText:self.data.msgString containerView:self clickedText:linkData.title textRang:linkData.range clickedTextContent:linkData.url image:nil imageRect:CGRectNull] sendMessage];
            return;
        }
    } else {
        self.state = CTDisplayViewStateNormal;
    }
}

#pragma mark 长按手势
- (void)userLongPressedGuestureDetected:(UILongPressGestureRecognizer *)recognizer {
    CGPoint point = [recognizer locationInView:self];
    
    // 手势开始   弹出放大镜
    if (recognizer.state == UIGestureRecognizerStateBegan ||
        recognizer.state == UIGestureRecognizerStateChanged) {
        CTLinkConfig config = [CoreTextUtils touchContentOffsetInView:self atPoint:point data:self.data];
        
        if (config.index != -1 && config.index < self.data.content.length) {
            _selectionStartPosition = config.index;
            _selectionEndPosition = config.index + 2;
        }
        
        [self setNeedsDisplay];
//        self.magnifierView.touchPoint = point;
        self.state = CTDisplayViewStateTouching;
    } else {
    // 手势结束   在可选择区域，需弹菜单
        if (_selectionStartPosition >= 0 && _selectionEndPosition <= self.data.content.length) {
            self.state = CTDisplayViewStateSelecting;
            [self showMenuController];
        } else {
            self.state = CTDisplayViewStateNormal;
        }
    }
}

#pragma mark 拖动手势
- (void)userPanGuestureDetected:(UIGestureRecognizer *)recognizer {
    
    if (self.state == CTDisplayViewStateNormal) {
        return;
    }
    CGPoint point = [recognizer locationInView:self];
    if (recognizer.state == UIGestureRecognizerStateBegan) {
//    手势开始
        
        if (_leftSelectionAnchor && CGRectContainsPoint(CGRectInset(_leftSelectionAnchor.frame, -25, -6), point)) {
            //左光标 被拖动
            _leftSelectionAnchor.tag = ANCHOR_TARGET_TAG;
            [self hideMenuController];
        } else if (_rightSelectionAnchor && CGRectContainsPoint(CGRectInset(_rightSelectionAnchor.frame, -25, -6), point)) {
            //右光标 被拖动
            _rightSelectionAnchor.tag = ANCHOR_TARGET_TAG;
            [self hideMenuController];
        }
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
//    手势移动
        CTLinkConfig config = [CoreTextUtils touchContentOffsetInView:self atPoint:point data:self.data];
        if (config.index == -1) {
            return;
        }
        if (_leftSelectionAnchor.tag == ANCHOR_TARGET_TAG && config.index < _selectionEndPosition) {
            _selectionStartPosition = config.index;
            self.magnifierView.touchPoint = point;
            [self hideMenuController];
        } else if (_rightSelectionAnchor.tag == ANCHOR_TARGET_TAG && config.index > _selectionStartPosition) {
            _selectionEndPosition = config.index;
            self.magnifierView.touchPoint = point;
            [self hideMenuController];
        }
    } else if (recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
//    手势结束
        _leftSelectionAnchor.tag = 0;
        _rightSelectionAnchor.tag = 0;
        [self removeMaginfierView];
        [self showMenuController];
    }
//    [self setNeedsDisplay];
    
}

#pragma mark 移除光标
- (void)removeSelectionAnchor {
    if (_leftSelectionAnchor) {
        [_leftSelectionAnchor removeFromSuperview];
        _leftSelectionAnchor = nil;
    }
    if (_rightSelectionAnchor) {
        [_rightSelectionAnchor removeFromSuperview];
        _rightSelectionAnchor = nil;
    }
}
#pragma mark 移除放大镜
- (void)removeMaginfierView {
    if (_magnifierView) {
        [_magnifierView removeFromSuperview];
        _magnifierView = nil;
    }
}

#pragma mark 显示菜单视图
- (void)showMenuController {
    if ([self becomeFirstResponder]) {
        CGRect selectionRect = [self rectForMenuController];
        // 翻转坐标系
        CGAffineTransform transform =  CGAffineTransformMakeTranslation(0, self.bounds.size.height);
        transform = CGAffineTransformScale(transform, 1.f, -1.f);
        selectionRect = CGRectApplyAffineTransform(selectionRect, transform);
        
        UIMenuController *theMenu = [UIMenuController sharedMenuController];
        [theMenu setTargetRect:selectionRect inView:self];
        [theMenu setMenuVisible:YES animated:YES];
    }
}

#pragma mark 隐藏菜单视图
- (void)hideMenuController {
    if ([self resignFirstResponder]) {
        UIMenuController *theMenu = [UIMenuController sharedMenuController];
        [theMenu setMenuVisible:NO animated:YES];
    }
}
#pragma mark 移动光标
- (void)drawAnchors {
    
    if (_selectionStartPosition < 0 || _selectionEndPosition > self.data.content.length) {
        return;
    }
    CTFrameRef textFrame = self.data.ctFrame;
    CFArrayRef lines = CTFrameGetLines(self.data.ctFrame);
    if (!lines) {
        return;
    }
    
    // 翻转坐标系
    CGAffineTransform transform =  CGAffineTransformMakeTranslation(0, self.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.f, -1.f);
    
    CFIndex count = CFArrayGetCount(lines);
    // 获得每一行的origin坐标
    CGPoint origins[count];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0,0), origins);
    for (int i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CFRange range = CTLineGetStringRange(line);
        
        if ([self isPosition:_selectionStartPosition inRange:range]) {
            CGFloat ascent, descent, leading, offset;
            offset = CTLineGetOffsetForStringIndex(line, _selectionStartPosition, NULL);
            CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
            CGPoint origin = CGPointMake(linePoint.x + offset - 5, linePoint.y + ascent + 11);
            origin = CGPointApplyAffineTransform(origin, transform);
            CGRect imagFrame = _leftSelectionAnchor.frame;
            imagFrame.origin = origin;
            _leftSelectionAnchor.frame = imagFrame;
        }
        if ([self isPosition:_selectionEndPosition inRange:range]) {
            CGFloat ascent, descent, leading, offset;
            offset = CTLineGetOffsetForStringIndex(line, _selectionEndPosition, NULL);
            CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
            CGPoint origin = CGPointMake(linePoint.x + offset - 5, linePoint.y + ascent + 11);
            origin = CGPointApplyAffineTransform(origin, transform);
            CGRect imagFrame = _rightSelectionAnchor.frame;
            imagFrame.origin = origin;
            _rightSelectionAnchor.frame = imagFrame;
            break;
        }
    }
}
#pragma mark 填充选择区域
- (void)drawSelectionArea {
    
//    if (_selectionStartPosition < 0 || _selectionEndPosition > self.data.content.length) {
//        return;
//    }
//
    
    CGAffineTransform transform =  CGAffineTransformMakeTranslation(0, self.bounds.size.height);
    transform = CGAffineTransformScale(transform, 1.f, -1.f);
    
    [self.data.contents drawInRect:self.bounds];
    
    CTFrameRef textFrame = self.data.ctFrame;
    CFArrayRef lines = CTFrameGetLines(self.data.ctFrame);
    if (!lines) {
        return;
    }
    CFIndex count = CFArrayGetCount(lines);
    // 获得每一行的origin坐标
    CGPoint origins[count];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0,0), origins);
    
    
    CGPoint linePoint = origins[0];
    CTLineRef line = CFArrayGetValueAtIndex(lines, 0);
    CGFloat ascent, descent, leading, offset, offset2;
    offset = CTLineGetOffsetForStringIndex(line, 0, NULL);
    offset2 = CTLineGetOffsetForStringIndex(line, 10, NULL);
    CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGRect lineRect = CGRectMake(linePoint.x + offset, linePoint.y - descent, offset2 - offset, ascent + descent);
    lineRect = CGRectApplyAffineTransform(lineRect, transform);
    [self fillSelectionAreaInRect:lineRect];
    
    
//    for (int i = 0; i < count; i++) {
//        CGPoint linePoint = origins[i];
//        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
//        CFRange range = CTLineGetStringRange(line);
//        // 1. start和end在一个line,则直接弄完break
//        if ([self isPosition:_selectionStartPosition inRange:range] && [self isPosition:_selectionEndPosition inRange:range]) {
//            CGFloat ascent, descent, leading, offset, offset2;
//            offset = CTLineGetOffsetForStringIndex(line, _selectionStartPosition, NULL);
//            offset2 = CTLineGetOffsetForStringIndex(line, _selectionEndPosition, NULL);
//            CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
//            CGRect lineRect = CGRectMake(linePoint.x + offset, linePoint.y - descent, offset2 - offset, ascent + descent);
//            [self fillSelectionAreaInRect:lineRect];
//            break;
//        }
//
//        // 2. start和end不在一个line
//        // 2.1 如果start在line中，则填充Start后面部分区域
//        if ([self isPosition:_selectionStartPosition inRange:range]) {
//            CGFloat ascent, descent, leading, width, offset;
//            offset = CTLineGetOffsetForStringIndex(line, _selectionStartPosition, NULL);
//            width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
//            CGRect lineRect = CGRectMake(linePoint.x + offset, linePoint.y - descent, width - offset, ascent + descent);
//            [self fillSelectionAreaInRect:lineRect];
//        } // 2.2 如果 start在line前，end在line后，则填充整个区域
//        else if (_selectionStartPosition < range.location && _selectionEndPosition >= range.location + range.length) {
//            CGFloat ascent, descent, leading, width;
//            width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
//            CGRect lineRect = CGRectMake(linePoint.x, linePoint.y - descent, width, ascent + descent);
//            [self fillSelectionAreaInRect:lineRect];
//        } // 2.3 如果start在line前，end在line中，则填充end前面的区域,break
//        else if (_selectionStartPosition < range.location && [self isPosition:_selectionEndPosition inRange:range]) {
//            CGFloat ascent, descent, leading, width, offset;
//            offset = CTLineGetOffsetForStringIndex(line, _selectionEndPosition, NULL);
//            width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
//            CGRect lineRect = CGRectMake(linePoint.x, linePoint.y - descent, offset, ascent + descent);
//            [self fillSelectionAreaInRect:lineRect];
//        }
//    }
}

#pragma mark 计算选择区域位置
- (CGRect)rectForMenuController {
    if (_selectionStartPosition < 0 || _selectionEndPosition > self.data.content.length) {
        return CGRectZero;
    }
    CTFrameRef textFrame = self.data.ctFrame;
    CFArrayRef lines = CTFrameGetLines(self.data.ctFrame);
    if (!lines) {
        return CGRectZero;
    }
    CFIndex count = CFArrayGetCount(lines);
    // 获得每一行的origin坐标
    CGPoint origins[count];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0,0), origins);
    
    CGRect resultRect = CGRectZero;
    for (int i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CFRange range = CTLineGetStringRange(line);
        // 1. start和end在一个line,则直接弄完break
        if ([self isPosition:_selectionStartPosition inRange:range] && [self isPosition:_selectionEndPosition inRange:range]) {
            CGFloat ascent, descent, leading, offset, offset2;
            offset = CTLineGetOffsetForStringIndex(line, _selectionStartPosition, NULL);
            offset2 = CTLineGetOffsetForStringIndex(line, _selectionEndPosition, NULL);
            CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
            CGRect lineRect = CGRectMake(linePoint.x + offset, linePoint.y - descent, offset2 - offset, ascent + descent);
            resultRect = lineRect;
            break;
        }
    }
    if (!CGRectIsEmpty(resultRect)) {
        return resultRect;
    }
    
    // 2. start和end不在一个line
    for (int i = 0; i < count; i++) {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CFRange range = CTLineGetStringRange(line);
        // 如果start在line中，则记录当前为起始行
        if ([self isPosition:_selectionStartPosition inRange:range]) {
            CGFloat ascent, descent, leading, width, offset;
            offset = CTLineGetOffsetForStringIndex(line, _selectionStartPosition, NULL);
            width = CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
            CGRect lineRect = CGRectMake(linePoint.x + offset, linePoint.y - descent, width - offset, ascent + descent);
            resultRect = lineRect;
        }
    }
    return resultRect;
}
#pragma mark  工具方法
- (BOOL)isPosition:(NSInteger)position inRange:(CFRange)range {
    
    if (position >= range.location && position < range.location + range.length) {
        return YES;
    } else {
        return NO;
    }
    
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
    //    action == @selector(cut:) || || action == @selector(paste:)
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

#pragma mark 创建光标方法
- (UIImageView *)createSelectionAnchorWithTop:(BOOL)isTop {
    
    // 行高
    CGFloat font_height = [UIFont systemFontOfSize:self.data.config.textSize].lineHeight;
    // 指针
    UIImage *image = [self cursorWithFontHeight:font_height isTop:isTop];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    CGFloat pinWidth = 10.0f;

    if (isTop) {
        imageView.frame = CGRectMake(10, -pinWidth, pinWidth, font_height + pinWidth);
    } else {
        imageView.frame = CGRectMake(40, 0, pinWidth, font_height + pinWidth);
    }
    
    return imageView;
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
