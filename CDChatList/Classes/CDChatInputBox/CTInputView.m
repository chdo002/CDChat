//
//  CTInputView.m
//  CDChatList
//
//  Created by chdo on 2017/12/12.
//

#import "CTInputView.h"
#import "CTTextView.h"
#import "UITool.h"
#import "CTEmojiKeyboard.h"
#import "UITool.h"
#import "AATVoiceHudAlert.h"
#import "AATAudioTool.h"

@interface EmojiTextAttachment : NSTextAttachment
@property(strong, nonatomic) NSString *emojiTag;
+ (NSString *)getPlainString:(NSAttributedString *)attributString;
@end

@implementation EmojiTextAttachment


+ (NSString *)getPlainString:(NSAttributedString *)attributString {
    
    NSMutableString *plainString = [NSMutableString stringWithString:attributString.string];
    __block NSUInteger base = 0;
    
    [attributString enumerateAttribute:NSAttachmentAttributeName inRange:NSMakeRange(0, attributString.length)
                     options:0
                  usingBlock:^(id value, NSRange range, BOOL *stop) {
                      if (value && [value isKindOfClass:[EmojiTextAttachment class]]) {
                          [plainString replaceCharactersInRange:NSMakeRange(range.location + base, range.length)
                                                     withString:((EmojiTextAttachment *) value).emojiTag];
                          base += ((EmojiTextAttachment *) value).emojiTag.length - 1;
                      }
                  }];
    return plainString;
}
@end


@interface CTInputView()<CTEmojiKeyboardDelegare,CTMoreKeyBoardDelegare,UITextViewDelegate,AATAudioToolProtocol>
{
    CGRect originRect;   // 根据键盘是否弹起，整个值有可能是底部的是在底部的rect  也可能是上面的rect
    
    CGFloat tempTextViewHeight; // 在多行文字切换到语音功能时，需要临时保存textview的高度
    
    CTEmojiKeyboard *emojiKeyboard;
    CTMoreKeyBoard *moreKeyboard;
}
@property (nonatomic, strong) CTTextView *textView;
@property (nonatomic, strong) UIButton *voiceBut;
@property BOOL isRecordTouchingOutSide; // 手指是否在输入栏内部
@property (nonatomic, strong) UIButton *recordBut;
@property (nonatomic, strong) UIButton *emojiBut;
@property (nonatomic, strong) UIButton *moreBut;
@property (nonatomic, strong) NSArray *buttons;
// 容器视图  包含除输入框外的所有视图
@property (nonatomic, strong) UIView *containerView;


@end

