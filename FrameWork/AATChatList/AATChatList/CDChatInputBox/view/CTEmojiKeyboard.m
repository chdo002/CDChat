//
//  CTEmojiKeyboard.m
//  CDChatList
//
//  Created by chdo on 2017/12/15.
//

#import "CTEmojiKeyboard.h"
#import <AATUtility/AATUtility.h>
#import "CTinputHelper.h"

@interface CTEmojiKeyboard()<UIScrollViewDelegate>
{
    
    UIButton *sendButton;
    
    NSMutableArray <UIView *> *containers; // 包含 scrollview pageView
    NSMutableArray <UIScrollView*> *scrollViews;
    NSMutableArray <UIPageControl*> *pageCtrs;
    
    NSMutableArray <UIButton *> *tabButtons; // 切换按钮
    
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
    
    self.backgroundColor = [UIColor cyanColor];
    
    emojInsetTop = 16.0f;  // 顶部内边距
    emojiSize = CGSizeMake(40, 40); // 表情按钮大小
    emojInsetLeft_Right = (ScreenW() - emojiSize.width * 8) * 0.5; // 左右距离
    emojiLineSpace = 5.0f; // 表情行间距
    emojInsetBottom = 10.0f; // scrollview 底部内边距
    
    pageViewH = 20; //
    bottomBarAeraH = 44;

    // scrollview大小
    CGSize scrollViewSize = CGSizeMake(ScreenW(), emojInsetTop + emojiSize.height * 3 + emojiLineSpace * 2 + emojInsetBottom + pageViewH);

    // 底部键盘大小
    self.frame = CGRectMake(0, 0, ScreenW(), scrollViewSize.height + bottomBarAeraH);
    
    
    // 发送按钮
    sendButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width -100, self.height - bottomBarAeraH, 100, bottomBarAeraH)];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self addSubview:sendButton];
    
    
    // 表情名数组 @[ @[@"[微笑]",@"[呵呵]"],   @[@"[:微笑:",@":呵呵:"] ]
    NSArray<NSArray *> *arrs = [CTinputHelper emojiNameArr] ? [CTinputHelper emojiNameArr] : @[[CTinputHelper defaultEmoticonDic].allKeys] ;
    
    containers = [NSMutableArray arrayWithCapacity:arrs.count];
    scrollViews = [NSMutableArray arrayWithCapacity:arrs.count];
    pageCtrs = [NSMutableArray arrayWithCapacity:arrs.count];
    tabButtons = [NSMutableArray arrayWithCapacity:arrs.count];
    
    
    
    
    for (int i = 0; i < arrs.count; i++) {
        
        // 每个scroll的container
        UIView *conain = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - bottomBarAeraH)];
        
        UIScrollView *scrol = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height)];
        scrol.backgroundColor = CRMHexColor(0xF5F5F7);
        scrol.delegate = self;
        scrol.pagingEnabled = YES;
        scrol.alwaysBounceHorizontal = YES;
        scrol.tag = i;
        [conain addSubview:scrol];
        
        // 表情按钮页数
        NSUInteger emojiPages = (arrs[i].count % 23 != 0 ? 1 : 0) + arrs[i].count / 23;
        scrol.contentSize = CGSizeMake(scrollViewSize.width * emojiPages, 0);
        
        NSArray <NSString *>*empjiNames = arrs[i];
        
        for (int j = 0; i < empjiNames.count; i++) {
            
        }
        
        UIPageControl *control = [[UIPageControl alloc] initWithFrame:CGRectMake(0, scrol.height, self.width, pageViewH)];
        [conain addSubview:control];
        
        [containers addObject:conain];
        [scrollViews addObject:scrol];
        [pageCtrs addObject:control];
        
    }
    
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
}

+(CTEmojiKeyboard *)keyBoard{
    
    [[CTEmojiKeyboard share] updateKeyBoard];
    return [CTEmojiKeyboard share];
}

-(void)updateKeyBoard{
    
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
}

@end
