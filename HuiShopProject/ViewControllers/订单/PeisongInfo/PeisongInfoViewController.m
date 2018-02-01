//
//  PeisongInfoViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2018/1/5.
//  Copyright © 2018年 付新明. All rights reserved.
//

#import "PeisongInfoViewController.h"
#import "PeisongHeadCell.h"
#import "PeisongRowInfoCell.h"

@interface PeisongInfoViewController ()
@property (nonatomic, strong) NSMutableDictionary *mydict;
@end

@implementation PeisongInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.title = @"配送信息";
	self.formManager[@"PeisongHeadItem"] = @"PeisongHeadCell";
	self.formManager[@"PeisongRowInfoItem"] = @"PeisongRowInfoCell";
	[self getData];
}
-(void) getData{
	WS(bself);
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:StrRelay(self.userinfo[@"id"]) forKey:@"id"];
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_order_viewdispatch Param:param isCache:NO success:^(id json) {
		if(IntRelay(json[@"state"]) == 1){
			
			bself.mydict = [NSMutableDictionary dictionaryWithDictionary:json[@"obj"]];
		}
		
		[bself initForm];
	} fail:^(id json) {
		[bself initEmptyForm:self.formTable.height andType:2];
	}];
}

-(void)initForm{
	WS(bself);
	RETableViewSection *section0 = [RETableViewSection section];

	
	PeisongHeadItem *hItem1 = [[PeisongHeadItem alloc]init];
	hItem1.t1 = @"订单编号：";
	hItem1.t1Font = Font_Size_13;
	hItem1.t1Color = COLOR_999;
	hItem1.t2 = StrRelay(self.mydict[@"id"]);
	hItem1.t2Font = Font_Size_13;
	hItem1.t2Color = COLOR_BLUE_;
	[section0 addItem:hItem1];
	
	PeisongHeadItem *hItem2 = [[PeisongHeadItem alloc]init];
	hItem2.t1 = @"配送时间：";
	hItem2.t1Font = Font_Size_13;
	hItem2.t1Color = COLOR_999;
	hItem2.t2 = StrRelay(self.mydict[@"stDispatchTime"]);
	hItem2.t2Font = Font_Size_13;
	hItem2.t2Color = COLOR_333;
	[section0 addItem:hItem2];
	
	
	FMEmptyItem *em = [[FMEmptyItem alloc]initWithHeight:20];
	[section0 addItem:em];
	
	if(IntRelay(self.mydict[@"orderState"]) == 6){
		
	}
	
	PeisongRowInfoItem *item01 = [[PeisongRowInfoItem alloc]init];
	item01.t1 = @"您的宝贝正朝您飞奔而来，请注意查收";
	item01.t2 = StrRelay(self.mydict[@"stDispatchTime"]);
	if(IntRelay(self.mydict[@"orderState"]) == 4){
		item01.isLast = YES;
	}
	[section0 addItem:item01];
	
	PeisongRowInfoItem *item02 = [[PeisongRowInfoItem alloc]init];
	item02.t1 = @"商家已接单，正在为您准备商品，打印商票";
	item02.t2 = StrRelay(self.mydict[@"stReceiveTime"]);
	[section0 addItem:item02];
	
	
	PeisongRowInfoItem *item03 = [[PeisongRowInfoItem alloc]init];
	item03.t1 = @"您提交了订单，等待系统确认";
	item03.t2 = StrRelay(self.mydict[@"stOrderTime"]);
	[section0 addItem:item03];
	
	[self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
	[self.formTable reloadData];
	
}
@end
