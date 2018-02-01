//
//  WSTabBar.h
//  SunnyCar
//
//  Created by jienliang on 16/10/20.
//  Copyright © 2016年 jienliang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "CategoryViewController.h"
#import "CartViewController.h"
#import "MineViewController.h"
@interface TabarItem : UIButton

@end


@interface FMTabBar : UITabBarController
@property (nonatomic,strong) UIView *tabBarView;
@property (nonatomic,strong) MainViewController *main;
@property (nonatomic,strong) CategoryViewController *cat;
@property (nonatomic,strong) CartViewController *cart;
@property (nonatomic,strong) MineViewController *mine;

@property (nonatomic,assign) int cIndex;
- (void)selectedTab:(UIButton *)button;
- (void)setTabIndex:(int)idx;
- (id)init;
@end
