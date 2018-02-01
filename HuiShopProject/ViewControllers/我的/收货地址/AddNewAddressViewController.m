//
//  ConsigneeAddressViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/12/18.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "AddNewAddressViewController.h"
#import "TitleTextInputCell.h"
#import "SelectSexCell.h"
#import "TitleTipCell.h"
#import "MapViewController.h"
#import "FreeViewCell.h"
@interface AddNewAddressViewController (){
	TitleTextInputItem *inputItem1;
	SelectSexItem * sexItem;
	TitleTextInputItem *inputItem2;
	TitleTextInputItem *inputItem3;
	TitleTipItem *addItem;
	TitleTextInputItem *inputItem4;
}
@end

@implementation AddNewAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	WS(bself);
	self.navBar.title = @"新增地址";
	self.view.backgroundColor = [UIColor whiteColor];
	self.formManager[@"TitleTextInputItem"] = @"TitleTextInputCell";
	self.formManager[@"SelectSexItem"] = @"SelectSexCell";
	self.formManager[@"TitleTipItem"] = @"TitleTipCell";
	self.formManager[@"FreeViewItem"] = @"FreeViewCell";
	[self initForm];
}
-(void)initForm{
	WS(bself);
	RETableViewSection *section0 = [RETableViewSection section];
	
	FMEmptyItem *itemEm = [[FMEmptyItem alloc]initWithHeight:15];
	[section0 addItem:itemEm];
	
	inputItem1 = [[TitleTextInputItem alloc]init];
	inputItem1.titleText = @"联系人";
	inputItem1.placeholder = @"你的姓名";
	[section0 addItem:inputItem1];
	
	sexItem = [[SelectSexItem alloc]init];
	[section0 addItem:sexItem];
	
	inputItem2 = [[TitleTextInputItem alloc]init];
	inputItem2.titleText = @"联系电话";
	inputItem2.placeholder = @"你的手机号";
	inputItem2.maxLenth = 11;
	inputItem2.keyboardType = UIKeyboardTypeNumberPad;
	[section0 addItem:inputItem2];
	
	inputItem3 = [[TitleTextInputItem alloc]init];
	inputItem3.titleText = @"";
	inputItem3.placeholder = @"备用电话";
	[section0 addItem:inputItem3];
	
	addItem = [[TitleTipItem alloc]init];
	addItem.t1 = @"收货地址";
	addItem.t2 = @"学校/小区/街道等";
	addItem.selectionHandler = ^(TitleTipItem* item) {
		MapViewController *vc = [[MapViewController alloc]init];
		vc.selectAddress = ^(BMKPoiInfo *info) {
			item.t2 = [NSString stringWithFormat:@"%@%@%@",info.city,info.address,info.name];
			item.info = info;
			[item reloadRowWithAnimation:UITableViewRowAnimationNone];
		};
		RootNavPush(vc);
	};
	[section0 addItem:addItem];
	
	inputItem4 = [[TitleTextInputItem alloc]init];
	inputItem4.titleText = @"";
	inputItem4.placeholder = @"详细地址";
	[section0 addItem:inputItem4];
	
	FMEmptyItem *itemEm1 = [[FMEmptyItem alloc]initWithHeight:25];
	[section0 addItem:itemEm1];
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn setTitle:@"确定" forState:UIControlStateNormal];
	btn.backgroundColor = COLOR_RED_;
	[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
	[self.view endEditing:YES];
	WS(bself);
	if (ISEmptyStr(inputItem1.value)) {
		Toast(@"请输入联系人姓名");
		return;
	}
	
	if (inputItem2.value.length < 11) {
		Toast(@"请输入你的联系电话");
		return;
	}
	
	if (ISEmptyStr(addItem.t2) || [addItem.t2 isEqualToString:@"学校/小区/街道等"]) {
		Toast(@"请选择地址");
		return;
	}
	if (ISEmptyStr(inputItem4.value)) {
		Toast(@"请填写详细地址");
		return;
	}
	[self showLoading];
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:StrRelay(inputItem1.value) forKey:@"name"];
	[param setObject:[NSString stringWithFormat:@"%d",sexItem.selIndex] forKey:@"sex"];
	[param setObject:StrRelay(addItem.info.postcode) forKey:@"areaId"];
	[param setObject:StrRelay(addItem.info.postcode) forKey:@"cityId"];
	[param setObject:StrRelay(addItem.info.postcode) forKey:@"provinceId"];
	[param setObject:StrRelay(inputItem2.value) forKey:@"tel"];
	[param setObject:StrRelay(inputItem3.value) forKey:@"spareTel"];
	[param setObject:StrRelay(addItem.info.postcode) forKey:@"postCode"];
	[param setObject:StrRelay(addItem.t2) forKey:@"addressInfo"];
	[param setObject:StrRelay(inputItem4.value) forKey:@"detailAddr"];
	[param setObject:[NSString stringWithFormat:@"%d",self.isDefalt] forKey:@"isDefault"];
	[param setObject:[NSString stringWithFormat:@"%f",addItem.info.pt.latitude] forKey:@"lbslat"];
	[param setObject:[NSString stringWithFormat:@"%f",addItem.info.pt.longitude] forKey:@"lbslng"];
	[NSObject postDataWithHost:Server_Host Path:Api_buyer_address_add Param:param isCache:NO success:^(id json) {
		[bself hiddenLoading];
		if (IntRelay(json[@"state"]) == 1) {
			if (self.saveSuccess) {
				self.saveSuccess();
			}
			RootNavPop(YES);
		}
		Toast(json[@"msg"]);
	} fail:^(id json) {
		[bself hiddenLoading];
		Toast(@"网络错误");
	}];
}
@end
