//
//  PingJiaViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2018/1/8.
//  Copyright © 2018年 付新明. All rights reserved.
//

#import "PingJiaViewController.h"
#import "PingjiaHeadCell.h"
#import "PingTagListCell.h"
#import "WSFeedBackCell.h"
#import "SelectPicCell.h"
#import "SelectPingjiaLevelCell.h"
#import "TitleSwitchCell.h"
@interface PingJiaViewController (){
	
	PingTagListItem *itemPingtag;
	WSFeedBackItem *remarkItem;
	
	TitleSwitchItem *item02;
	SelectPicItem *picItem;
	SelectPingjiaLevelItem *itemxing;
	
	UIButton *bottomBtn;
	
	NSArray *goodArr;
	NSDictionary *goodDict;
	int goodIndex;
}
@property (nonatomic, strong) NSMutableArray *myArr1;
@property (nonatomic, strong) NSMutableArray *myArr2;
@end

@implementation PingJiaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navBar.title = @"评价晒单";
	self.formManager[@"PingjiaHeadItem"] = @"PingjiaHeadCell";
	self.formManager[@"PingTagListItem"] = @"PingTagListCell";
	self.formManager[@"WSFeedBackItem"] = @"WSFeedBackCell";
	self.formManager[@"SelectPicItem"] = @"SelectPicCell";
	self.formManager[@"SelectPingjiaLevelItem"] = @"SelectPingjiaLevelCell";
	self.formManager[@"TitleSwitchItem"] = @"TitleSwitchCell";
	self.formTable.frame = CGRectMake(0, NavigationBarH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarH - 40);
	goodIndex = 0;
	[self getData];
}

-(void)getData{
	WS(bself);
	[self showLoading];
	[NSObject getDataWithHost:Server_Host Path:Api_goods_evalbase Param:nil isCache:NO success:^(id json) {
		bself.myArr1 = [NSMutableArray arrayWithArray:json[@"obj"][@"evaltag"]];
		bself.myArr2 = [NSMutableArray arrayWithArray:json[@"obj"][@"evalLevel"]];
		[bself hiddenLoading];
		[bself initForm];
		[bself addBottomBtn];
	} fail:^(id json) {
		[bself hiddenLoading];
		Toast(@"网络错误");
	}];
}
-(void)initForm{
	WS(bself);
	RETableViewSection *section0 = [RETableViewSection section];
	
	goodArr = self.userinfo[@"goodsList"];
	if (goodArr.count > goodIndex) {
		goodDict = goodArr[goodIndex];
	}
	PingjiaHeadItem *itemh = [[PingjiaHeadItem alloc]init];
	itemh.t1 = StrRelay(goodDict[@"picUrl"]);
	itemh.t2 = StrRelay(goodDict[@"goodsName"]);
	[section0 addItem:itemh];
	
	[section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
	
	itemPingtag = [[PingTagListItem alloc]init];
	itemPingtag.tagListArray = self.myArr1;
	[section0 addItem:itemPingtag];
	
	
	remarkItem = [[WSFeedBackItem alloc]init];
	remarkItem.placeH = @"请输入评价内容";
	[section0 addItem:remarkItem];
	
	picItem = [[SelectPicItem alloc]init];
	[section0 addItem:picItem];
	
	[section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
	
	itemxing = [[SelectPingjiaLevelItem alloc]init];
	itemxing.evalListArray = self.myArr2;
	[section0 addItem:itemxing];
	
	[section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
	
	item02 = [[TitleSwitchItem alloc]init];
	item02.t1 = @"匿名评价";
	item02.switchFlag = YES;
	[section0 addItem:item02];
	
	[section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
	
	[self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
	[self.formTable reloadData];
	
}

-(void)addBottomBtn{
	if (bottomBtn) {
		[bottomBtn removeFromSuperview];
		bottomBtn = nil;
	}
	bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[bottomBtn setTitle:@"提交评价" forState:UIControlStateNormal];
	[bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[bottomBtn.titleLabel setFont:Font_Size_14];
	bottomBtn.tag = 100;
	bottomBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40);
	bottomBtn.backgroundColor = COLOR_RED_;
	[bottomBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:bottomBtn];
}

-(void)btnClick:(UIButton *)btn{
	WS(bself);
	if(ISEmptyStr(remarkItem.remarks)){
		Toast(@"请输入评价内容");
		return;
	}
	if (itemxing.def == -1) {
		Toast(@"请选择评价等级");
		return;
	}
	[self showLoading];
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:itemPingtag.evalListArray forKey:@"tagIds"];
	[param setObject:StrRelay(goodDict[@"id"]) forKey:@"orderGoodsId"];
	[param setObject:StrRelay(remarkItem.remarks) forKey:@"evalText"];
	[param setObject:StrRelay(itemxing.selIndex) forKey:@"evalLevelId"];
	if (item02.switchFlag) {
		[param setObject:@"1" forKey:@"cryptonym"];
	}else{
		[param setObject:@"0" forKey:@"cryptonym"];
	}
	NSMutableArray *fileArr = [NSMutableArray array];
	for (int i = 0; i < picItem.arrayPics.count; i ++) {
		UIImage *image = [UIImage imageWithContentsOfFile:picItem.arrayPics[i]];
		NSData *imagdata = UIImageJPEGRepresentation(image, 0.6);
		NSString *dataStr = [imagdata base64EncodedStringWithOptions:0];
		[fileArr addObject:dataStr];
	}
	[param setObject:fileArr forKey:@"files"];
	
	
	NSString *param1 = [NSString jsonStringWithObject:param];
	[NSObject postDataWithHost:Server_Host Path:Api_order_eval_add Param:param1 success:^(id json) {
		[bself hiddenLoading];
		if (IntRelay(json[@"state"]) == 1) {
			if (goodArr.count == 1) {
				if (bself.saveSuccess) {
					bself.saveSuccess();
				}
				RootNavPop(YES);
			}else{
				if (goodIndex < goodArr.count - 1) {
					goodIndex++;
					[bself initForm];
				}else{
					if (bself.saveSuccess) {
						bself.saveSuccess();
					}
					RootNavPop(YES);
				}
			}
		}
		Toast(json[@"msg"]);
	} fail:^(id json) {
		[bself hiddenLoading];
		Toast(@"网络错误");
	}];
}
@end
