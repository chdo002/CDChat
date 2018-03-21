//
//  CTEmojiKeyboard.m
//  CDChatList
//
//  Created by chdo on 2017/12/15.
//

#import "CTEmojiKeyboard.h"
#import "UITool.h"
#import "CTinputHelper.h"


@interface EmojiBut: UIButton

@end

@implementation EmojiBut
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect oldrect = [super imageRectForContentRect:contentRect];
        return CGRectInset(oldrect, -ScreenW() * 0.005, -ScreenW() * 0.005);
}
@end

@interface CTEmojiKeyboard()<UIScrollViewDelegate>
{
    
    UIButton *sendButton;
    
    NSMutableArray <NSMutableArray <UIButton*> *> *emojiButs; // 表情按钮

    
    NSMutableArray <UIView *> *containers; // 包含 scrollview pageView
    NSMutableArray <UIScrollView*> *scrollViews; // 表情scrollview
    NSMutableArray <UIPageControl*> *pageCtrs; // segment
    NSMutableArray <UIButton*> *tabButtons; // 切换按钮
    
    // 表情名数组 @[ @[@"[微笑]",@"[呵呵]"],   @[@"[:微笑:",@":呵呵:"] ]
    NSArray<NSArray<NSString *> *> *arrs;
    NSDictionary<NSString *,UIImage *> *emojiDic;
    CGFloat emojInsetTop; // scrollview对应位置内边距
    CGFloat emojInsetLeft_Right; // scrollview对应位置内边距
    CGFloat emojInsetBottom;       // scrollview对应位置内边距
    CGFloat emojiLineSpace; // 表情按钮行间距
    CGSize emojiSize;  // 表情按钮体积
    CGFloat pageViewH;  // segment高度
    CGFloat bottomBarAeraH; // 底部选择栏的高度
    
}
@end
@implementation CTEmojiKeyboard

+(instancetype)share{
    
    static dispatch_once_t onceToken;
    static CTEmojiKeyboard *single;
    
    dispatch_once(&onceToken, ^{
        single = [[CTEmojiKeyboard alloc] init];
        [single initUI];
    });
    return single;
}

-(void)initUI{
    
    // 表情名数组 @[ @[@"[微笑]",@"[呵呵]"],   @[@"[:微笑:",@":呵呵:"] ]
    arrs = [CTinputHelper emojiNameArr] ? [CTinputHelper emojiNameArr] : @[[CTinputHelper defaultEmoticonDic].allKeys] ;
    
    if (arrs.count != 1) {
        self.backgroundColor = [UIColor whiteColor];
        bottomBarAeraH = 44;
    } else {
        self.backgroundColor = [UIColor whiteColor];;
        bottomBarAeraH = 44;
    }
    
    emojInsetTop = 12.0f;  // 顶部内边距
    emojiSize = CGSizeMake(ScreenW() * 0.112, ScreenW() * 0.112);
    emojInsetLeft_Right = (ScreenW() - emojiSize.width * 8) * 0.5; // 左右距离
    emojiLineSpace = 5.0f; // 表情行间距
    emojInsetBottom = 5.0f; // scrollview 底部内边距
    
    pageViewH = 20; //
    

    // scrollview大小
    CGSize scrollViewSize = CGSizeMake(ScreenW(), emojInsetTop + emojiSize.height * 3 + emojiLineSpace * 2 + emojInsetBottom);

    // 底部键盘大小
    self.frame = CGRectMake(0, 0, ScreenW(), scrollViewSize.height + pageViewH + bottomBarAeraH);
    
    
    containers = [NSMutableArray arrayWithCapacity:arrs.count];
    scrollViews = [NSMutableArray arrayWithCapacity:arrs.count];
    pageCtrs = [NSMutableArray arrayWithCapacity:arrs.count];
    tabButtons = [NSMutableArray arrayWithCapacity:arrs.count];
    
    emojiDic = [CTinputHelper defaultEmoticonDic];
    UIImage *emojiDelete = [CTinputHelper defaultImageDic][@"emojiDelete"];

    emojiButs = [NSMutableArray array];
    
    for (int i = 0; i < arrs.count; i++){
        // 每个scroll的container
        UIView *conain = [[UIView alloc] initWithFrame:CGRectMake(0, 1, self.width, self.height - bottomBarAeraH -1)];
        conain.tag = i;
        [self addSubview:conain];
        UIScrollView *scrol = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height)];
        scrol.backgroundColor = CRMHexColor(0xF5F5F7);
        scrol.showsHorizontalScrollIndicator = NO;
        scrol.delegate = self;
        scrol.pagingEnabled = YES;
        scrol.alwaysBounceHorizontal = YES;
        scrol.tag = i;
        [conain addSubview:scrol];
        
        // 表情页数
        NSUInteger emojiPages = (arrs[i].count % 23 != 0 ? 1 : 0) + arrs[i].count / 23;
        
        // 设置scrollview contentsize
        scrol.contentSize = CGSizeMake(scrollViewSize.width * emojiPages, 0);
        
        NSArray <NSString *>*empjiNames = arrs[i];
        // 添加每一页的表情
        NSMutableArray *arr = [NSMutableArray array];
        [emojiButs addObject: arr];
        for (NSUInteger j = 0; j < empjiNames.count; j++) {
            NSInteger currentPage = j / 23;
            
            NSUInteger currentRow = j % 23 / 8;
            NSUInteger currentColumn = j % 23 % 8;
            
            CGFloat x = emojInsetLeft_Right + currentColumn * emojiSize.width + currentPage * scrollViewSize.width;
            CGFloat y = emojInsetTop + currentRow * (emojiSize.height + emojiLineSpace) ;
            
            EmojiBut *but = [[EmojiBut alloc] initWithFrame:CGRectMake(x, y, emojiSize.width, emojiSize.height)];
            [but setImage:emojiDic[empjiNames[j]] forState:UIControlStateNormal];
            but.tag = i * 1000 + j;
            [but addTarget:self action:@selector(emojiButtonTabed:) forControlEvents:UIControlEventTouchUpInside];
            but.imageView.size = CGSizeMake(40, 40);
            if (j % 22 == 0 || j == empjiNames.count - 1) {
                UIButton *delete = [[UIButton alloc] initWithFrame:CGRectMake(emojInsetLeft_Right + emojiSize.width * 7 + currentPage * scrollViewSize.width,
                                                                              emojInsetTop + emojiLineSpace * 2 + emojiSize.height * 2,
                                                                              emojiSize.width,
                                                                              emojiSize.height)];
                [delete setImage:emojiDelete forState:UIControlStateNormal];
                [delete addTarget:self action:@selector(emojiButtonTabedDelete) forControlEvents:UIControlEventTouchUpInside];
                [scrol addSubview:delete];
            }
            if (currentPage == 0 && i == 0) {
                [scrol addSubview:but];
            }
            [arr addObject:but];
        }
        // pagecontroll
        UIPageControl *control = [[UIPageControl alloc] initWithFrame:CGRectMake(0, scrol.height, self.width, pageViewH)];
        control.backgroundColor = CRMHexColor(0xF5F5F7);
        control.numberOfPages = emojiPages;
        control.pageIndicatorTintColor = [UIColor lightGrayColor];
        control.currentPageIndicatorTintColor = [UIColor blackColor];
        [conain addSubview:control];
        
        // 选择按钮
        UIButton *tabBut = [[UIButton alloc] initWithFrame:CGRectMake(60 * i, conain.height, 60, bottomBarAeraH)];
        tabBut.tag = i;
        
        [tabBut setTitle:[CTinputHelper emojiNameArrTitles][i] forState:UIControlStateNormal];
        [tabBut addTarget:self action:@selector(containSelectsss:) forControlEvents:UIControlEventTouchUpInside];
        [tabBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if (i == 0) {
            [tabBut setBackgroundColor:CRMHexColor(0xF5F5F7)];
        } else {
            [tabBut setBackgroundColor:[UIColor whiteColor]];
        }
        [self addSubview:tabBut];
        [tabButtons addObject:tabBut];
        
        
        [containers addObject:conain];
        [scrollViews addObject:scrol];
        [pageCtrs addObject:control];
    }
    
    for (UIView *con in containers) {
        if (con.tag == 0) {
            [con setHidden:NO];
        } else {
            [con setHidden:YES];
        }
    }
    
    // 发送按钮
    sendButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width -100, self.height - 44, 100, 44)];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [sendButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sendButton addTarget:self action:@selector(emojiButtonTabedSend) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:sendButton];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self bringSubviewToFront:self->sendButton];
    });
    
    
    CALayer *lineLayer = [CALayer layer];
    lineLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds), 1);
    lineLayer.backgroundColor = CRMHexColor(0xD7D7D9).CGColor;
    [self.layer insertSublayer:lineLayer atIndex:0];
}

