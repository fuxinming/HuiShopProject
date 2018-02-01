//
//  ProductDetailViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/12/2.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "ProductInfoCell.h"
#import "PingLunTagListCell.h"
#import "TitleTipCell.h"
#import "HotProductCell.h"
#import "LoginViewController.h"
#import "NowMaiViewController.h"
#import "FreeViewCell.h"
#import "PingLunCell.h"
#import "AllEvalViewController.h"
@interface ProductDetailViewController (){
	UIView *bottomView;
	TabarItem *btn1;//收藏
	TabarItem *btn2;//购物车
	UILabel *circleLabel;
	
	UIButton *btn3;
}
@property (nonatomic, strong) NSMutableArray *tagArr;
@property (nonatomic, strong) NSMutableArray *pingLunArr;
@property (nonatomic, strong) NSMutableArray *levelList;
@property (nonatomic, strong) NSMutableArray *gouwucheArr;
@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navBar.title = @"商品详细";
	self.formTable.frame = CGRectMake(0, NavigationBarH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarH - TabBarH);
	self.formManager[@"ProductInfoItem"] = @"ProductInfoCell";
	self.formManager[@"PingLunTagListItem"] = @"PingLunTagListCell";
	self.formManager[@"TitleTipItem"] = @"TitleTipCell";
	self.formManager[@"HotProductItem"] = @"HotProductCell";
	self.formManager[@"FreeViewItem"] = @"FreeViewCell";
	self.formManager[@"PingLunItem"] = @"PingLunCell";
	[self getPinglun];
	[self beginRefrash];
	[self initBottomView];
	
	[AppUtil AddLookRecord:self.userinfo];
}
-(void)getGouwuChe{
	WS(bself);
	NSMutableDictionary *dict = [AppUtil getPublicParam];
	[self showLoading];
	[NSObject postDataWithHost:Server_Host Path:Api_buyer_cart_list Param:dict isCache:NO success:^(id json) {
		[bself hiddenLoading];
		if (json[@"obj"] && [json[@"obj"] isKindOfClass:[NSArray class]]) {
			bself.gouwucheArr = [NSMutableArray arrayWithArray:json[@"obj"]];
			[self addCircleLabel];
		}
	} fail:^(id json) {
		[bself hiddenLoading];
	}];
}
-(void)getPinglun{
	WS(bself);
	NSMutableDictionary *dict = [AppUtil getPublicParam];
	if (ISEmptyStr(self.type)) {
		self.type = @"0";
	}
	[dict setObject:self.type forKey:@"type"];
	[dict setObject:self.userinfo[@"id"] forKey:@"id"];
	[dict setObject:@"1" forKey:@"curpage"];
	[dict setObject:@"10" forKey:@"rp"];
	[self showLoading];
	[NSObject postDataWithHost:Server_Host Path:Api_Buyer_GoodEval Param:dict isCache:NO success:^(id json) {
		bself.tagArr = [NSMutableArray arrayWithArray:json[@"obj"][@"tagList"]];
		bself.pingLunArr = [NSMutableArray arrayWithArray:json[@"obj"][@"evalList"]];
		bself.levelList = [NSMutableArray arrayWithArray:json[@"obj"][@"levelList"]];
		[bself reloadSection1];
		[bself hiddenLoading];
		if (IsLogin) {
			[self getGouwuChe];
		}
	} fail:^(id json) {
		[bself reloadSection1];
		[bself hiddenLoading];
	}];
}
-(void)reloadSection1{
    [self.section1 removeAllItems];
	ProductInfoItem *infoItem  = [[ProductInfoItem alloc]init];
	infoItem.userinfo = self.userinfo;
	[self.section1 addItem:infoItem];
	if (self.tagArr.count > 0) {
		PingLunTagListItem *tagItem = [[PingLunTagListItem alloc]init];
		tagItem.tagListArray = self.tagArr;
		tagItem.evalListArray = self.pingLunArr;
		[self.section1 addItem:tagItem];
	}
	if (self.pingLunArr.count > 0) {
		PingLunItem *pItem = [[PingLunItem alloc]init];
		pItem.userinfo = self.pingLunArr[0];
		[self.section1 addItem:pItem];
		
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn setTitle:@"查看全部评价" forState:UIControlStateNormal];
		[btn setTitleColor:COLOR_999 forState:UIControlStateNormal];
		[btn.titleLabel setFont:Font_Size_13];
		btn.tag = 100;
		btn.frame = CGRectMake((SCREEN_WIDTH - 100)/2, 10, 100, 24);
		[btn addTarget:self action:@selector(quanbupinglun) forControlEvents:UIControlEventTouchUpInside];
		View_Border_Radius(btn, 2, 0.5, COLOR_999);
		FreeViewItem *itemF = [[FreeViewItem alloc]init];
		itemF.bgColor = [UIColor whiteColor];
		itemF.cellHeight = 44;
		itemF.freeView = btn;
		[self.section1 addItem:itemF];
	}
	
	TitleTipItem *item08 = [[TitleTipItem alloc]init];
	item08.t1 = @"商品推荐";
	item08.tFont = Font_Size_13;
	item08.haveArrow = NO;
	item08.haveLine = NO;
	item08.backColor = Color_Clear;
	[self.section1 addItem:item08];
	
    [self.section1 reloadSectionWithAnimation:UITableViewRowAnimationNone];
}