@implementation CTInputView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    self.backgroundColor = CRMHexColor(0xF5F5F7);
    originRect = frame;
    
    // 三个按钮容器
    self.containerView = [[UIView alloc] initWithFrame:self.bounds];
    self.containerView.backgroundColor = self.backgroundColor;
    [self addSubview:self.containerView];
    
    // 图片资源
    UIImage *emojIcon = [CTinputHelper defaultImageDic][@"emojIcon"];
    UIImage *moreIcon = [CTinputHelper defaultImageDic][@"addIcon"];
    UIImage *keyboardIcon = [CTinputHelper defaultImageDic][@"keyboard"];
    UIImage *voice = [CTinputHelper defaultImageDic][@"voice"];
    
    // 配置
    CTInputConfiguration *config = [CTinputHelper defaultConfiguration];
    
    // 语音按钮
    UIButton *v1 = [[UIButton alloc] initWithFrame:config.voiceButtonRect];
    [v1 setImage:voice forState:UIControlStateNormal];
    [v1 setImage:keyboardIcon forState:UIControlStateSelected];
    v1.tag = 0;
    [v1 addTarget:self action:@selector(tagbut:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:v1];
    self.voiceBut = v1;
    
    // 输入框
    CTTextView *textView = [[CTTextView alloc] initWithFrame:config.inputViewRect];
    textView.font = config.stringFont;
    textView.maxNumberOfLines = 5;
    self.textView = textView;
    self.textView.returnKeyType = UIReturnKeySend;
    self.textView.delegate = self;
    [self addSubview:textView];
    __weak __typeof__ (self) wself = self;
    [textView textValueDidChanged:^(NSString *text, CGFloat textHeight) {
        __strong __typeof (wself) sself = wself;
        [sself updateLayout:textHeight];
    }];
    
    // 按住说话按钮
    UIButton *v2 = [[UIButton alloc] initWithFrame:config.inputViewRect];
    [v2 setTitle:@"按住 说话" forState:UIControlStateNormal];
    [v2 addTarget:self action:@selector(touchDownRecordButton1:) forControlEvents:UIControlEventTouchDown];
    [v2 addTarget:self action:@selector(touchDownRecordButton2:) forControlEvents:UIControlEventTouchUpInside];
    [v2 addTarget:self action:@selector(touchDownRecordButton3:) forControlEvents:UIControlEventTouchUpOutside];
    [v2 addTarget:self action:@selector(touchDownRecordButton4:) forControlEvents:UIControlEventTouchDragOutside];
    [v2 addTarget:self action:@selector(touchDownRecordButton5:) forControlEvents:UIControlEventTouchDragInside];
    
    [v2 setTitleColor:CRMHexColor(0x555555) forState:UIControlStateNormal];
    v2.layer.borderColor = CRMHexColor(0xC1C2C6).CGColor;
    v2.layer.borderWidth = 1;
    v2.layer.cornerRadius = 5;
    v2.backgroundColor = CRMHexColor(0xF6F6F8);
    [self.containerView addSubview:v2];
    self.recordBut = v2;
    
    
    // 表情按钮
    UIButton *v3 = [[UIButton alloc] initWithFrame:config.emojiButtonRect];
    [v3 setImage:emojIcon forState:UIControlStateNormal];
    [v3 setImage:keyboardIcon forState:UIControlStateSelected];
    v3.selected = NO;
    v3.tag = 1;
    [v3 addTarget:self action:@selector(tagbut:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:v3];
    self.emojiBut = v3;
    
    // '更多'按钮
    UIButton *v4 = [[UIButton alloc] initWithFrame:config.moreButtonRect];
    [v4 setImage:moreIcon forState:UIControlStateNormal];
    [v4 setImage:moreIcon forState:UIControlStateSelected];
    v4.tag = 2;
    [v4 addTarget:self action:@selector(tagbut:) forControlEvents:UIControlEventTouchUpInside];
    [self.containerView addSubview:v4];
    self.moreBut = v4;
    
    // 键盘注释
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNoitfication:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    
    emojiKeyboard = [CTEmojiKeyboard keyBoard];
    emojiKeyboard.emojiDelegate = self;
    
    moreKeyboard = [CTMoreKeyBoard keyBoard];
    moreKeyboard.moreKeyDelegate = self;
    
    return self;
}

-(NSArray *)buttons{
    return @[self.voiceBut, self.emojiBut, self.moreBut];
}
#pragma mark 声音，表情  更多  按钮点击
-(void)tagbut:(UIButton *)but{
    // 切换按钮icon
    [self turnButtonOnAtIndex:(int)but.tag];
    
    if (but.tag == 0) {
        // 语音
        if (self.voiceBut.isSelected) {
            tempTextViewHeight = self.textView.height;
            [self updateLayout:[CTinputHelper defaultConfiguration].emojiButtonRect.size.height];
            [self.textView resignFirstResponder];
            [self.textView setHidden:YES];
        } else {
            [self updateLayout:tempTextViewHeight];
            [self changeKeyBoard:nil];
            [self.textView setHidden:NO];
        }
    } else if (but.tag == 1) {
        // 表情
        if (self.emojiBut.isSelected) {
            [emojiKeyboard updateKeyBoard];
            [self changeKeyBoard:emojiKeyboard];
        } else {
            [self changeKeyBoard:nil];
        }

    } else if (but.tag == 2) {
        // 更多
        if (self.moreBut.isSelected) {
            [self changeKeyBoard:[CTMoreKeyBoard keyBoard]];
        } else {
            [self changeKeyBoard:nil];
        }
    }
}

-(void)changeKeyBoard:(UIView *)keyboard{
    [self.textView setHidden:NO];
    self.textView.inputView = keyboard;
    [self.textView reloadInputViews];
    [self.textView becomeFirstResponder];
}

#pragma mark 语音相关
// 按下
-(void)touchDownRecordButton1:(UIButton *)but{
//    开始录音
    [AATAudioTool checkCameraAuthorizationGrand:^{
        [[AATAudioTool share] startRecord];
        [AATVoiceHudAlert showPowerHud:1];
        self.isRecordTouchingOutSide = NO;
        [AATAudioTool share].delegate = self;
    } withNoPermission:^{
        
    }];
}
// 内部抬起
-(void)touchDownRecordButton2:(UIButton *)but{
    
//    结束录音
    [[AATAudioTool share] stopRecord];
    [AATVoiceHudAlert hideHUD];
}
// 外部抬起
-(void)touchDownRecordButton3:(UIButton *)but{
//    外部抬起，取消录音
    [[AATAudioTool share] intertrptRecord];
    [AATVoiceHudAlert hideHUD];
}
// 拖动到外部
-(void)touchDownRecordButton4:(UIButton *)but{
    self.isRecordTouchingOutSide = YES;
}
// 拖回内部
-(void)touchDownRecordButton5:(UIButton *)but{
    // 拖拽到内部，如果在录音，则恢复正常显示，否则什么都不做
    if ([AATAudioTool share].isRecorderRecording) {
        self.isRecordTouchingOutSide = NO;
    }
}

-(void)aatAudioToolDidStartRecord:(NSTimeInterval)currentTime{
    [AATVoiceHudAlert showPowerHud:1];
}

-(void)aatAudioToolUpdateCurrentTime:(NSTimeInterval)currentTime fromTime:(NSTimeInterval)startTime power:(float)power{
    
    if (self.isRecordTouchingOutSide){
        [AATVoiceHudAlert showRevocationHud];
    } else {
        [AATVoiceHudAlert showPowerHud:ceil(power * 10)];
    }
}

-(void)aatAudioToolDidStopRecord:(NSURL *)dataPath startTime:(NSTimeInterval)start endTime:(NSTimeInterval)end errorInfo:(NSString *)info{
    [self.delegate inputViewPopAudioath:dataPath];
    [AATAudioTool share].delegate = nil;
}
//
-(void)aatAudioToolDidSInterrupted{
    [AATAudioTool share].delegate = nil;
    [AATVoiceHudAlert showRevocationHud];
}

#pragma mark 文本 UITextViewDelegate

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([text isEqualToString:@"\n"]) {
        [self emojiKeyboardSelectSend];
        return NO;
    }
    return YES;
}

