//
//  JAScrollView.h
//  AutomobileAccessories
//
//  Created by JA on 2017/3/17.
//  Copyright © 2017年  All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^ImageViewClick)(NSInteger index);
@interface WJScrollView : UIView
@property (nonatomic,assign)BOOL isRunloop;//是否开启定时器 default NO
@property (nonatomic,assign)NSTimeInterval dur; //default 3
@property (nonatomic,strong)UIColor *color_pageControl;
@property (nonatomic,strong)UIColor *color_currentPageControl;
@property (nonatomic,strong)ImageViewClick click;
@property (nonatomic,copy)void (^pageScrolled)(NSInteger index); ;
- (instancetype)initWithFrame:(CGRect)frame
                   withImages:(NSArray *)images
                withIsRunloop:(BOOL)isRunloop
                    withBlock:(ImageViewClick)block;

@end
