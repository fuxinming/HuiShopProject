//
//  CXMatchContentView.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/7.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "AddressContentView.h"
#import "AddressDetailInfoCell.h"
#import "EmptyDataCell.h"
#import "OrderDetailViewController.h"
@implementation AddressContentView

- (id)initWithFrame:(CGRect)frame andKey:(NSString *)key andPt:(CLLocationCoordinate2D)pt{
	self = [super initWithFrame:frame];
	if (self) {
		self.formManager[@"AddressDetailInfoItem"] = @"AddressDetailInfoCell";
		self.key = key;
		self.pt = pt;
		[self addHeader];
	}
	return self;
}

-(void)layoutSubviews{
	[super layoutSubviews];
}

-(void)initForm{
	WS(bself);
	RETableViewSection *section0 = [RETableViewSection section];
	
	NSArray *arr = self.userinfo;
	for(int i = 0 ;i < arr.count;i++){
		BMKPoiInfo *info1 =arr[i];
		AddressDetailInfoItem *item1 = [[AddressDetailInfoItem alloc]init];
		item1.info = info1;
		item1.str1 = info1.name;
		item1.str2 = info1.address;
		item1.selectionHandler = ^(AddressDetailInfoItem * item) {
			if (bself.selectAddress) {
				bself.selectAddress(item.info);
			}
		};
		[section0 addItem:item1];
	}
	
	[self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
	[self.formTable reloadData];
	
}

-(void)getData{
	WS(bself);
	[self poiSearchNearby:bself.pt key:bself.key];
	
}
-(void)poiSearchNearby:(CLLocationCoordinate2D)location key:(NSString *)key{
	//初始化检索对象
	_poiSearcsher =[[BMKPoiSearch alloc]init];
	_poiSearcsher.delegate = self;
	BMKNearbySearchOption *citySearchOption = [[BMKNearbySearchOption alloc]init];
	citySearchOption.pageIndex = 0;
	citySearchOption.pageCapacity = 50;
	citySearchOption.location = location;
	citySearchOption.keyword = key;
	citySearchOption.radius = 3000;
	BOOL flag = [_poiSearcsher poiSearchNearBy:citySearchOption];
	if(flag)
	{
		NSLog(@"周边检索发送成功");
	}
	else
	{
		[self endRefrash];
	}
}

- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
	if (error == BMK_SEARCH_NO_ERROR) {
		self.userinfo = result.poiInfoList;
		[self initForm];
		[self endRefrash];

	} else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
		[self endRefrash];
	} else {
		[self endRefrash];
	}
}
@end
