//
//  DaySignViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/11/23.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "DaySignViewController.h"
#import "SignHeadCell.h"
#import "SignWeekDayCell.h"
#import "MyJinBiCell.h"
#import "TitleTip2Cell.h"
#import "ChoujiangCell.h"
#import "ATLLotteryController.h"
#import "AlreadySignHeadCell.h"
#import "CoinDetaiViewController.h"
@interface DaySignViewController (){
	NSDictionary *initDict;
}

@end

@implementation DaySignViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.title = @"每日签到";
	self.formManager[@"SignHeadItem"] = @"SignHeadCell";
	self.formManager[@"SignWeekDayItem"] = @"SignWeekDayCell";
	self.formManager[@"MyJinBiItem"] = @"MyJinBiCell";
	self.formManager[@"TitleTip2Item"] = @"TitleTip2Cell";
	self.formManager[@"ChoujiangItem"] = @"ChoujiangCell";
	self.formManager[@"AlreadySignHeadItem"] = @"AlreadySignHeadCell";
	[self getData];
}

-(void)getData{
	WS(bself);
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_signin_init Param:nil isCache:NO success:^(id json) {
		initDict = [NSDictionary dictionaryWithDictionary:json[@"obj"]];
		[bself initForm];
	} fail:^(id json) {
		Toast(@"网络错误");
		[self initEmptyForm:self.formTable.height andType:2];
	}];
}

-(void)initForm{
	WS(bself);
	RETableViewSection *section0 = [RETableViewSection section];
	
	BOOL isSign = [StrRelay(initDict[@"isSigin"]) boolValue];
	if(isSign){
		AlreadySignHeadItem *head = [[AlreadySignHeadItem alloc]init];
		head.userinfo = initDict;
		[section0 addItem:head];
	}else{
		SignHeadItem *head = [[SignHeadItem alloc]init];
		head.btnClick = ^(NSInteger tag) {
			if (tag == 100) {
				[bself sign];
			}
		};
		[section0 addItem:head];
	}
	
	
	SignWeekDayItem *weekd = [[SignWeekDayItem alloc]init];
	weekd.userinfo = initDict[@"settings"];
	weekd.isSign = isSign;
	[section0 addItem:weekd];
	
	MyJinBiItem *jinBi = [[MyJinBiItem alloc]init];
	jinBi.jinbi = StrRelay(initDict[@"leftCoins"]) ;
	jinBi.selectionHandler = ^(MyJinBiItem* item) {
		CoinDetaiViewController *vc = [[CoinDetaiViewController alloc]init];
		vc.jinbi = item.jinbi;
		RootNavPush(vc);
	};
	[section0 addItem:jinBi];
	
	
	TitleTip2Item *t11 = [[TitleTip2Item alloc]init];
	t11.cellHeight = 40;
	t11.t1 = @"金币抽奖";
	t11.t1Color = COLOR_999;
	t11.t1Font = Font_Size_13;
	[section0 addItem:t11];
	
	ChoujiangItem *chou = [[ChoujiangItem alloc]init];
	chou.selectionHandler = ^(id item) {
		ATLLotteryController *vc = [[ATLLotteryController alloc]init];
		RootNavPush(vc);
	};
	[section0 addItem:chou];
	
	
	[self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
	[self.formTable reloadData];
	
}

-(void)sign{
	WS(bself);
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:StrRelay([BaiduMapService sharedInstance].currentAddress) forKey:@"signinAddress"];
	[param setObject:[NSString stringWithFormat:@"%f",[BaiduMapService sharedInstance].lon] forKey:@"lbslng"];
	[param setObject:[NSString stringWithFormat:@"%f",[BaiduMapService sharedInstance].lat] forKey:@"lbslat"];
	[param setObject:StrRelay(initDict[@"currId"]) forKey:@"currId"];
	
	[NSObject postDataWithHost:Server_Host Path:Api_buyer_signin_signin Param:param isCache:NO success:^(id json) {
		initDict = [NSDictionary dictionaryWithDictionary:json[@"obj"]];
		[bself initForm];
	} fail:^(id json) {
		Toast(@"网络错误");
		[bself initEmptyForm:bself.formTable.height andType:2];
	}];
}
@end
