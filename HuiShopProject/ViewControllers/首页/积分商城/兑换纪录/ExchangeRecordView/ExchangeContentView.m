//
//  CXMatchContentView.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/7.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "ExchangeContentView.h"
#import "EmptyDataCell.h"
#import "ExchangeRecordeInfoCell.h"
@implementation ExchangeContentView

- (id)initWithFrame:(CGRect)frame andType:(int)type{
    self = [super initWithFrame:frame];
    if (self) {
		self.type = type + 1;
        self.formManager[@"ExchangeRecordeInfoItem"] = @"ExchangeRecordeInfoCell";
        self.formManager[@"EmptyDataItem"] = @"EmptyDataCell";
		[self beginRefrash];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
}

- (void)requestWithPage:(int)pageIndex {
	WS(bself);
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:@"10" forKey:@"rp"];
	[param setObject:[NSNumber numberWithInt:pageIndex] forKey:@"curpage"];
	[param setObject:[NSString stringWithFormat:@"%d",self.type] forKey:@"state"];

	[NSObject getDataWithHost:Server_Host Path:Api_buyer_exchange_list Param:param isCache:NO success:^(id json) {
		[bself requestComplete];
		if (IntRelay(json[@"state"]) == 1) {
			NSArray *arr = json[@"obj"];
			if (arr.count == 10) {
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
		ExchangeRecordeInfoItem*item1 = [[ExchangeRecordeInfoItem alloc]init];
		item1.userinfo = dict;
		[arrayItems addObject:item1];
	}
	
	return arrayItems;
}


@end
