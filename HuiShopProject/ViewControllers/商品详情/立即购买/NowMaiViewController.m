//
//  NowMaiViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/12/21.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "NowMaiViewController.h"
#import "NowOrderAddressCell.h"
#import "TitleTipCell.h"
#import "NowOrderProductCell.h"
#import "TitleTextInputCell.h"
#import "WSNoficationTipCell.h"
#import "PayTypeViewController.h"
#import "ConsigneeAddressViewController.h"
#import "PopBottomView1.h"
#import "VouchersContentView.h"
@interface NowMaiViewController (){
	TitleTextInputItem *itemInput;
	int jianshu;
	double price;
	double peisongFee;
	UIView *bottomView;
	NowOrderAddressItem *item1;//地址
	NSDictionary *vocherInfo;
}
@property (nonatomic, strong)PopBottomView1 *popView;
@end

@implementation NowMaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.navBar.title = @"确认订单";
	self.formManager[@"NowOrderAddressItem"] = @"NowOrderAddressCell";
	self.formManager[@"NowOrderProductItem"] = @"NowOrderProductCell";
	self.formManager[@"TitleTextInputItem"] = @"TitleTextInputCell";
	self.formManager[@"TitleTipItem"] = @"TitleTipCell";
	self.formManager[@"WSNoficationTipItem"] = @"WSNoficationTipCell";
	self.formTable.frame = CGRectMake(0, NavigationBarH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarH - TabBarH);
	if (self.isFormCart) {
		[self initForm];
	}else{
		[self getData];
	}
	
}

