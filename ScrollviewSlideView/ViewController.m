//
//  ViewController.m
//  ScrollviewSlideView
//
//  Created by lx on 17/3/1.
//  Copyright © 2017年 lx. All rights reserved.
//

#import "ViewController.h"
#import "SlideSelectView.h"

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic) NSArray *listArray;

@property (strong, nonatomic) SlideSelectView *slideScrollview;

@property (strong, nonatomic) UICollectionView *collectview;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    _listArray = [NSArray arrayWithObjects:@"写真",@"旅游",@"欧式",@"法式",@"海滩在外",@"写真",@"法式",@"海滩在外",@"写真", nil];
    self.view.backgroundColor = [UIColor blueColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self setupTopScrollview];
    [self setupCollectionview];
    
    
}
- (void)setupTopScrollview{
    
    
    NSString *subViewWidthstr = @"80";
    UIColor *titleColor = [UIColor blackColor];
    UIColor *selectTitleColor = [UIColor redColor];
    
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.listArray,@"listArray",subViewWidthstr,@"subViewWidth",titleColor,@"titleColor",selectTitleColor,@"selectTitleColor", nil];
    
    CGRect frame = CGRectMake(0, 64, self.view.bounds.size.width, 50);
    
    SlideSelectView *slideScrollview = [[SlideSelectView alloc] initFrame:frame dic:dic] ;
    _slideScrollview = slideScrollview;
    slideScrollview.subviewBlock = ^(NSInteger index){
            NSLog(@"%ld",(long)index);
        _collectview.contentOffset = CGPointMake(self.view.bounds.size.width*index, 0);
    };
    [self.view addSubview:slideScrollview];
    
}
- (void)setupCollectionview{

    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(_slideScrollview.frame));
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    NSLog(@"%f",CGRectGetMaxY(_slideScrollview.frame));
    UICollectionView *collectview = [[UICollectionView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_slideScrollview.frame), self.view.bounds.size.width, self.view.bounds.size.height - CGRectGetMaxY(_slideScrollview.frame) ) collectionViewLayout:layout];
    _collectview = collectview;
    collectview.delegate = self;
    collectview.dataSource = self;
    collectview.pagingEnabled = YES;
    collectview.showsHorizontalScrollIndicator = NO;
    [collectview  registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self.view addSubview:collectview];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.listArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    if (indexPath.row%2 == 0) {
        cell.backgroundColor = [UIColor redColor];
    }else if (indexPath.row%3 == 0){
        cell.backgroundColor = [UIColor purpleColor];
    }else{
        cell.backgroundColor = [UIColor greenColor];
    }
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == _collectview) {
        CGFloat collectViewX = scrollView.contentOffset.x;
        _slideScrollview.selectIndex = collectViewX/self.view.bounds.size.width;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
