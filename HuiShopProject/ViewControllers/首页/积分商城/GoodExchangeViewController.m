//
//  CumShopViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/11/23.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "GoodExchangeViewController.h"

@interface GoodExchangeViewController (){
}

@end

@implementation GoodExchangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   	self.navBar.title = @"商品兑换";
	
	UIImageView *icon = [[UIImageView alloc]init];
	[icon setWebImageWithUrl:StrRelay(self.userinfo[@"picUrl"]) placeHolder:nil];
	icon.frame = CGRectMake(20, NavigationBarH + 20, SCREEN_WIDTH - 40, SCREEN_WIDTH - 40);
	[self.view addSubview:icon];
	
	
	UILabel *label1 = [[UILabel alloc] init];
	label1.text = StrRelay(self.userinfo[@"goodsName"]);
	label1.textColor = COLOR_333;
	label1.font = Font_Size_14;
	[label1 sizeToFit];
	label1.frame = CGRectMake(20, icon.bottom + 20, label1.width, 16);
	[self.view addSubview:label1];
	
	
	NSMutableAttributedString *str1 = [CommonUtil mutableStringAppendString:[NSString stringWithFormat:@"%@",StrRelay(self.userinfo[@"consumption"])].color(COLOR_RED_).font(Font_Size_15)];
	str1.append(@"  积分".color(COLOR_999).font(Font_Size_13));
	UILabel *priceLabel = [[UILabel alloc] init];
	priceLabel.attributedText = str1;
	priceLabel.frame = CGRectMake(20, label1.bottom + 20, 200, 16);
	[self.view addSubview:priceLabel];
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn setTitle:@"立即兑换" forState:UIControlStateNormal];
	[btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[btn.titleLabel setFont:Font_Size_15];
	btn.frame = CGRectMake(50, priceLabel.bottom + 20, SCREEN_WIDTH - 100, 45);
	[btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
	if (self.point < IntRelay(self.userinfo[@"consumption"])) {
		btn.backgroundColor = COLOR_999;
	}else{
		btn.backgroundColor = COLOR_RED_;
	}
	View_Border_Radius(btn, 4, 0, Color_Clear);
	[self.view addSubview:btn];
	

}




-(void)btnClick{
	WS(bself);
	if (self.point < IntRelay(self.userinfo[@"consumption"])) {
		Toast(@"积分不足");
	}else{
		[self showLoading];
		NSMutableDictionary *dict = [AppUtil getPublicParam];
		[dict setObject:StrRelay(self.userinfo[@"id"]) forKey:@"id"];
		[NSObject getDataWithHost:Server_Host Path:Api_buyer_pointgood_exchange Param:dict isCache:NO success:^(id json) {
			[bself hiddenLoading];
			Toast(json[@"msg"]);
		} fail:^(id json) {
			Toast(@"网络错误");
			[bself hiddenLoading];
		}];
	}
	
}

@end
