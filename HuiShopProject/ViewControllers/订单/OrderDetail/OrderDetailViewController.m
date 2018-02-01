//
//  OrderDetailViewController.m
//  HuiShopProject
//
//  Created by 付新明 on 2017/12/26.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "OrderDetailViewController.h"
#import "OrderDetailHeadCell.h"
#import "OrderAddressInfoCell.h"
#import "TitleTipCell.h"
#import "TitleTip2Cell.h"
#import "OrderDetailProductCell.h"
#import "FreeViewCell.h"
#import "ShowPicsCell.h"
@interface OrderDetailViewController (){
	UIButton *btn;
	BOOL isHaveComplain;
}
@property (nonatomic, strong) NSMutableDictionary *mydict;
@property (nonatomic, strong) NSMutableDictionary *complaindict;
@end

@implementation OrderDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
  	self.navBar.title = @"订单详细";
	self.formManager[@"OrderDetailHeadItem"] = @"OrderDetailHeadCell";
	self.formManager[@"OrderAddressInfoItem"] = @"OrderAddressInfoCell";
	self.formManager[@"TitleTipItem"] = @"TitleTipCell";
	self.formManager[@"TitleTip2Item"] = @"TitleTip2Cell";
	self.formManager[@"OrderDetailProductItem"] = @"OrderDetailProductCell";
	self.formManager[@"FreeViewItem"] = @"FreeViewCell";
	self.formManager[@"ShowPicsItem"] = @"ShowPicsCell";
	btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn setTitle:@"取消订单" forState:UIControlStateNormal];
	[btn setTitleColor:COLOR_333 forState:UIControlStateNormal];
	[btn.titleLabel setFont:Font_Size_14];
	btn.tag = 100;
	btn.frame = CGRectMake(SCREEN_WIDTH - 85,8, 70, 24);
	[btn addTarget:self action:@selector(fbtnClick) forControlEvents:UIControlEventTouchUpInside];
	View_Border_Radius(btn, 3, 1, COLOR_999);
	[self getData];
	
	
}
- (void)getData{
	WS(bself);
	[self showLoading];
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:StrRelay(self.userinfo[@"id"]) forKey:@"id"];
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_order_view Param:param isCache:NO success:^(id json) {
		[bself hiddenLoading];
		if(IntRelay(json[@"state"]) == 1){
			
			bself.mydict = [NSMutableDictionary dictionaryWithDictionary:json[@"obj"]];
		}
		
		[bself initForm];
	} fail:^(id json) {
		[bself hiddenLoading];
		[bself initEmptyForm:self.formTable.height andType:2];
	}];
}
-(void)initForm{
    WS(bself);
    RETableViewSection *section0 = [RETableViewSection section];
    
	OrderDetailHeadItem *item1 = [[OrderDetailHeadItem alloc]init];
	item1.userinfo = self.mydict;
	[section0 addItem:item1];
	
	OrderAddressInfoItem *item2 = [[OrderAddressInfoItem alloc]init];
	item2.userinfo = self.mydict;;
	[section0 addItem:item2];
	
	
	[section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
	
	TitleTipItem *item3 = [[TitleTipItem alloc]init];
	item3.t1 = self.mydict[@"marketName"];
	item3.leftImage = @"marckrt";
	item3.haveLine = NO;
	item3.haveArrow = NO;
	[section0 addItem:item3];
	
	
	NSArray *arr3 = self.mydict[@"goodsList"];
	for (int i = 0; i < arr3.count; i++) {
		NSDictionary *temDict = [arr3 objectAtIndex:i];
		OrderDetailProductItem *itemP = [[OrderDetailProductItem alloc]init];
		itemP.userinfo = temDict;
		[section0 addItem:itemP];
	}
	
	TitleTip2Item *t11 = [[TitleTip2Item alloc]init];
	t11.cellHeight = 30;
	t11.t1 = @"商品总价：";
	t11.t1Color = COLOR_999;
	t11.t2 = [NSString stringWithFormat:@"%.1f",DoubleRelay(self.mydict[@"payFee"])];
	t11.t2Color = COLOR_999;
	t11.t1Font = Font_Size_12;
	t11.t2Font = Font_Size_12;
	[section0 addItem:t11];
	
	TitleTip2Item *t12 = [[TitleTip2Item alloc]init];
	t12.cellHeight = 30;
	t12.t1 = @"配送费：";
	t12.t1Color = COLOR_999;
	t12.t2 = [NSString stringWithFormat:@"%.1f",DoubleRelay(self.mydict[@"freight"])];
	t12.t2Color = COLOR_999;
	t12.t1Font = Font_Size_12;
	t12.t2Font = Font_Size_12;
	[section0 addItem:t12];
	
	TitleTip2Item *t13 = [[TitleTip2Item alloc]init];
	t13.cellHeight = 30;
	t13.t1 = @"订单总价：";
	t13.t1Color = COLOR_333;
	t13.t2 = [NSString stringWithFormat:@"%.1f",DoubleRelay(self.mydict[@"totalPrice"])];
	t13.t2Color = COLOR_333;
	t13.t1Font = Font_Size_14;
	t13.t2Font = Font_Size_14;
	[section0 addItem:t13];
	
	[section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
	
	TitleTip2Item *t21 = [[TitleTip2Item alloc]init];
	t21.cellHeight = 20;
	t21.t2 = @"支付明细";
	t21.t2Font = Font_Size_12;
	[section0 addItem:t21];
	
	TitleTip2Item *t22 = [[TitleTip2Item alloc]init];
	t22.cellHeight = 30;
	t22.t1 = @"优惠券";
	t22.t1Font = Font_Size_14;
	t22.t1Color = COLOR_333;
	t22.t2 = [NSString stringWithFormat:@"￥%.1f",DoubleRelay(self.mydict[@"voucherAmount"])];
	t22.t2Font = Font_Size_14;
	t22.t2Color = COLOR_333;
	[section0 addItem:t22];
	
	TitleTip2Item *t23 = [[TitleTip2Item alloc]init];
	t23.cellHeight = 30;
	t23.t1 = @"实际支付";
	t23.t1Font = Font_Size_14;
	t23.t1Color = COLOR_333;
	t23.t2 = [NSString stringWithFormat:@"￥%.1f",DoubleRelay(self.mydict[@"payFee"])];;
	t23.t2Font = Font_Size_14;
	t23.t2Color = COLOR_333;
	[section0 addItem:t23];
	
	[section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
	
	if (self.complaindict) {
		TitleTip2Item *com1 = [[TitleTip2Item alloc]init];
		com1.cellHeight = 30;
		com1.t1Font = Font_Size_14;
		com1.t1Color = COLOR_999;
		
		com1.t1 = [NSString stringWithFormat:@"投诉主题 %@",[AppUtil getNameWithStatus:IntRelay(self.complaindict[@"subject"])]];
		[section0 addItem:com1];
		
		TitleTip2Item *com2 = [[TitleTip2Item alloc]init];
		com2.cellHeight = 30;
		com2.t1Font = Font_Size_14;
		com2.t1Color = COLOR_999;
		com2.t1 = [NSString stringWithFormat:@"投诉说明 %@",StrRelay(self.complaindict[@"content"])];
		[section0 addItem:com2];
		
		ShowPicsItem *pics = [[ShowPicsItem alloc]init];
		pics.arrayPics = [NSMutableArray arrayWithArray:self.complaindict[@"urls"]];
		[section0 addItem:pics];
		
		TitleTip2Item *com3 = [[TitleTip2Item alloc]init];
		com3.cellHeight = 30;
		com3.t1Font = Font_Size_14;
		com3.t1Color = COLOR_999;
		com3.t1 = [NSString stringWithFormat:@"提交时间 %@",StrRelay(self.complaindict[@"stComplaintTime"])];
		[section0 addItem:com3];
		
		TitleTip2Item *com4 = [[TitleTip2Item alloc]init];
		com4.cellHeight = 30;
		com4.t1Font = Font_Size_14;
		com4.t1Color = COLOR_999;
		com4.t1 = [NSString stringWithFormat:@"处理结果 %@",StrRelay(self.complaindict[@"handleResult"])];
		[section0 addItem:com4];
		
		[section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
	}
	
	TitleTip2Item *t31 = [[TitleTip2Item alloc]init];
	t31.cellHeight = 25;
	t31.t1 = @"订单编号";
	t31.t1Font = Font_Size_12;
	t31.t1Color = COLOR_999;
	t31.t2 = StrRelay(self.mydict[@"id"]);
	t31.t2Font = Font_Size_12;
	t31.t2Color = COLOR_999;
	[section0 addItem:t31];
	
	TitleTip2Item *t32 = [[TitleTip2Item alloc]init];
	t32.cellHeight = 25;
	t32.t1 = @"支付单号";
	t32.t1Font = Font_Size_12;
	t32.t1Color = COLOR_999;
	t32.t2 = StrRelay(self.mydict[@"paymentId"]);
	t32.t2Font = Font_Size_12;
	t32.t2Color = COLOR_999;
	[section0 addItem:t32];
	
	TitleTip2Item *t33 = [[TitleTip2Item alloc]init];
	t33.cellHeight = 25;
	t33.t1 = @"创建时间";
	t33.t1Font = Font_Size_12;
	t33.t1Color = COLOR_999;
	t33.t2 = StrRelay(self.mydict[@"stOrderTime"]);
	t33.t2Font = Font_Size_12;
	t33.t2Color = COLOR_999;
	[section0 addItem:t33];
	
	TitleTip2Item *t34 = [[TitleTip2Item alloc]init];
	t34.cellHeight = 25;
	t34.t1 = @"付款时间";
	t34.t1Font = Font_Size_12;
	t34.t1Color = COLOR_999;
	t34.t2 = StrRelay(self.mydict[@"stPayTime"]);
	t34.t2Font = Font_Size_12;
	t34.t2Color = COLOR_999;
	[section0 addItem:t34];
	
	TitleTip2Item *t35 = [[TitleTip2Item alloc]init];
	t35.cellHeight = 25;
	t35.t1 = @"发货时间";
	t35.t1Font = Font_Size_12;
	t35.t1Color = COLOR_999;
	t35.t2 = StrRelay(self.mydict[@"stDispatchTime"]);
	t35.t2Font = Font_Size_12;
	t35.t2Color = COLOR_999;
	[section0 addItem:t35];
	
	TitleTip2Item *t36 = [[TitleTip2Item alloc]init];
	t36.cellHeight = 25;
	t36.t1 = @"成交时间";
	t36.t1Font = Font_Size_12;
	t36.t1Color = COLOR_999;
	t36.t2 = StrRelay(self.mydict[@"stReceiveTime"]);
	t36.t2Font = Font_Size_12;
	t36.t2Color = COLOR_999;
	[section0 addItem:t36];
	
	if(IntRelay(self.mydict[@"orderState"]) == 1 || IntRelay(self.mydict[@"orderState"]) == 5|| IntRelay(self.mydict[@"orderState"]) == 10|| IntRelay(self.mydict[@"orderState"]) == 11){
		if( IntRelay(self.mydict[@"orderState"]) == 5|| IntRelay(self.mydict[@"orderState"]) == 10|| IntRelay(self.mydict[@"orderState"]) == 11){
			[btn setTitle:@"删除订单" forState:UIControlStateNormal];
		}
		[section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
		
		FreeViewItem *itemF = [[FreeViewItem alloc]init];
		itemF.cellHeight = 40;
		itemF.freeView = btn;
		itemF.bgColor = [UIColor whiteColor];
		[section0 addItem:itemF];
	}
	
    [self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
    [self.formTable reloadData];
	
	if(IntRelay(self.mydict[@"orderState"]) == 11&&!isHaveComplain){
		[self getComplain];
	}
}

-(void)fbtnClick{
	WS(bself);
	[AppUtil showAlert:@"提示" msg:@"确认删除订单" handle:^(BOOL cancelled, NSInteger buttonIndex) {
		if(buttonIndex == 1){
			[bself deleteOreder];
		}
	}];
}

-(void)getComplain{
	WS(bself);
	[self showLoading];
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:StrRelay(self.userinfo[@"id"]) forKey:@"id"];
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_complaint_view Param:param isCache:NO success:^(id json) {
		
		[bself hiddenLoading];
		bself.complaindict = [NSMutableDictionary dictionaryWithDictionary:json[@"obj"]] ;
		isHaveComplain = YES;
		[bself initForm];
		
	} fail:^(id json) {
		[bself hiddenLoading];
	}];
}

-(void)deleteOreder{
	WS(bself);
	[self showLoading];
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:StrRelay(self.userinfo[@"id"]) forKey:@"id"];
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_order_del Param:param isCache:NO success:^(id json) {
		[bself hiddenLoading];
		RootNavPop(YES);
		FMBlock(self.saveSuccess);
	} fail:^(id json) {
		[bself hiddenLoading];
		Toast(@"网络错误");
	}];
}
@end
