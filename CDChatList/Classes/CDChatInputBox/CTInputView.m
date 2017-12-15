//
//  CTInputView.m
//  CDChatList
//
//  Created by chdo on 2017/12/12.
//

#import "CTInputView.h"
#import "CTTextView.h"


@implementation NSArray (chinese)

- (NSString *)descriptionWithLocale:(id)locale
{
    
    
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:@"(\n"];
    
    for (id obj in self) {
        [strM appendFormat:@"\t\t%@,\n", obj];
    }
    [strM appendString:@")"];
    
    return strM;
}

@end


@implementation NSDictionary (chinese)

- (NSString *)descriptionWithLocale:(id)locale
{
    
    NSMutableString *strM = [NSMutableString string];
    [strM appendString:@"{\n"];
    
    for (id obj in [self allKeys]) {
        [strM appendFormat:@"\t\t%@,", obj];
        
        [strM appendFormat:@"%@\n", self[obj]];
    }
    
    [strM appendString:@"}"];
    
    return strM;
}


@end

@interface CTInputView()
{
    CGRect originRect;   // 根据键盘是否弹起，整个值有可能是底部的是在底部的rect  也可能是上面的rect
}
@property (nonatomic, strong) UITextView *textView;

// 容器视图  包含除输入框外的所有视图
@property (nonatomic, strong) UIView *containerView;
@end

@implementation CTInputView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = CRMHexColor(0xF5F5F7);
    originRect = frame;
    // 容器
    self.containerView = [[UIView alloc] initWithFrame:self.bounds];
    self.containerView.backgroundColor = self.backgroundColor;
    [self addSubview:self.containerView];
    
    
    UIImage *emojIcon = [CTinputHelper defaultImageDic][@"emojIcon"];
    UIImage *moreIcon = [CTinputHelper defaultImageDic][@"addIcon"];
    
    CTInputConfiguration *config = [CTinputHelper defaultConfiguration];
    [config addEmoji];
    [config addVoice];
    [config addExtra:@{}];
    
    UIButton *v1 = [[UIButton alloc] initWithFrame:config.voiceButtonRect];
    [v1 setImage:emojIcon forState:UIControlStateNormal];
    v1.tag = 1;
    [v1 addTarget:self action:@selector(tagbut:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:v1];
    
    CTTextView *textView = [[CTTextView alloc] initWithFrame:config.inputViewRect];
    
    textView.font = config.stringFont;
    textView.maxNumberOfLines = 5;
    self.textView = textView;
    [self addSubview:textView];
    __weak __typeof__ (self) wself = self;
    [textView textValueDidChanged:^(NSString *text, CGFloat textHeight) {
        __strong __typeof (wself) sself = wself;
        [sself updateLayout:textHeight];
    }];
    
    UIButton *v3 = [[UIButton alloc] initWithFrame:config.emojiButtonRect];
    [v3 setImage:emojIcon forState:UIControlStateNormal];
    v3.selected = NO;
    v3.tag = 3;
    [v3 addTarget:self action:@selector(tagbut:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:v3];
    
    UIButton *v4 = [[UIButton alloc] initWithFrame:config.moreButtonRect];
    [v4 setImage:moreIcon forState:UIControlStateNormal];
    v4.tag = 4;
    [v4 addTarget:self action:@selector(tagbut:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:v4];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNoitfication:) name:UIKeyboardWillChangeFrameNotification object:nil];

    return self;
}

-(void)tagbut:(UIButton *)but{
    [AATHUD showInfo:[NSString stringWithFormat:@"%ld",(long)but.tag] andDismissAfter:0.5];
}

// 键盘事件
-(void)receiveNoitfication:(NSNotification *)noti{

    NSDictionary *dic = noti.userInfo;
    NSNumber *curv = dic[UIKeyboardAnimationCurveUserInfoKey];
    NSNumber *duration = dic[UIKeyboardAnimationDurationUserInfoKey];
    // 键盘Rect
    CGRect keyBoardEndFrmae = ((NSValue * )dic[UIKeyboardFrameEndUserInfoKey]).CGRectValue;
    
    CGRect selfNewFrame = CGRectMake(self.frame.origin.x,
                                      keyBoardEndFrmae.origin.y - self.frame.size.height,
                                      self.frame.size.width, self.frame.size.height);
//    CGFloat singleLineHight = originRect.size.height;
//    CGFloat originX = originRect.origin.x;
//    originRect = selfNewFrame;
//    originRect.size.height = singleLineHight;
    
    originRect.origin.y = selfNewFrame.origin.y - (originRect.size.height - selfNewFrame.size.height);
    
    [UIView animateWithDuration:duration.doubleValue delay:0 options:curv.integerValue animations:^{
        self.frame = selfNewFrame;
    } completion:^(BOOL finished) {
    }];
}
// 适应输入框高度变化
-(void)updateLayout:(CGFloat)newTextViewHight{
    
    // 输入框默认位置
    CTInputConfiguration *config = [CTinputHelper defaultConfiguration];
    
    // 更新后的输入框的位置
    CGRect newTextViewRect = self.textView.frame;
    newTextViewRect.size.height = newTextViewHight;

    // 输入框的高度变化
    CGFloat delta = config.inputViewRect.size.height - newTextViewHight;
    // 根据输入框的变化修改整个视图的位置
    CGRect newRect = CGRectOffset(originRect, 0, delta);
    newRect.size.height = newRect.size.height - delta;
    
    [UIView animateWithDuration:0.2 animations:^{
        self.frame = newRect;
        self.textView.frame = newTextViewRect;
    }];
}

-(BOOL)becomeFirstResponder{
    [self.textView becomeFirstResponder];
    return [super becomeFirstResponder];
}

-(BOOL)resignFirstResponder{
    [self.textView resignFirstResponder];
    return [super resignFirstResponder];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
