//
//  CTInputView.m
//  CDChatList
//
//  Created by chdo on 2017/12/12.
//

#import "CTInputView.h"
#import "CTTextView.h"

@interface CTInputView()
{
    CGRect currentRect;
}
@property (nonatomic, strong) UITextView *textView;

// 容器视图  包含除输入框外的所有视图
@property (nonatomic, strong) UIView *containerView;
@end

@implementation CTInputView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = CRMHexColor(0xF5F5F7);
    currentRect = frame;
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
    
    [textView textValueDidChanged:^(NSString *text, CGFloat textHeight) {
//        CGRect frame = textView.frame;
//        frame.size.height = textHeight;
        [self updateLayout:textHeight];
//        textView.frame = frame;
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
    CGRect keyBoardEndFrmae = ((NSValue * )dic[UIKeyboardFrameEndUserInfoKey]).CGRectValue;
    
    CGRect inputNewFrame = CGRectMake(self.frame.origin.x, keyBoardEndFrmae.origin.y - CTInputViewHeight, self.frame.size.width, CTInputViewHeight);
    [UIView animateWithDuration:duration.doubleValue delay:0 options:curv.integerValue animations:^{
        self.frame = inputNewFrame;
        currentRect = inputNewFrame;
    } completion:^(BOOL finished) {
        
    }];
}
// 适应输入框高度变化
-(void)updateLayout:(CGFloat)newTextViewHight{
    
    CTInputConfiguration *config = [CTinputHelper defaultConfiguration];
    CGRect newTextViewRect = self.textView.frame;
    newTextViewRect.size.height = newTextViewHight;

    CGFloat delta = config.inputViewRect.size.height - newTextViewHight;
    CGRect newRect = CGRectOffset(currentRect, 0, delta);
    newRect.size.height = newRect.size.height - delta;
    self.frame = newRect;
    self.textView.frame = newTextViewRect;

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