-(void)getData{
	WS(bself);
	[self showLoading];
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:self.type forKey:@"type"];
	[param setObject:self.productId forKey:@"id"];
	[NSObject postDataWithHost:Server_Host Path:Api_buyer_good_buying Param:param isCache:NO success:^(id json) {
		[bself hiddenLoading];
		if (IntRelay(json[@"state"]) == 1) {
			bself.orderInfoDict = [NSMutableDictionary dictionaryWithDictionary:json[@"obj"]];
			[bself initForm];
		}else{
			[bself initEmptyForm:bself.formTable.height andType:2];
		}
	} fail:^(id json) {
		[bself hiddenLoading];
		[bself initEmptyForm:bself.formTable.height andType:2];
	}];
}
-(void)initForm{
	WS(bself);
	jianshu = 0;
	price  = 0.0f;
	peisongFee  = 0.0f;
	RETableViewSection *section0 = [RETableViewSection section];
	NSArray *arr1 = self.orderInfoDict[@"appAddress"];
	NSDictionary *dict;
	
	for (int i = 0; i < arr1.count; i++) {
		NSDictionary *temDict = [arr1 objectAtIndex:i];
		if (IntRelay(temDict[@"isDefault"]) == 1) {
			dict = temDict;
			break;
		}
	}
	if (!dict && arr1.count >0) {
		dict = arr1[0];
	}
	
	item1 = [[NowOrderAddressItem alloc]init];
	item1.userinfo = dict;
	item1.selectionHandler = ^(NowOrderAddressItem * item) {
		ConsigneeAddressViewController *vc = [[ConsigneeAddressViewController alloc]init];
		vc.saveSuc = ^(id info) {
			NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:bself.orderInfoDict];
			[dict setObject:info forKey:@"appAddress"];
			bself.orderInfoDict = dict;
			item.userinfo = info;
			[item reloadRowWithAnimation:UITableViewRowAnimationNone];
			
		};
		RootNavPush(vc);
	};
	[section0 addItem:item1];
	
	[section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
	
	NSArray *arr2 = self.orderInfoDict[@"marketCartGoodsList"];
	if (arr2.count > 0) {
		NSDictionary *dict = arr2[0];
		
		TitleTipItem *item12 = [[TitleTipItem alloc]init];
		item12.t1 = dict[@"marketName"];
		item12.leftImage = @"marckrt";
		item12.haveLine = NO;
		item12.haveArrow = NO;
		[section0 addItem:item12];
		
		
		NSArray *arr3 = dict[@"appCartGoodsList"];
		for (int i = 0; i < arr3.count; i++) {
			NSDictionary *temDict = [arr3 objectAtIndex:i];
			NowOrderProductItem *itemP = [[NowOrderProductItem alloc]init];
			itemP.userinfo = temDict;
			[section0 addItem:itemP];
			
			jianshu+= IntRelay(temDict[@"qty"]);
			price += DoubleRelay(temDict[@"retailPrice"]) * IntRelay(temDict[@"qty"]) ;
		}
		NSArray *arr4 = dict[@"appVouchers"];
		if (arr4.count > 0) {
			TitleTipItem *item21 = [[TitleTipItem alloc]init];
			item21.t1 = @"优惠券";
			if (vocherInfo) {
				item21.t2 = [NSString stringWithFormat:@"满%@减%@",StrRelay(vocherInfo[@"amountLimit"]),StrRelay(vocherInfo[@"amount"])];
			}
			item21.userinfo = arr4;
			item21.selectionHandler = ^(TitleTipItem * item) {
				[bself popVoucherView:item];
			};
			[section0 addItem:item21];
		}
		
		peisongFee = DoubleRelay(dict[@"dispatchFee"]);
		if(price >=DoubleRelay(dict[@"freeDispatchLimit"])){
			peisongFee = 0;
		}
		TitleTipItem *item13 = [[TitleTipItem alloc]init];
		item13.t1 = @"配送方式";
		item13.t2 = [NSString stringWithFormat:@"配送费:￥%.2f元",peisongFee];
		item13.haveArrow = NO;
		[section0 addItem:item13];
		
		TitleTipItem *item131 = [[TitleTipItem alloc]init];
		item131.t1 = @"发票类型：超市小票";
		item131.haveArrow = NO;
		[section0 addItem:item131];
		
		NSString *strr1 = [NSString stringWithFormat:@"共%d件商品   合计:%.2f元",jianshu,price+peisongFee];
		if (DoubleRelay(vocherInfo[@"amount"]) > 0) {
			strr1 = [NSString stringWithFormat:@"共%d件商品   合计:%.2f元",jianshu,price+peisongFee - DoubleRelay(vocherInfo[@"amount"])];
		}
		TitleTipItem *item14 = [[TitleTipItem alloc]init];
		item14.t2 = strr1;
		item14.haveArrow = NO;
		[section0 addItem:item14];
		
		FMEmptyItem *itemEm = [[FMEmptyItem alloc]initWithHeight:45];
		[section0 addItem:itemEm];
		
		itemInput = [[TitleTextInputItem alloc]init];
		itemInput.titleText = @"买家留言：";
		itemInput.placeholder = @"选填，可填写你和卖家达成一致的想法";
		
		[section0 addItem:itemInput];
		
		WSNoficationTipItem *itemsw = [[WSNoficationTipItem alloc]init];
		itemsw.titleText = @"匿名购买";
		itemsw.isOn = YES;
		[section0 addItem:itemsw];
		
		[self initBottomView];
	}
	
	
	
	[self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
	[self.formTable reloadData];
	
}


-(void)initBottomView{
	if (bottomView) {
		[bottomView removeFromSuperview];
		bottomView = nil;
	}
	bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT - TabBarH, SCREEN_WIDTH, TabBarH)];
	bottomView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:bottomView];
	
	UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 0.5)];
	lineView.backgroundColor = COLOR_ddd;
	[bottomView addSubview:lineView];
	
	NSMutableAttributedString *str1 = [CommonUtil mutableStringAppendString:[NSString stringWithFormat:@"共%d件 合计：",jianshu].color(COLOR_333).font(Font_Size_13)];
	str1.append([NSString stringWithFormat:@"￥%.2f  ",price+peisongFee- DoubleRelay(vocherInfo[@"amount"])].color(COLOR_RED_).font(Font_Size_13));
	
	UILabel *label = [[UILabel alloc] init];
	label.textAlignment = NSTextAlignmentRight;
	label.attributedText = str1;
	label.font = Font_Size_14;
	label.frame = CGRectMake(0, 0, SCREEN_WIDTH - 110, TabBarH);
	[bottomView addSubview:label];
	
	UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn4 setTitle:@"提交订单" forState:UIControlStateNormal];
	[btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[btn4.titleLabel setFont:Font_Size_13];
	btn4.backgroundColor = COLOR_RED_;
	btn4.tag = 103;
	btn4.frame = CGRectMake(SCREEN_WIDTH - 110, 0, 110, TabBarH);
	[btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	[bottomView addSubview:btn4];
}

-(void)btnClick:(UIButton *)btn{
	WS(bself);
	if (!self.isFormCart) {
		[self showLoading];
		NSArray *arr2 = self.orderInfoDict[@"marketCartGoodsList"];
		NSArray *arr3 = @[];
		if (arr2.count > 0) {
			arr3 = arr2[0][@"appCartGoodsList"];
		}
		
		NSMutableDictionary *param = [AppUtil getPublicParam];
		[param setObject:StrRelay(item1.userinfo[@"id"])  forKey:@"deliveryInfoId"];
		[param setObject:@"2" forKey:@"orderOrigin"];
		if(arr3.count > 0){
			NSDictionary *temDict = [arr3 objectAtIndex:0];
			[param setObject:StrRelay(temDict[@"type"]) forKey:@"type"];
			[param setObject:StrRelay(temDict[@"goodsId"]) forKey:@"goodsId"];
		}
		[param setObject:StrRelay(vocherInfo[@"id"]) forKey:@"voucherId"];
		[param setObject:StrRelay(itemInput.value) forKey:@"message"];
		[NSObject postDataWithHost:Server_Host Path:Api_buyer_order_buying Param:param isCache:NO success:^(id json) {
			[bself hiddenLoading];
			if (IntRelay(json[@"state"]) == 1) {
				if(json[@"obj"]&&[json[@"obj"] isKindOfClass:[NSArray class]]){
					NSArray *arr1 = json[@"obj"];
					if (arr1.count > 0) {
						NSDictionary *dict = [arr1 objectAtIndex:0];
						PayTypeViewController *vc = [[PayTypeViewController alloc]init];
						vc.userinfo = dict;
						RootNavPush(vc);
					}
				}
			}else{
				Toast(@"订单创建失败");
			}
		} fail:^(id json) {
			[bself hiddenLoading];
			Toast(@"网络错误");
		}];
	}else{
		[self showLoading];
		NSArray *arr2 = self.orderInfoDict[@"marketCartGoodsList"];
		NSArray *arr3 = @[];
		if (arr2.count > 0) {
			arr3 = arr2[0][@"appCartGoodsList"];
		}
		
		NSMutableDictionary *param = [AppUtil getPublicParam];
		[param setObject:StrRelay(item1.userinfo[@"id"])  forKey:@"deliveryInfoId"];
		[param setObject:@"2" forKey:@"orderOrigin"];
		NSMutableArray *ids = [NSMutableArray array];
		if(arr3.count > 0){
			for (int i = 0; i < arr3.count; i ++) {
				NSDictionary *temDict = [arr3 objectAtIndex:i];
				[ids addObject:StrRelay(temDict[@"id"])];
			}
		}
		[param setObject:ids forKey:@"cartGoodsIds"];
		[param setObject:@{@"id":StrRelay(vocherInfo[@"id"])} forKey:@"voucher"];
		[param setObject:StrRelay(itemInput.value) forKey:@"message"];
		
		NSString *param1 = [NSString jsonStringWithDictionary:param];
		[NSObject postDataWithHost:Server_Host Path:Api_buyer_order_add Param:param1 success:^(id json) {
			[bself hiddenLoading];
			if (IntRelay(json[@"state"]) == 1) {
				if(json[@"obj"]&&[json[@"obj"] isKindOfClass:[NSArray class]]){
					NSArray *arr1 = json[@"obj"];
					if (arr1.count > 0) {
						NSDictionary *dict = [arr1 objectAtIndex:0];
						PayTypeViewController *vc = [[PayTypeViewController alloc]init];
						vc.userinfo = dict;
						RootNavPush(vc);
					}
				}
			}else{
				Toast(@"订单创建失败");
			}
		} fail:^(id json) {
			[bself hiddenLoading];
			Toast(@"网络错误");
		}];
	}
	
}

-(void)popVoucherView:(TitleTipItem *)item{
	WS(bself);
	VouchersContentView *aview = [[VouchersContentView alloc]initWithFrame:CGRectMake(0, SCREEN_HEIGHT/2, SCREEN_WIDTH, SCREEN_HEIGHT/2) withUserInfo:item.userinfo andDealtSel:vocherInfo andLimit:price];
	aview.btnSelect = ^(id info) {
		vocherInfo = info;
		[bself initForm];
		[_popView remove];
	};
	_popView = [[PopBottomView1 alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	[_popView showContentView:aview];
}

@end
