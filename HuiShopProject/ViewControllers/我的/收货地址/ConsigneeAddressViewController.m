//
//  ConsigneeAddressViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/12/18.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "ConsigneeAddressViewController.h"
#import "AddressInfoCell.h"
#import "AddNewAddressViewController.h"
#import "EditAddressViewController.h"
@interface ConsigneeAddressViewController ()
@property (nonatomic, strong) NSMutableArray *myArr1;
@end

@implementation ConsigneeAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	WS(bself);
	self.navBar.title = @"收货地址";
	self.navBar.rightItemList = [NSArray arrayWithObject:[FMBarItem itemWith:@"添加" withClick:^(id it) {
		[bself fbtnClick];
	}]];
	self.formManager[@"AddressInfoItem"] = @"AddressInfoCell";
	[self getdata];
}

-(void)getdata{
	WS(bself);
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_address_list Param:nil isCache:NO success:^(id json) {
		if(IntRelay(json[@"state"]) == 1){
			if(json[@"obj"] && [json[@"obj"] isKindOfClass:[NSArray class]]){
				bself.myArr1 = [NSMutableArray arrayWithArray:json[@"obj"]];
			}
			
		}
		
		[bself initForm];
	} fail:^(id json) {
		[bself initForm];
	}];
}
-(void)initForm{
	WS(bself);
	RETableViewSection *section0 = [RETableViewSection section];
	
	if (bself.myArr1 &&bself.myArr1.count > 0) {
		for (int i = 0; i < self.myArr1.count; i++) {
			NSDictionary *dict = [bself.myArr1 objectAtIndex:i];
			AddressInfoItem *item1 = [[AddressInfoItem alloc]init];
			item1.userinfo = dict;
			item1.btnClick = ^(NSInteger tag,AddressInfoItem *item) {
				if (tag == 101) {
					[bself setDefaltAddrees:item];
				}
					
				if (tag == 102) {
					EditAddressViewController *vc = [[EditAddressViewController alloc]init];
					vc.userinfo = item.userinfo;
					vc.isDefalt = IntRelay(item.userinfo[@"isDefault"]);
					vc.saveSuccess = ^{
						[bself getdata];
					};
					RootNavPush(vc);
				}
				if(tag == 103){
					[AppUtil showAlert:@"提示" msg:@"确定要删除这条地址吗" handle:^(BOOL cancelled, NSInteger buttonIndex) {
						if (buttonIndex == 1) {
							[bself delAddrees:item];
						}
					}];
				}
			};
			item1.selectionHandler = ^(AddressInfoItem * item) {
				
				if (bself.saveSuc) {
					bself.saveSuc(item.userinfo);
				}
				RootNavPop(YES);
			};
			[section0 addItem:item1];
		}
	}
	
	FMEmptyItem *itemEm1 = [[FMEmptyItem alloc]initWithHeight:25];
	[section0 addItem:itemEm1];
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn setTitle:@"添加新地址" forState:UIControlStateNormal];
	[btn setTitleColor:COLOR_RED_ forState:UIControlStateNormal];
	[btn.titleLabel setFont:Font_Size_14];
	btn.tag = 100;
	btn.frame = CGRectMake((SCREEN_WIDTH - 150)/2, 0, 150, 40);
	[btn addTarget:self action:@selector(fbtnClick) forControlEvents:UIControlEventTouchUpInside];
	View_Border_Radius(btn, 4, 1, COLOR_RED_);
	FreeViewItem *itemF = [[FreeViewItem alloc]init];
	itemF.cellHeight = 40;
	itemF.freeView = btn;
	[section0 addItem:itemF];
	
	
	[self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
	[self.formTable reloadData];
}
-(void)fbtnClick{
	WS(bself);
	AddNewAddressViewController *vc = [[AddNewAddressViewController alloc]init];
	vc.saveSuccess = ^{
		[bself getdata];
	};
	RootNavPush(vc);
	
}
-(void)setDefaltAddrees:(AddressInfoItem *)item{
	WS(bself);
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:StrRelay(item.userinfo[@"id"]) forKey:@"id"];
	[NSObject postDataWithHost:Server_Host Path:Api_buyer_address_setdefault Param:param isCache:NO success:^(id json) {
		if (IntRelay(json[@"state"]) == 1) {
			[bself getdata];
		}
		Toast(json[@"msg"]);
	} fail:^(id json) {
		Toast(@"网络错误");
	}];
}
-(void)delAddrees:(AddressInfoItem *)item{
	WS(bself);
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:StrRelay(item.userinfo[@"id"]) forKey:@"id"];
	[NSObject postDataWithHost:Server_Host Path:Api_buyer_address_del Param:param isCache:NO success:^(id json) {
		if (IntRelay(json[@"state"]) == 1) {
			[bself getdata];
		}
		Toast(json[@"msg"]);
	} fail:^(id json) {
		Toast(@"网络错误");
	}];
}
@end
