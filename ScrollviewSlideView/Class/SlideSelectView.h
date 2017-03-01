//
//  SlideSelectView.h
//  ScrollviewSlideView
//
//  Created by lx on 17/3/1.
//  Copyright © 2017年 lx. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface SlideSelectView : UIView

-(instancetype)initFrame:(CGRect)frame dic:(NSDictionary *)dic;

@property (copy, nonatomic) void(^subviewBlock)(NSInteger index);

@property (assign, nonatomic) NSInteger selectIndex;

@end