- (void)requestWithPage:(int)pageIndex {
	WS(bself);
	NSMutableDictionary *dict = [AppUtil getPublicParam];
	[dict setObject:@"4" forKey:@"rp"];
	[dict setObject:[NSNumber numberWithInt:pageIndex] forKey:@"curpage"];
	[dict setObject:@"desc" forKey:@"sortorder"];
	[dict setObject:@"qty" forKey:@"sortname"];
	[NSObject postDataWithHost:Server_Host Path:Api_BuyerGoodRecommend Param:dict isCache:NO success:^(id json) {
		NSMutableArray *resultArr = [bself getDataArray:json];
		if (resultArr.count == 4) {
			self.hasNextPage = 1;
		}else{
			self.hasNextPage = -1;
		}
		[bself requestFinish:resultArr];
		[bself requestComplete];
	} fail:^(id json) {
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
    
    
    HotProductItem *arrItem = [[HotProductItem alloc]init];
    arrItem.eventArr = array;
    [arrayItems addObject:arrItem];
	
    return arrayItems;
}

-(void)initBottomView{
	bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT - TabBarH, SCREEN_WIDTH, TabBarH)];
	bottomView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:bottomView];
	
	UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 0.5)];
	lineView.backgroundColor = COLOR_ddd;
	[bottomView addSubview:lineView];
	
	btn1 = [TabarItem buttonWithType:UIButtonTypeCustom];
	btn1.frame =  CGRectMake(0, 0, 80, TabBarH);
	btn1.tag = 100;
	btn1.titleLabel.font = [UIFont systemFontOfSize:12];
	btn1.titleLabel.textAlignment = NSTextAlignmentCenter;
	[btn1 setTitle:@"收藏" forState:UIControlStateNormal];
	[btn1 setTitleColor:COLOR_333 forState:UIControlStateNormal];
	[btn1 setTitleColor:COLOR_333 forState:UIControlStateHighlighted];
	[btn1 setTitleColor:COLOR_333 forState:UIControlStateSelected];
	[btn1 setImage:[UIImage imageNamed:@"weishoucang"] forState:UIControlStateNormal];
	[btn1 setImage:[UIImage imageNamed:@"yishoucang"] forState:UIControlStateSelected];
	[btn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	if([AppUtil isCollection:StrRelay(self.userinfo[@"id"])]){
		btn1.selected = YES;
	}else{
		btn1.selected = NO;
	}
	[bottomView addSubview:btn1];
	
	btn2 = [TabarItem buttonWithType:UIButtonTypeCustom];
	btn2.frame =  CGRectMake(80, 0, 80, TabBarH);
	btn2.tag = 101;
	btn2.titleLabel.font = [UIFont systemFontOfSize:12];
	btn2.titleLabel.textAlignment = NSTextAlignmentCenter;
	[btn2 setTitle:@"购物车" forState:UIControlStateNormal];
	[btn2 setTitleColor:COLOR_333 forState:UIControlStateNormal];
	[btn2 setTitleColor:COLOR_333 forState:UIControlStateHighlighted];
	[btn2 setTitleColor:COLOR_333 forState:UIControlStateSelected];
	[btn2 setImage:[UIImage imageNamed:@"icon_shoppingCart"] forState:UIControlStateNormal];
	[btn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	[bottomView addSubview:btn2];
	
	btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn3 setTitle:@"加入购物车" forState:UIControlStateNormal];
	[btn3 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	btn3.backgroundColor = COLOR_YELLOW_;
	[btn3.titleLabel setFont:Font_Size_13];
	btn3.tag = 102;
	btn3.frame = CGRectMake(160, 0, (SCREEN_WIDTH - 160)/2, TabBarH);
	[btn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	[bottomView addSubview:btn3];
	
	UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn4 setTitle:@"立即购买" forState:UIControlStateNormal];
	[btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[btn4.titleLabel setFont:Font_Size_13];
	btn4.backgroundColor = COLOR_RED_;
	btn4.tag = 103;
	btn4.frame = CGRectMake((SCREEN_WIDTH - 160)/2 + 160, 0, (SCREEN_WIDTH - 160)/2, TabBarH);
	[btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	[bottomView addSubview:btn4];
}

-(void)btnClick:(TabarItem *)btn{
	WS(bself);
	if (btn.tag == 100) {
		if (btn.selected) {
			[AppUtil RemoveCollection:StrRelay(self.userinfo[@"id"]) ];
		}else{
			[AppUtil AddCollection:self.userinfo];
		}
		btn.selected = !btn.selected;
		
		[[NSNotificationCenter defaultCenter] postNotificationName:RefreshTable object:nil];
	}
	if (btn.tag == 101) {
		[self popToViewController:@"FMTabBar"];
		AppDelegate *del = [CommonUtil appDelegate];
		[del.tab setTabIndex:2];
	}
	
	
	if (btn.tag == 102) {
		if (!IsLogin) {
			LoginViewController *vc = [[LoginViewController alloc]init];
			vc.saveSuccess = ^{
				[bself getPinglun];
			};
			RootNavPush(vc);
		}else{
			[self addToCart];
		}
		
	}
	if (btn.tag == 103) {
		if (!IsLogin) {
			LoginViewController *vc = [[LoginViewController alloc]init];
			vc.saveSuccess = ^{
				[bself getPinglun];
				[bself getGouwuChe];
			};
			RootNavPush(vc);
		}else{
			NowMaiViewController *vc = [[NowMaiViewController alloc]init];
			if (ISEmptyStr(self.type)) {
				self.type = @"0";
			}
			vc.type = self.type;
			vc.productId = self.userinfo[@"id"];
			RootNavPush(vc);
		}
		
	}
	
}

-(void)addToCart{
	WS(bself);
	NSMutableDictionary *param = [AppUtil getPublicParam];
	if (ISEmptyStr(self.type)) {
		self.type = @"0";
	}
	[param setObject:self.type forKey:@"type"];
	[param setObject:self.userinfo[@"id"] forKey:@"id"];
	btn3.enabled= NO;
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_cart_add Param:param isCache:NO success:^(id json) {
		btn3.enabled  = YES;
		[bself getGouwuChe];
	} fail:^(id json) {
		btn3.enabled  = YES;
	}];
}

-(void)addCircleLabel{
	if (circleLabel) {
		[circleLabel removeFromSuperview];
		circleLabel = nil;
	}
	int cout = 0;
	for (int i = 0 ; i < self.gouwucheArr.count; i ++) {
		NSDictionary *dict = [self.gouwucheArr objectAtIndex:i];
		if(dict[@"goodsList"]&& [dict[@"goodsList"] isKindOfClass:[NSArray class]]){
			NSArray *sArr = dict[@"goodsList"];
			for (int j = 0 ; j < sArr.count; j++) {
				NSDictionary *dict1 = [sArr objectAtIndex:j];
				cout+= IntRelay(dict1[@"goodsQty"]);
			}
		}
	}
	if (cout > 0) {
		circleLabel = [[UILabel alloc]initWithFrame:CGRectMake(80 - 30, 5, 14, 14)];
		circleLabel.font = Font_Size_10;
		circleLabel.text = [NSString stringWithFormat:@"%d",cout];
		circleLabel.textColor = COLOR_RED_;
		circleLabel.textAlignment = NSTextAlignmentCenter;
		View_Border_Radius(circleLabel, 7, 1, COLOR_RED_);
		[btn2 addSubview:circleLabel];
	}
	
}
-(void)quanbupinglun{
	AllEvalViewController *vc = [[AllEvalViewController alloc]init];
	vc.type = self.type;
	vc.userinfo = self.userinfo;
	vc.tagArr = self.tagArr;
	vc.levelList = self.levelList;
	vc.pingLunArr = self.pingLunArr;
	RootNavPush(vc);
}

@end
