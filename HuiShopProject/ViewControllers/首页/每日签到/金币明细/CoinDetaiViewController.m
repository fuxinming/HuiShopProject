//
//  CoinDetaiViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2018/1/18.
//  Copyright © 2018年 付新明. All rights reserved.
//

#import "CoinDetaiViewController.h"
#import "MyJinBi1Cell.h"
#import "JinbiRowCell.h"
@interface CoinDetaiViewController (){
	NSArray *initArr;
}

@end

@implementation CoinDetaiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navBar.title = @"金币明细";
	self.formManager[@"MyJinBi1Item"] = @"MyJinBi1Cell";
	self.formManager[@"JinbiRowItem"] = @"JinbiRowCell";
	
	[self getData];
}

-(void)getData{
	WS(bself);
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_coin_list Param:nil isCache:NO success:^(id json) {
		initArr = [NSArray arrayWithArray:json[@"obj"]];
		if(initArr.count == 0){
			[bself initEmptyForm:bself.formTable.height andType:2];
		}else{
			[bself initForm];
		}
		
	} fail:^(id json) {
		Toast(@"网络错误");
		[bself initEmptyForm:bself.formTable.height andType:2];
	}];
}

-(void)initForm{
	WS(bself);
	RETableViewSection *section0 = [RETableViewSection section];
	
	MyJinBi1Item *jinBi = [[MyJinBi1Item alloc]init];
	jinBi.jinbi = self.jinbi;
	[section0 addItem:jinBi];
	
	[section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
	
	for (int i = 0; i < initArr.count; i++) {
		NSDictionary *dcit = [initArr objectAtIndex:i];
		JinbiRowItem*item1 = [[JinbiRowItem alloc]init];
		item1.jinbi = [NSString stringWithFormat:@"+%@",StrRelay(dcit[@"coins"])] ;
		item1.time = [DateUtil timeWithTimeIntervalString:StrRelay(dcit[@"signinTime"])];
		[section0 addItem:item1];
	}
	[self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
	[self.formTable reloadData];
	
}

@end
