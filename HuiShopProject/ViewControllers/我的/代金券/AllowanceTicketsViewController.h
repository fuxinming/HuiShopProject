//
//  AllowanceTicketsViewController.h
//  HuiShopProject
//
//  Created by cx-fu on 2017/12/18.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "FMFormViewController.h"
#import "FMActMenu.h"
#import "FMScrollContentView.h"
@interface AllowanceTicketsViewController : FMFormViewController
@property (nonatomic,assign) int curIndex;
@property (nonatomic,strong) FMActMenu *mMenuHriZontal;
@property (nonatomic,strong) FMScrollContentView *mScrollPageView;

@property (nonatomic, strong) NSMutableArray *myArr1;
@property (nonatomic, strong) NSMutableArray *myArr2;
@property (nonatomic, strong) NSMutableArray *myArr3;
@end
