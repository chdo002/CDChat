//
//  CTEmojiKeyboard.m
//  CDChatList
//
//  Created by chdo on 2017/12/15.
//

#import "CTEmojiKeyboard.h"
#import "AATUtility.h"
#import "CTinputHelper.h"



@interface EmojiCollectionView: UICollectionView<UICollectionViewDataSource>

@end

@implementation EmojiCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self) {
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 2.0f;
        layout.minimumInteritemSpacing = 2.0f;
        layout.itemSize = CGSizeMake(48, 48);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        self = [super initWithFrame:frame collectionViewLayout:layout];
        self.alwaysBounceHorizontal = YES;
        self.dataSource = self;
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    return self;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 23;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.contentView.backgroundColor = [UIColor lightGrayColor];
    return cell;
}


@end




@interface EmojiBut: UIButton

@end

@implementation EmojiBut
-(CGRect)imageRectForContentRect:(CGRect)contentRect{
    CGRect oldrect = [super imageRectForContentRect:contentRect];
    if (ScreenW() > 375) {
        return CGRectInset(oldrect, -5, -5);
    } else {
        return CGRectInset(oldrect, -2, -2);
    }
}
@end

@interface CTEmojiKeyboard()<UIScrollViewDelegate>
{
    
    UIButton *sendButton;
    
    NSMutableArray <UIView *> *containers; // 包含 scrollview pageView
    NSMutableArray <UIScrollView*> *scrollViews; // 表情scrollview
    NSMutableArray <UIPageControl*> *pageCtrs; // segment
    NSMutableArray <UIButton*> *tabButtons; // 切换按钮
    
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
    
    self.backgroundColor = [UIColor whiteColor];
    
    emojInsetTop = 12.0f;  // 顶部内边距
    if (ScreenW() > 375) {
        emojiSize = CGSizeMake(48, 48); // 表情按钮大小
    } else {
        emojiSize = CGSizeMake(42, 42); // 表情按钮大小
    }
    emojInsetLeft_Right = (ScreenW() - emojiSize.width * 8) * 0.5; // 左右距离
    emojiLineSpace = 5.0f; // 表情行间距
    emojInsetBottom = 5.0f; // scrollview 底部内边距
    
    pageViewH = 20; //
    bottomBarAeraH = 44;

    // scrollview大小
    CGSize scrollViewSize = CGSizeMake(ScreenW(), emojInsetTop + emojiSize.height * 3 + emojiLineSpace * 2 + emojInsetBottom);

    // 底部键盘大小
    self.frame = CGRectMake(0, 0, ScreenW(), scrollViewSize.height + pageViewH + bottomBarAeraH);
    
    
    // 发送按钮
    sendButton = [[UIButton alloc] initWithFrame:CGRectMake(self.width -100, self.height - bottomBarAeraH, 100, bottomBarAeraH)];
    [sendButton setTitle:@"发送" forState:UIControlStateNormal];
    [self addSubview:sendButton];
    
    
    // 表情名数组 @[ @[@"[微笑]",@"[呵呵]"],   @[@"[:微笑:",@":呵呵:"] ]
    NSArray<NSArray<NSString *> *> *arrs = [CTinputHelper emojiNameArr] ? [CTinputHelper emojiNameArr] : @[[CTinputHelper defaultEmoticonDic].allKeys] ;
    
    containers = [NSMutableArray arrayWithCapacity:arrs.count];
    scrollViews = [NSMutableArray arrayWithCapacity:arrs.count];
    pageCtrs = [NSMutableArray arrayWithCapacity:arrs.count];
    tabButtons = [NSMutableArray arrayWithCapacity:arrs.count];
    
    
    NSDictionary<NSString *,UIImage *> *emojiDic = [CTinputHelper defaultEmoticonDic];
    UIImage *emojiDelete = [CTinputHelper defaultImageDic][@"emojiDelete"];

    for (int i = 0; i < arrs.count; i++) {
        
        // 每个scroll的container
        UIView *conain = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height - bottomBarAeraH)];
        conain.tag = i;
        [self addSubview:conain];
        UIScrollView *scrol = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, scrollViewSize.width, scrollViewSize.height)];
        scrol.backgroundColor = CRMHexColor(0xF5F5F7);
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
        for (NSUInteger j = 0; j < empjiNames.count; j++) {
            NSInteger currentPage = j / 23;
            
            NSUInteger currentRow = j % 23 / 8;
            NSUInteger currentColumn = j % 23 % 8;
            
            CGFloat x = emojInsetLeft_Right + currentColumn * emojiSize.width + currentPage * scrollViewSize.width;
            CGFloat y = emojInsetTop + currentRow * (emojiSize.height + emojiLineSpace) ;
            
            EmojiBut *but = [[EmojiBut alloc] initWithFrame:CGRectMake(x, y, emojiSize.width, emojiSize.height)];
            [but setImage:emojiDic[empjiNames[j]] forState:UIControlStateNormal];
            but.imageView.size = CGSizeMake(40, 40);
            if (j % 22 == 0 || j == empjiNames.count - 1) {
                UIButton *delete = [[UIButton alloc] initWithFrame:CGRectMake(emojInsetLeft_Right + emojiSize.width * 7 + currentPage * scrollViewSize.width,
                                                                              emojInsetTop + emojiLineSpace * 2 + emojiSize.height * 2,
                                                                              emojiSize.width,
                                                                              emojiSize.height)];
                [delete setImage:emojiDelete forState:UIControlStateNormal];
                [scrol addSubview:delete];
            }
            [scrol addSubview:but];
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
        [tabBut setTitle:arrs[i].firstObject forState:UIControlStateNormal];
        [tabBut addTarget:self action:@selector(containSelectsss:) forControlEvents:UIControlEventTouchUpInside];
        [tabBut setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [tabBut setBackgroundColor:[UIColor blueColor]];
        [self addSubview:tabBut];
        [tabButtons addObject:tabBut];
        
        
        [containers addObject:conain];
        [scrollViews addObject:scrol];
        [pageCtrs addObject:control];
        
    }
    
}

-(UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    UIView *vv = [super hitTest:point withEvent:event];
    return vv;
}

-(BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event{
    BOOL bol = [super pointInside:point withEvent:event];
    return bol;
}
-(void)containSelectsss:(UIButton *)but{
    for (UIView *conain in containers) {
        BOOL res = conain.tag != but.tag;
        [conain setHidden:res];
    }
    
    for (UIButton *conain in tabButtons) {
        BOOL res = conain.tag == but.tag;
        if (res) {
            conain.backgroundColor = [UIColor redColor];
        } else {
            conain.backgroundColor = [UIColor lightGrayColor];
        }
    }
}

- (void) scrollViewDidScroll: (UIScrollView *) aScrollView
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
    
}



-(void)layoutSubviews{
    [super layoutSubviews];
    
}

@end
