//
//  FeedBackViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2018/1/2.
//  Copyright © 2018年 付新明. All rights reserved.
//

#import "FeedBackViewController.h"
#import "TitleTip2Cell.h"
#import "WSFeedBackCell.h"
#import "FreeViewCell.h"
@interface FeedBackViewController (){
	WSFeedBackItem *remarkItem;
}

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navBar.title = @"意见反馈";
	self.view.backgroundColor = [UIColor whiteColor];
	self.formManager[@"TitleTip2Item"] = @"TitleTip2Cell";
	self.formManager[@"WSFeedBackItem"] = @"WSFeedBackCell";
	self.formManager[@"FreeViewItem"] = @"FreeViewCell";
	[self initForm];
}

-(void)initForm{
	WS(bself);
	RETableViewSection *section0 = [RETableViewSection section];
	
	TitleTip2Item *t11 = [[TitleTip2Item alloc]init];
	t11.cellHeight = 40;
	t11.t1 = @"因为有你的意见我们才可以做的更好";
	t11.t1Color = COLOR_999;
	t11.t1Font = Font_Size_14;
	[section0 addItem:t11];
	
	
	remarkItem = [[WSFeedBackItem alloc]init];
	[section0 addItem:remarkItem];
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn setTitle:@"提交" forState:UIControlStateNormal];
	[btn setTitleColor:COLOR_RED_ forState:UIControlStateNormal];
	[btn.titleLabel setFont:Font_Size_14];
	btn.tag = 100;
	btn.frame = CGRectMake((SCREEN_WIDTH - 150)/2, 0, 150, 40);
	[btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	View_Border_Radius(btn, 4, 1, COLOR_RED_);
	FreeViewItem *itemF = [[FreeViewItem alloc]init];
	itemF.cellHeight = 40;
	itemF.freeView = btn;
	[section0 addItem:itemF];
	
	
	[self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
	[self.formTable reloadData];
	
}

-(void)btnClick:(UIButton *)btn{
	if(remarkItem.remarks.length <=0){
		Toast(@"请输入反馈内容");
		return;
	}
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:remarkItem.remarks forKey:@"text"];
	[NSObject postDataWithHost:Server_Host Path:Api_buyer_opinion_add Param:param isCache:NO success:^(id json) {
		Toast(json[@"msg"]);
		RootNavPop(YES);
	} fail:^(id json) {
		
	}];

}
@end