#pragma mark 表情 CTEmojiKeyboardDelegare

-(void)emojiKeyboardSelectKey:(NSString *)key image:(UIImage *)img{
    
    EmojiTextAttachment *attachment = [[EmojiTextAttachment alloc] init];
    attachment.emojiTag = key;
    attachment.image = img;
    
    attachment.bounds = CGRectMake(0,
                                   [CTinputHelper defaultConfiguration].stringFont.descender,
                                   [CTinputHelper defaultConfiguration].stringFont.lineHeight,
                                   [CTinputHelper defaultConfiguration].stringFont.lineHeight);
    
    NSMutableAttributedString *textAttr = [[NSMutableAttributedString alloc] initWithAttributedString:self.textView.attributedText];
    NSAttributedString *imageAttr = [NSMutableAttributedString attributedStringWithAttachment:attachment];
    [textAttr replaceCharactersInRange:self.textView.selectedRange withAttributedString:imageAttr];
    [textAttr addAttributes:@{NSFontAttributeName : self.textView.font} range:NSMakeRange(self.textView.selectedRange.location, 1)];
    self.textView.attributedText = textAttr;
    [self.textView textDidChange];
}

-(void)emojiKeyboardSelectDelete{
    [self.textView deleteBackward];
}

-(void)emojiKeyboardSelectSend{
    NSString *plainStr = [EmojiTextAttachment getPlainString: [self.textView.attributedText copy]];
    if ([self.delegate respondsToSelector:@selector(inputViewPopSttring:)]) {
        [self.delegate inputViewPopSttring:plainStr];
    }
    self.textView.text = @"";
    [self.textView textDidChange];
}

#pragma mark 更多 CTMoreKeyBoardDelegare
-(void)moreKeyBoardSelectKey:(NSString *)key image:(UIImage *)img{
    [self.delegate inputViewPopCommand:key];
}

#pragma mark 键盘通知
-(void)receiveNoitfication:(NSNotification *)noti{

    NSDictionary *dic = noti.userInfo;
    NSNumber *curv = dic[UIKeyboardAnimationCurveUserInfoKey];
    NSNumber *duration = dic[UIKeyboardAnimationDurationUserInfoKey];
    // 键盘Rect
    CGRect keyBoardEndFrmae = ((NSValue * )dic[UIKeyboardFrameEndUserInfoKey]).CGRectValue;
    
    CGRect selfNewFrame = CGRectMake(self.frame.origin.x,
                                      keyBoardEndFrmae.origin.y - self.frame.size.height,
                                      self.frame.size.width, self.frame.size.height);

    originRect.origin.y = selfNewFrame.origin.y - (originRect.size.height - selfNewFrame.size.height);
    
    if ([self.delegate respondsToSelector:@selector(inputViewWillUpdateFrame:animateDuration:animateOption:)]){
        [self.delegate inputViewWillUpdateFrame:selfNewFrame animateDuration:duration.doubleValue animateOption:curv.integerValue];
    }
    
    [UIView animateWithDuration:duration.doubleValue delay:0 options:curv.integerValue animations:^{
        self.frame = selfNewFrame;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark 适应输入框高度变化
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
    
    if ([self.delegate respondsToSelector:@selector(inputViewWillUpdateFrame:animateDuration:animateOption:)]){
        [self.delegate inputViewWillUpdateFrame:newRect animateDuration:0.25 animateOption:7];
    }
    [UIView animateWithDuration:0.25f delay:0 options:7 animations:^{
        self.frame = newRect;
        self.textView.frame = newTextViewRect;
    } completion:^(BOOL finished) {
        
    }];
}

#pragma mark 让输入框变成第一响应
-(BOOL)becomeFirstResponder{
    self.textView.inputView = nil;
    [self.textView becomeFirstResponder];
    [self turnButtonOnAtIndex:-1];
    [self changeKeyBoard:nil];
    return [super becomeFirstResponder];
}

-(BOOL)resignFirstResponder{
    self.textView.inputView = nil;
    [self.textView setHidden:NO];
    [self turnButtonOnAtIndex:-1];
    [self.textView resignFirstResponder];
    return [super resignFirstResponder];
}

-(void)turnButtonOnAtIndex:(NSInteger)idx{
    [self.voiceBut setSelected:(idx == 0) ? !self.voiceBut.isSelected : NO];
    [self.emojiBut setSelected:(idx == 1) ? !self.emojiBut.isSelected : NO];
    [self.moreBut setSelected:(idx == 2) ? !self.moreBut.isSelected : NO];
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
