//
//  OrdersViewController.h
//  HuiShopProject
//
//  Created by cx-fu on 2017/11/23.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "FMFormViewController.h"
#import "FMActMenu.h"
#import "FMScrollContentView.h"
@interface OrdersViewController : FMFormViewController
@property (nonatomic,assign) int curIndex;
@property (nonatomic,strong) FMActMenu *mMenuHriZontal;
@property (nonatomic,strong) FMScrollContentView *mScrollPageView;
@end
