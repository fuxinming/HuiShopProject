//
//  AllEvalViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2018/1/11.
//  Copyright © 2018年 付新明. All rights reserved.
//

#import "AllEvalViewController.h"
#import "PingLunCell.h"
#import "AllEvalHeadCell.h"
#import "AllEvalTagListCell.h"
@interface AllEvalViewController (){
	int  tabIndex;
}

@end

@implementation AllEvalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	tabIndex = 0;
	self.navBar.title = @"全部评论";
	self.formManager[@"PingLunItem"] = @"PingLunCell";
	self.formManager[@"AllEvalHeadItem"] = @"AllEvalHeadCell";
	self.formManager[@"AllEvalTagListItem"] = @"AllEvalTagListCell";
	[self beginRefrash];
}

- (void)requestWithPage:(int)pageIndex {
	WS(bself);
	
	NSMutableDictionary *dict = [AppUtil getPublicParam];
	if (ISEmptyStr(self.type)) {
		self.type = @"0";
	}
	[dict setObject:self.type forKey:@"type"];
	[dict setObject:self.userinfo[@"id"] forKey:@"id"];
	[dict setObject:@"1" forKey:@"curpage"];
	[dict setObject:@"10" forKey:@"rp"];
	
	[dict setObject:StrRelay(self.levelList[tabIndex][@"evalLevelId"])  forKey:@"evalLevelId"];
	[NSObject postDataWithHost:Server_Host Path:Api_buyer_good_eval_list Param:dict isCache:NO success:^(id json) {
		NSMutableArray *resultArr = [bself getDataArray:json];
		if (resultArr.count == 10) {
			self.hasNextPage = 1;
		}else{
			self.hasNextPage = -1;
		}
		[bself requestFinish:resultArr];
		
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
	WS(bself);
	NSMutableArray *arrayItems = [[NSMutableArray alloc] init];
	
	AllEvalHeadItem *head = [[AllEvalHeadItem alloc]init];
	head.defIndex = tabIndex;
	head.userinfo = self.levelList;
	head.buttonClick = ^(NSInteger tag, id item) {
		tabIndex = tag;
		[bself beginRefrash];
	};
	[arrayItems addObject:head];
	
	AllEvalTagListItem *tagItem = [[AllEvalTagListItem alloc]init];
	tagItem.tagListArray = self.tagArr;
	[arrayItems addObject:tagItem];
	
	
	for (int i = 0; i < array.count; i++) {
		NSDictionary *dict=[array objectAtIndex:i];
		PingLunItem *item1 = [[PingLunItem alloc]init];
		item1.userinfo = dict;
		[arrayItems addObject:item1];
	}
	
	
	return arrayItems;
}


@end
