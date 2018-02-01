//
//  ImportProductViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/11/23.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "ImportProductViewController.h"
#import "ConditionSiftBar2.h"
#import "SearchProductCell.h"
@interface ImportProductViewController (){
	 NSString *sortName;
}

@end

@implementation ImportProductViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	WS(bself);
    self.navBar.title = @"进口食品";
	self.formManager[@"SearchProductItem"] = @"SearchProductCell";
	self.formTable.frame = CGRectMake(0, NavigationBarH + 42, SCREEN_WIDTH,SCREEN_HEIGHT - NavigationBarH - 42);
	
	
	ConditionSiftBar2 *siftBar = [[ConditionSiftBar2 alloc]initWithFrame:CGRectMake(0, NavigationBarH, SCREEN_WIDTH, 42)];
	siftBar.rightBtnClick = ^(NSString *str) {
		sortName = str;
		[bself requestFirstPage];
	};
	[self.view addSubview:siftBar];
	sortName = @"qty";
	[self beginRefrash];
}

- (void)requestWithPage:(int)pageIndex {
	WS(bself);
	NSMutableDictionary *dict = [AppUtil getPublicParam];
	[dict setObject:@"10" forKey:@"rp"];
	[dict setObject:[NSNumber numberWithInt:pageIndex] forKey:@"curpage"];
	[dict setObject:@"asc" forKey:@"sortorder"];
	[dict setObject:sortName forKey:@"sortname"];
	[dict setObject:StrRelay(self.userinfo[@"id"]) forKey:@"catId"];
	
	[NSObject postDataWithHost:Server_Host Path:Api_BuyerGoodImport Param:dict isCache:NO success:^(id json) {
		NSMutableArray *resultArr = [bself getDataArray:json];
		if (resultArr.count == 10) {
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
	SearchProductItem *item1 = [[SearchProductItem alloc]init];
	item1.eventArr = array;
	[arrayItems addObject:item1];
	
	return arrayItems;
}

@end
