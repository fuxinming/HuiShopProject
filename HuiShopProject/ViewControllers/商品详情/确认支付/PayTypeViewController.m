//
//  PayTypeViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/12/26.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "PayTypeViewController.h"
#import "TitleTipCell.h"
#import "PayTypeCell.h"
#import "OneButtonCell.h"
#import "WXApi+XWAdd.h"

#import <AlipaySDK/AlipaySDK.h>
#import "AlipaySDK+XWAdd.h"
#import "OrdersViewController.h"
#import "OrderDetailViewController.h"
@interface PayTypeViewController (){
	PayTypeItem *payItem;
	NSMutableDictionary *wxDict;
}

@end

@implementation PayTypeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.title = @"确认支付";
	self.formManager[@"TitleTipItem"] = @"TitleTipCell";
	self.formManager[@"PayTypeItem"] = @"PayTypeCell";
	self.formManager[@"OneButtonItem"] = @"OneButtonCell";
	[self initForm];
}

-(void)initForm{
	WS(bself);
	RETableViewSection *section0 = [RETableViewSection section];
	
	NSMutableAttributedString *str1 = [CommonUtil mutableStringAppendString:[NSString stringWithFormat:@"￥%.2f  ",DoubleRelay(self.userinfo[@"payFee"])].color(COLOR_RED_).font(Font_Size_13)];
	
	TitleTipItem *item01 = [[TitleTipItem alloc]init];
	item01.t1 = @"订单金额";
	item01.attriStr = str1;
	item01.haveArrow = NO;
	[section0 addItem:item01];
	
	payItem = [[PayTypeItem alloc]init];
	[section0 addItem:payItem];
	
	[section0 addItem:[[FMEmptyItem alloc]initWithHeight:30 ]];
	
	
	OneButtonItem *btn = [[OneButtonItem alloc]init];
	btn.titleText = @"立即支付";
	btn.bgColor = COLOR_RED_;
	btn.btnPress = ^{
		[bself nextStep];
	};
	[section0 addItem:btn];
	
	[self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
	[self.formTable reloadData];
	
}

-(void)nextStep{
	WS(bself);
	if(payItem.payType == 1){
		NSMutableDictionary *param = [AppUtil getPublicParam];
		[self showLoading];
		[param setObject:StrRelay(self.userinfo[@"id"]) forKey:@"id"];
		[NSObject postDataWithHost:Server_Host Path:Api_buyer_order_alipay Param:param isCache:NO success:^(id json) {
			[bself hiddenLoading];
			if (IntRelay(json[@"state"]) == 1) {
				[bself goPayOfZhifubao:StrRelay(json[@"obj"])];
			}
		} fail:^(id json) {
			[bself hiddenLoading];
			Toast(@"网络错误");
		}];
	
	}else{
		NSMutableDictionary *param = [AppUtil getPublicParam];
		[self showLoading];
		[param setObject:StrRelay(self.userinfo[@"id"]) forKey:@"id"];
		[NSObject postDataWithHost:Server_Host Path:Api_buyer_order_wechatpay Param:param isCache:NO success:^(id json) {
			[bself hiddenLoading];
			if (IntRelay(json[@"state"]) == 1) {
			if(json[@"obj"]&&[json[@"obj"] isKindOfClass:[NSDictionary class]]){
				wxDict = [NSMutableDictionary dictionaryWithDictionary:json[@"obj"]];
				}
				if (wxDict) {
					[bself goPayOfWeixin:wxDict tradeNo:StrRelay(self.userinfo[@"id"])];
				}
			}
		} fail:^(id json) {
			[bself hiddenLoading];
			Toast(@"网络错误");
			
		}];
	}

}

- (void)goPayOfWeixin:(id)dic tradeNo:(NSString *)tradeNo {
	WS(bself);
	if (![[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"weixin://"]]) {
		[AppUtil showAlert:@"提示" msg:@"你的机器未安装微信客户端,确认下载?" handle:^(BOOL cancelled, NSInteger buttonIndex) {
			if (buttonIndex==1) {
				[AppUtil openUrl:@"https://itunes.apple.com/cn/app/wechat/id836500024?mt=12"];
			}
		}];
		return;
	}
	//发起微信支付（客户端签名版本）
	[WXApi xwAdd_senPayRequsetWithAppID:[CommonUtil strRelay:dic[@"appid"]] partnerId:[CommonUtil strRelay:dic[@"partnerid"]] prepayId:[CommonUtil strRelay:dic[@"prepayid"]] nonceStr:[CommonUtil strRelay:dic[@"noncestr"]] timeStamp:[CommonUtil strRelay:dic[@"timestamp"]] package:[CommonUtil strRelay:dic[@"package"]] sign:[CommonUtil strRelay:dic[@"sign"]] callbackConfig:^(BOOL successed) {
		if (successed) {
			NSMutableArray *ar = [[NSMutableArray alloc] init];
			for (int i = 0; i < [self.navigationController.viewControllers count]; i++) {
				id ttt = [self.navigationController.viewControllers objectAtIndex:i];
				[ar addObject:ttt];
				if ([ttt isKindOfClass:[NSClassFromString(@"ProductDetailViewController") class]]) {
					break;
				}
			}
			OrdersViewController *vc = [[OrdersViewController alloc]init];
			vc.curIndex = 2;
			[ar addObject:vc];
			
			OrderDetailViewController *vc1 = [[OrderDetailViewController alloc]init];
			vc1.userinfo = self.userinfo;
			[ar addObject:vc1];
			
			[self.navigationController setViewControllers:ar animated:YES];
		}
		else {
			
			Toast(@"支付失败");
			
			[bself popToViewController:@"ProductDetailViewController"];
		}
	}];
}

- (void)goPayOfZhifubao:(NSString *)orderString {
	WS(bself);
	[AlipaySDK xwAdd_sendPayWithOrderInfo:orderString appScheme:Alipay_Scheme callbackConfig:^(BOOL successed) {
		if (successed) {
			NSMutableArray *ar = [[NSMutableArray alloc] init];
			for (int i = 0; i < [self.navigationController.viewControllers count]; i++) {
				id ttt = [self.navigationController.viewControllers objectAtIndex:i];
				[ar addObject:ttt];
				if ([ttt isKindOfClass:[NSClassFromString(@"ProductDetailViewController") class]]) {
					break;
				}
			}
			OrdersViewController *vc = [[OrdersViewController alloc]init];
			vc.curIndex = 2;
			[ar addObject:vc];
			
			OrderDetailViewController *vc1 = [[OrderDetailViewController alloc]init];
			vc1.userinfo = self.userinfo;
			[ar addObject:vc1];
			
			[self.navigationController setViewControllers:ar animated:YES];
		}
		else {
			Toast(@"支付失败");
			
			[bself popToViewController:@"ProductDetailViewController"];
		}
	}];
}

-(void)vcPop{
	[[NSNotificationCenter defaultCenter] postNotificationName:RefreshTable object:nil];
	NSMutableArray *ar = [[NSMutableArray alloc] init];
	for (int i = 0; i < [self.navigationController.viewControllers count]; i++) {
		id ttt = [self.navigationController.viewControllers objectAtIndex:i];
		[ar addObject:ttt];
		if ([ttt isKindOfClass:[NSClassFromString(@"ProductDetailViewController") class]]) {
			break;
		}
	}
	OrdersViewController *vc = [[OrdersViewController alloc]init];
	vc.curIndex = 1;
	[ar addObject:vc];
	
	OrderDetailViewController *vc1 = [[OrderDetailViewController alloc]init];
	vc1.userinfo = self.userinfo;
	[ar addObject:vc1];
	
	[self.navigationController setViewControllers:ar animated:YES];
}
@end
