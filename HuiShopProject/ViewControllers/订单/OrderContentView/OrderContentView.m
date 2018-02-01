//
//  CXMatchContentView.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/7.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "OrderContentView.h"
#import "OrderInfoCell.h"
#import "EmptyDataCell.h"
#import "OrderDetailViewController.h"
#import "PopBottomView.h"
#import "RestoreMenuView.h"
#import "WXApi+XWAdd.h"

#import <AlipaySDK/AlipaySDK.h>
#import "AlipaySDK+XWAdd.h"
#import "PeisongInfoViewController.h"
#import "PingJiaViewController.h"
#import "ComplaintViewController.h"
@interface OrderContentView (){
	PopBottomView *popView;
	NSMutableDictionary *wxDict;
	OrderInfoItem* tempitem;
}

@end
@implementation OrderContentView


- (id)initWithFrame:(CGRect)frame withType:(int)type {
	self = [super initWithFrame:frame];
	if (self) {
		self.type = type;
		self.formManager[@"OrderInfoItem"] = @"OrderInfoCell";
		[self requestFirstPage];
	}
	return self;
}

- (void)requestWithPage:(int)pageIndex {
	WS(bself);
	int stat = self.type;
	if (self.type == 2) {
		stat = 3;
	}
	if (self.type == 3) {
		stat = 4;
	}
	if (self.type == 4) {
		stat = 5;
	}
	if (self.type == 5) {
		stat = 10;
	}
	if (self.type == 6) {
		stat = 11;
	}
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:@"30" forKey:@"rp"];
	[param setObject:[NSNumber numberWithInt:pageIndex] forKey:@"curpage"];
	[param setObject:[NSString stringWithFormat:@"%d",stat] forKey:@"state"];
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_order_list Param:param isCache:NO success:^(id json) {
		[bself requestComplete];
		if (IntRelay(json[@"state"]) == 1) {
			NSArray *arr = json[@"obj"];
			if (arr.count == 30) {
				bself.hasNextPage = 1;
			}else{
				bself.hasNextPage = -1;
			}
			[bself requestFinish:[bself getDataArray:json]];
		}
		NSMutableArray *arr = [bself getDataArray:json];
		if (arr.count == 0 && pageIndex == 1) {
			[bself initEmptyForm:bself.formTable.height andType:1];
		}
	} fail:^(id json) {
		[bself requestComplete];
		[bself initEmptyForm:self.formTable.height andType:2];
	}];
}

- (NSMutableArray *)getDataArray:(id)json {
	NSMutableArray *ar = [[NSMutableArray alloc] init];
	if ([json[@"obj"] isKindOfClass:[NSArray class]]) {
		[ar addObjectsFromArray:json[@"obj"]];
	}
	return ar;
}

- (NSMutableArray *)createItems:(NSArray *)array
{
	WS(bself);
	NSMutableArray *arrayItems = [[NSMutableArray alloc] init];
	
	for (int i = 0 ; i < array.count; i ++) {
        
        FMEmptyItem *em = [[FMEmptyItem alloc]initWithHeight:10];
        [arrayItems addObject:em];
        
		NSDictionary *dict = [array objectAtIndex:i];
        OrderInfoItem*item1 = [[OrderInfoItem alloc]init];
        item1.userinfo = dict;
		item1.selectionHandler = ^(OrderInfoItem* item) {
			OrderDetailViewController *vc = [[OrderDetailViewController alloc]init];
			vc.userinfo = item.userinfo;
			vc.saveSuccess = ^{
				[bself requestFirstPage];
			};
			RootNavPush(vc);
		};
		item1.btnClick = ^(NSInteger tag,OrderInfoItem* item) {
			if (tag == 100) {
				[bself popPayMenu:item];
			}
			if (tag == 101) {
				[AppUtil showAlert:@"提示" msg:@"真的要取消订单吗" handle:^(BOOL cancelled, NSInteger buttonIndex) {
					if(buttonIndex == 1){
						[bself deleteOreder:item.userinfo[@"id"]];
					}
				}];
			}
			
			if (tag == 103) {
				[AppUtil showAlert:@"注意" msg:@"是否确认收货" handle:^(BOOL cancelled, NSInteger buttonIndex) {
					if(buttonIndex == 1){
						[bself confirmOreder:item.userinfo[@"id"]];
					}
				}];
			}
			
			if (tag == 104) {
				PeisongInfoViewController *vc = [[PeisongInfoViewController alloc]init];
				vc.userinfo = item.userinfo;
				RootNavPush(vc);
			}
			if (tag == 105) {//评价
				PingJiaViewController *vc = [[PingJiaViewController alloc]init];
				vc.userinfo = item.userinfo;
				vc.saveSuccess = ^{
					[bself requestFirstPage];
					[[NSNotificationCenter defaultCenter] postNotificationName:RefreshTable object:nil];
				};
				RootNavPush(vc);
			}
			if (tag == 106) {//tousu
				ComplaintViewController *vc = [[ComplaintViewController alloc]init];
				vc.userinfo = item.userinfo;
				vc.saveSuccess = ^{
					[bself requestFirstPage];
					[[NSNotificationCenter defaultCenter] postNotificationName:RefreshTable object:nil];
				};
				RootNavPush(vc);
			}
			
			if (tag == 107) {
				[AppUtil showAlert:@"提示" msg:@"真的要删除订单吗" handle:^(BOOL cancelled, NSInteger buttonIndex) {
					if(buttonIndex == 1){
						[bself deleteOreder:item.userinfo[@"id"]];
					}
				}];
			}
		};
        [arrayItems addObject:item1];
	}
	
	return arrayItems;
}
- (void)layoutSubviews {
    [super layoutSubviews];
}
//确认收货
-(void)confirmOreder:(NSString *)orderId{
	WS(bself);
	[self showLoading];
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:StrRelay(orderId) forKey:@"id"];
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_order_confirm Param:param isCache:NO success:^(id json) {
		[bself hiddenLoading];
		[bself requestFirstPage];
		[[NSNotificationCenter defaultCenter] postNotificationName:RefreshTable object:nil];
	} fail:^(id json) {
		[bself hiddenLoading];
		Toast(@"网络错误");
	}];
}

