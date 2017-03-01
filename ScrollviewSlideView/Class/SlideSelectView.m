//
//  SlideSelectView.m
//  ScrollviewSlideView
//
//  Created by lx on 17/3/1.
//  Copyright © 2017年 lx. All rights reserved.
//

#import "SlideSelectView.h"

@interface SlideSelectView ()

@property (strong, nonatomic) NSMutableArray *listArray;

@property (strong, nonatomic) UIScrollView *scrollviewbg;

@property (strong, nonatomic) UIView *lineView;


@property (assign, nonatomic) CGFloat subViewWidth;

@property (strong, nonatomic) UIColor *titleColor;

@property (strong, nonatomic) UIColor *selectTitleColor;


@property (strong, nonatomic) NSMutableArray *listbtnsArray;


@end

@implementation SlideSelectView

-(NSMutableArray *)listbtnsArray{
    if (_listbtnsArray == nil) {
        _listbtnsArray = [NSMutableArray array];
    }
    return _listbtnsArray;
}

-(instancetype)initFrame:(CGRect)frame dic:(NSDictionary *)dic{
    self = [super initWithFrame:frame];
    if (self) {
        self.listArray = [NSMutableArray arrayWithArray:[dic valueForKey:@"listArray"]];
        self.subViewWidth = [[dic valueForKey:@"subViewWidth"] floatValue];
        self.titleColor = [dic valueForKey:@"titleColor"];
        self.selectTitleColor = [dic valueForKey:@"selectTitleColor"];
        [self setuplistScrollview];
    }
    return self;
}


- (void)setuplistScrollview{
    UIScrollView *scrollviewbg = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
    scrollviewbg.showsHorizontalScrollIndicator = NO;
    scrollviewbg.bounces = YES;
    self.scrollviewbg = scrollviewbg;
    self.scrollviewbg.backgroundColor = [UIColor whiteColor];
    [self addSubview:scrollviewbg];
    
    CGFloat btnX = 0;
    for (int i= 0; i<self.listArray.count; i++) {
        CGFloat btn_width = [self getWidthFromNssrting:self.listArray[i] size:self.bounds.size] +20;
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(btnX, 0, btn_width, self.bounds.size.height)];
       btnX += btn_width;
        if (i == 0) {
            btn.selected = YES;
        }
        [btn setTitle:self.listArray[i] forState:UIControlStateNormal];
        [btn setTitleColor:_titleColor forState:UIControlStateNormal];
        [btn setTitleColor:_selectTitleColor forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(selectsubviewbtn:) forControlEvents:UIControlEventTouchUpInside];
        [scrollviewbg addSubview:btn];
        [self.listbtnsArray addObject:btn];
    }
    scrollviewbg.contentSize = CGSizeMake(btnX, 0);

    
    CGFloat line_width = [self getWidthFromNssrting:self.listArray[0] size:self.bounds.size];
    UIView *lineview = [[UIView alloc] initWithFrame:CGRectMake(0, self.bounds.size.height - 2, line_width, 2)];
    lineview.backgroundColor = _selectTitleColor;
    CGPoint center = CGPointMake((line_width+20)/2, self.bounds.size.height - 2);
    lineview.center = center;
    _lineView = lineview;
    [scrollviewbg addSubview:lineview];
    
//    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    btn.frame = CGRectMake(CGRectGetMaxX(scrollviewbg.frame), 0, self.bounds.size.height, self.bounds.size.height);
//    btn.backgroundColor = [UIColor grayColor];
//    [btn addTarget:self action:@selector(btnAddListArray) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:btn];
}

//- (void)btnAddListArray{
//    [self.listArray addObject:@"西藏"];
//    [_scrollviewbg removeFromSuperview];
//    [self setuplistScrollview];
//}

- (void)selectsubviewbtn:(UIButton *)sender{
    for (NSInteger i=0; i<self.listbtnsArray.count;i++) {
        UIButton *btn = (UIButton *)self.listbtnsArray[i];
        if (btn == sender) {
            self.selectIndex = i;
            self.subviewBlock(i);
        }
    }
}


// 计算文本的长度
- (CGFloat)getWidthFromNssrting:(NSString *)string size:(CGSize)size{
    CGFloat line_width =  [string boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size.width +8;
    return line_width;
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    for (NSInteger i=0; i<self.listbtnsArray.count;i++) {
        UIButton *btn = (UIButton *)self.listbtnsArray[i];
        if (selectIndex == i) {
            btn.selected = YES;
            [self anmationSubviewBtnSelectIndex:btn index:selectIndex];
        }else{
            btn.selected = NO;
        }
    }
}
-(void)anmationSubviewBtnSelectIndex:(UIButton *)btn index:(NSInteger)index{
    [UIView animateWithDuration:0.3 animations:^{
        CGPoint center = CGPointMake(btn.center.x, self.bounds.size.height - 2);
        CGRect frame_line = CGRectMake(0, self.bounds.size.height - 2, [self getWidthFromNssrting:btn.titleLabel.text size:btn.frame.size], 2);
        self.lineView.frame = frame_line;
        _lineView.center= center;
        if (index>=2 && index<=self.listArray.count-1 -2) {
            UIButton *btnScroll = (UIButton *)_listbtnsArray[index - 2];
            _scrollviewbg.contentOffset = CGPointMake(btnScroll.frame.origin.x, 0);
        }
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
