//
//  OrdersViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/11/23.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "OrdersViewController.h"
#import "OrderContentView.h"
#import "OrderDetailViewController.h"
@interface OrdersViewController (){
    NSArray *actArray;
}

@end

@implementation OrdersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.title = @"全部订单";
    actArray = [[NSArray alloc] initWithObjects:@"全部",@"待付款",@"待发货",@"待收货",@"待评价",@"已退款",@"已投诉",nil];
    [self tabActSetting];
    [self CreateContentScrollView];
}


- (void)tabActSetting
{
    WS(bself);
    NSMutableArray *itemsArray = [NSMutableArray array];
    for (int i = 0; i < [actArray count]; i++) {
        float w = 80;
        if (actArray.count<6) {
            w = SCREEN_WIDTH/[actArray count];
        }
        NSDictionary *dic = @{TITLEKEY:actArray[i],
                              TITLEWIDTH:[NSNumber numberWithFloat:w]
                              };
        [itemsArray addObject:dic];
    }
    if (_mMenuHriZontal == nil) {
        _mMenuHriZontal = [[FMActMenu alloc] initWithFrame:CGRectMake(0, NavigationBarH, SCREEN_WIDTH, 40) ButtonItems:itemsArray titleColor:UIColorFromRGB(0xff584d) defaultIndex:self.curIndex];
        _mMenuHriZontal.onClick = ^(id item,int index){
            [bself.mScrollPageView moveScrollowViewAthIndex:index];
        };
        [self.view addSubview:_mMenuHriZontal];
    }
}

- (void)CreateContentScrollView
{
    WS(bself);
    //初始化滑动列表
    float height = SCREEN_HEIGHT-NavigationBarH - 40  - 0.5;
    if (_mScrollPageView == nil) {
        _mScrollPageView = [[FMScrollContentView alloc] initWithFrame:CGRectMake(0, NavigationBarH + 40 + 0.5, SCREEN_WIDTH, height)];
    }
    _mScrollPageView.createViewAtIndex = ^(int i){
	
        OrderContentView *dView1 = [[OrderContentView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, height) withType:i];
		dView1.payOk = ^(id info) {
			[[NSNotificationCenter defaultCenter] postNotificationName:RefreshTable object:nil];
			bself.curIndex = 2;
			[bself.mScrollPageView setScrollowViewAthIndex:bself.curIndex];
			NSMutableArray *ar = [NSMutableArray arrayWithArray:bself.navigationController.viewControllers];
			
			OrderDetailViewController *vc1 = [[OrderDetailViewController alloc]init];
			vc1.userinfo = info;
			[ar addObject:vc1];
			
			[bself.navigationController setViewControllers:ar animated:YES];
		};
        dView1.tag = 10086+i;
        return dView1;
    };
    _mScrollPageView.scrollPageView = ^(int page){
        [bself.mMenuHriZontal changeButtonStateAtIndex:page];
    };
    [_mScrollPageView setContentOfTables:actArray.count];
    [self.view addSubview:_mScrollPageView];
    
    [bself.mScrollPageView setScrollowViewAthIndex:self.curIndex];
}
@end
