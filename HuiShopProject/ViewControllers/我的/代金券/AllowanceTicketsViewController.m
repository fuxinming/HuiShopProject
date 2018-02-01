//
//  AllowanceTicketsViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/12/18.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "AllowanceTicketsViewController.h"
#import "TicketContentView.h"
@interface AllowanceTicketsViewController (){
	NSArray *actArray;
}

@end

@implementation AllowanceTicketsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navBar.title = @"代金券";
	actArray = [[NSArray alloc] initWithObjects:@"未使用",@"已使用",@"已过期",nil];
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
		TicketContentView *dView1 = [[TicketContentView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, height)];
		dView1.tag = 10086+i;
		if (i == 0) {
			dView1.myArr1 = bself.myArr1;
		}
		if (i == 1) {
			dView1.myArr1 = bself.myArr2;
		}
		if (i == 2) {
			dView1.myArr1 = bself.myArr3;
		}
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