-(void)deleteOreder:(NSString *)orderId{
	WS(bself);
	[self showLoading];
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:StrRelay(orderId) forKey:@"id"];
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_order_del Param:param isCache:NO success:^(id json) {
		[bself hiddenLoading];
		[bself requestFirstPage];
		[[NSNotificationCenter defaultCenter] postNotificationName:RefreshTable object:nil];
	} fail:^(id json) {
		[bself hiddenLoading];
		Toast(@"网络错误");
	}];
}

-(void)popPayMenu:(OrderInfoItem*)item{
	WS(bself);
	RestoreMenuView *aview = [[RestoreMenuView alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH - 40, 60*2) withArr:@[@"支付宝支付",@"微信支付"]];
	aview.backgroundColor = [UIColor whiteColor];
	aview.selectItem = ^(int type, int index, NSString *t) {
		
		if (index == 0) {
			[bself prePayOfZhifubao:item];
		}
		if (index == 1) {
			[bself prePayOfWeixin:item];
		}
		[popView remove];
	};
	popView = [[PopBottomView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
	[popView showContentView:aview];
}

-(void)prePayOfZhifubao:(OrderInfoItem*)item{
	WS(bself);
	tempitem = item;
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[self showLoading];
	[param setObject:StrRelay(item.userinfo[@"id"]) forKey:@"id"];
	[NSObject postDataWithHost:Server_Host Path:Api_buyer_order_alipay Param:param isCache:NO success:^(id json) {
		[bself hiddenLoading];
		if (IntRelay(json[@"state"]) == 1) {
			[bself goPayOfZhifubao:StrRelay(json[@"obj"])];
		}else{
			Toast(json[@"msg"]);
		}
	} fail:^(id json) {
		[bself hiddenLoading];
		Toast(@"网络错误");
	}];
}

-(void)prePayOfWeixin:(OrderInfoItem*)item{
	WS(bself);
	tempitem = item;
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[self showLoading];
	[param setObject:StrRelay(item.userinfo[@"id"]) forKey:@"id"];
	[NSObject postDataWithHost:Server_Host Path:Api_buyer_order_wechatpay Param:param isCache:NO success:^(id json) {
		[bself hiddenLoading];
		if (IntRelay(json[@"state"]) == 1) {
			if(json[@"obj"]&&[json[@"obj"] isKindOfClass:[NSDictionary class]]){
				wxDict = [NSMutableDictionary dictionaryWithDictionary:json[@"obj"]];
			}
			if (wxDict) {
				[bself goPayOfWeixin:wxDict tradeNo:StrRelay(self.userinfo[@"id"])];
			}
		}else{
			Toast(json[@"msg"]);
		}
	} fail:^(id json) {
		[bself hiddenLoading];
		Toast(@"网络错误");
		
	}];
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
			if (bself.payOk) {
				bself.payOk(tempitem.userinfo);
			}
		}
		else {
			Toast(@"支付失败");
		}
	}];
}

- (void)goPayOfZhifubao:(NSString *)orderString {
	WS(bself);
	[AlipaySDK xwAdd_sendPayWithOrderInfo:orderString appScheme:Alipay_Scheme callbackConfig:^(BOOL successed) {
		if (successed) {
			if (bself.payOk) {
				bself.payOk(tempitem.userinfo);
			}
		}
		else {
			Toast(@"支付失败");
		}
	}];
}
@end
