//
//  CXMatchContentView.h
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/7.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "FMFormView.h"
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
@interface AddressContentView : FMFormView<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKSuggestionSearchDelegate,BMKPoiSearchDelegate>
@property(nonatomic,copy)NSString *key;
@property (nonatomic,assign)CLLocationCoordinate2D pt;
@property (nonatomic,copy)void (^selectAddress)(BMKPoiInfo *info);
@property (nonatomic,strong) BMKPoiSearch *poiSearcsher;
- (id)initWithFrame:(CGRect)frame andKey:(NSString *)key andPt:(CLLocationCoordinate2D)pt;
@end
