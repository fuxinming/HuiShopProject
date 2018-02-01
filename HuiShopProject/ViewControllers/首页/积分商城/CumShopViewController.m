//
//  CumShopViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/11/23.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "CumShopViewController.h"
#import "PointGoodCell.h"
#import "GoodExchangeViewController.h"
#import "ExchangeRecordViewController.h"
@interface CumShopViewController (){
	float topHeight;
	UILabel *label2;
	int points;
}

@end

@implementation CumShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   	self.navBar.title = @"积分商城";
	self.formManager[@"PointGoodItem"] = @"PointGoodCell";
	topHeight = SCREEN_WIDTH/3+60;
	UIView *bgv = [[UIView alloc]initWithFrame:CGRectMake(0, NavigationBarH, SCREEN_WIDTH, topHeight)];
	bgv.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:bgv];
	
	UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,topHeight - 0.5, SCREEN_WIDTH, 0.5)];
	lineView.backgroundColor = COLOR_ddd;
	[bgv addSubview:lineView];
	
	UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH/3)];
	img1.image = [UIImage imageNamed:@"img_integral_top"];
	[bgv addSubview:img1];
	
	UILabel *label1 = [[UILabel alloc] init];
	label1.text = @"我的积分";
	label1.textColor = COLOR_333;
	label1.font = Font_Size_14;
	[label1 sizeToFit];
	label1.frame = CGRectMake(14, img1.bottom + 14, label1.width, 16);
	[bgv addSubview:label1];
	
	
	label2 = [[UILabel alloc] init];
	label2.text = @"";
	label2.textColor = COLOR_RED_;
	label2.font = Font_Size_16;
	label2.frame = CGRectMake(label1.right + 14,0, 100, 18);
	label2.centerY = label1.centerY;
	[bgv addSubview:label2];
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn setTitle:@"如何获取更多积分?" forState:UIControlStateNormal];
	[btn setTitleColor:COLOR_333 forState:UIControlStateNormal];
	[btn.titleLabel setFont:Font_Size_12];
	btn.tag = 100;
	btn.frame = CGRectMake(14, label1.bottom, 120, 30);
	[btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
	[bgv addSubview:btn];
	
	UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn1 setTitle:@"兑换纪录" forState:UIControlStateNormal];
	[btn1 setTitleColor:COLOR_999 forState:UIControlStateNormal];
	[btn1.titleLabel setFont:Font_Size_14];
	btn1.frame = CGRectMake(SCREEN_WIDTH - 95, img1.bottom + 15, 80, 30);
	[btn1 addTarget:self action:@selector(btn1Click) forControlEvents:UIControlEventTouchUpInside];
	View_Border_Radius(btn1, 4, 0.5, COLOR_999);
	[bgv addSubview:btn1];
	
	self.formTable.frame = CGRectMake(0, topHeight + NavigationBarH, SCREEN_WIDTH, SCREEN_HEIGHT - topHeight - NavigationBarH);
	[self beginRefrash];
	[self getPoint];
}

-(void)getPoint{
	WS(bself);
	
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_getpoint Param:nil isCache:NO success:^(id json) {
		label2.text  = StrRelay(json[@"obj"]);
		points = IntRelay(json[@"obj"]);
	} fail:^(id json) {
	}];
}
- (void)requestWithPage:(int)pageIndex {
	WS(bself);
	NSMutableDictionary *dict = [AppUtil getPublicParam];
	[dict setObject:@"20" forKey:@"rp"];
	[dict setObject:[NSNumber numberWithInt:pageIndex] forKey:@"curpage"];
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_pointgood_list Param:dict isCache:NO success:^(id json) {
		NSMutableArray *resultArr = [bself getDataArray:json];
		if (resultArr.count == 20) {
			self.hasNextPage = 1;
		}else{
			self.hasNextPage = -1;
		}
		
		[bself requestFinish:resultArr];
		if (resultArr.count==0 && pageIndex == 1) {
			[bself initEmptyForm:bself.formTable.height andType:1];
		}
		[bself requestComplete];
	} fail:^(id json) {
		[bself initEmptyForm:bself.formTable.height andType:2];
		[bself requestComplete];
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
	NSMutableArray *arrayItems = [[NSMutableArray alloc] init];
	PointGoodItem *item1 = [[PointGoodItem alloc]init];
	item1.eventArr = array;
	item1.mybtnClick = ^(id item) {
		GoodExchangeViewController *vc = [[GoodExchangeViewController alloc]init];
		vc.point = points;
		vc.userinfo = item;
		RootNavPush(vc);
	};
	[arrayItems addObject:item1];
	
	return arrayItems;
}


-(void)btnClick{
	Toast(@"购物赚积分");
}

-(void)btn1Click{
	ExchangeRecordViewController *vc= [[ ExchangeRecordViewController alloc]init];
	RootNavPush(vc);
}
@end