-(void)didMoveToSuperview {
    dispatch_async(dispatch_get_main_queue(), ^{
        for (int i = 0; i < self->emojiButs.count; i++) {
            UIScrollView *scrol = self->scrollViews[i];
            for (UIButton *b in self->emojiButs[i]) {
                if (!b.superview) {
                    [scrol addSubview:b];
                }
            }
        }
    });
}

-(void)containSelectsss:(UIButton *)but{
    for (UIView *conain in containers) {
        BOOL res = conain.tag != but.tag;
        [conain setHidden:res];
    }
    
    for (UIButton *conain in tabButtons) {
        BOOL res = conain.tag == but.tag;
        if (res) {
            conain.backgroundColor = CRMHexColor(0xF5F5F7);
        } else {
            conain.backgroundColor = [UIColor whiteColor];
        }
    }
}

- (void)scrollViewDidScroll: (UIScrollView *) aScrollView
{
    CGPoint offset = aScrollView.contentOffset;
    NSUInteger idx =  offset.x / aScrollView.frame.size.width;
    pageCtrs[aScrollView.tag].currentPage = idx;
}

+(CTEmojiKeyboard *)keyBoard{
    
    [[CTEmojiKeyboard share] updateKeyBoard];
    return [CTEmojiKeyboard share];
}

-(void)updateKeyBoard{
    for (UIButton *but in tabButtons) {
        if (but.tag == 0) {
            but.backgroundColor = CRMHexColor(0xF5F5F7);
        } else {
            but.backgroundColor = [UIColor whiteColor];
        }
    }
    
    [self bringSubviewToFront:containers.firstObject];
    
    for (UIScrollView *scrol in scrollViews) {
        [scrol setContentOffset:CGPointMake(0, 0)];
    }
}

-(void)emojiButtonTabed:(UIButton *)but{
    NSUInteger buttag =  but.tag;
    NSUInteger arrIdx = buttag * 0.001;
    NSUInteger imagIdx = buttag % 1000;
    NSString *name = arrs[arrIdx][imagIdx];
    UIImage *img = emojiDic[name];
    [self.emojiDelegate emojiKeyboardSelectKey:name image:img];
}

-(void)emojiButtonTabedDelete{
    [self.emojiDelegate emojiKeyboardSelectDelete];
}

-(void)emojiButtonTabedSend{
    [self.emojiDelegate emojiKeyboardSelectSend];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
}

@end
