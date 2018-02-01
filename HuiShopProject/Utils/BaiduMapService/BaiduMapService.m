//
//  BaiduMapService.m
//  SunnyCar
//
//  Created by q on 2017/9/21.
//  Copyright © 2017年 jienliang. All rights reserved.
//

#import "BaiduMapService.h"

@implementation BaiduMapService
static BaiduMapService *sharedSingleMap = nil;

+ (BaiduMapService *)sharedInstance {
    if (sharedSingleMap == nil) {
        sharedSingleMap = [[BaiduMapService alloc] init];
        
    }
    return sharedSingleMap;
}

-(void)starLocation{
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
}

-(void)starLocationComplete:(poiSuccess)block{
    self.poiBlock = block;
    _locService = [[BMKLocationService alloc]init];
    _locService.delegate = self;
    [_locService startUserLocationService];
}
-(void)stopLocation{
    [_locService stopUserLocationService];
    
    _locService.delegate = nil;
    _locService = nil;
}
//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    self.lat  = userLocation.location.coordinate.latitude;
    self.lon = userLocation.location.coordinate.longitude;
	self.pt = CLLocationCoordinate2DMake(self.lat, self.lon);
    [self reverseGeoCodeSearchLocationLat:self.lat lon:self.lon complete:nil];
}

-(void)geoCodeSearchAddress:(NSString *)city detail:(NSString *)detail  complete:(geoSeachCompletedBlock)block{
    self.geoBlock = block;
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    BMKGeoCodeSearchOption *geoCodeSearchOption = [[BMKGeoCodeSearchOption alloc]init];
    geoCodeSearchOption.city= city;
    geoCodeSearchOption.address = detail;
    BOOL flag = [_searcher geoCode:geoCodeSearchOption];
    if(flag)
    {
        NSLog(@"geo检索发送成功");
    }
    else
    {
        NSLog(@"geo检索发送失败");
    }
}

-(void)reverseGeoCodeSearchLocationLat:( CLLocationDegrees)lat lon:(CLLocationDegrees)lon complete:(reverseGeoCompletedBlock)block{
    self.reverseBlock = block;
    _searcher =[[BMKGeoCodeSearch alloc]init];
    _searcher.delegate = self;
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){lat, lon};
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
    BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_searcher reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
      NSLog(@"反geo检索发送成功");
    }
    else
    {
      NSLog(@"反geo检索发送失败");
    }
}
//实现Deleage处理回调结果
//接收正向编码结果

- (void)onGetGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        if (self.geoBlock) {
            self.geoBlock(result.location.latitude, result.location.longitude);
        }
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:
(BMKReverseGeoCodeResult *)result
errorCode:(BMKSearchErrorCode)error{
  if (error == BMK_SEARCH_NO_ERROR) {
      if (self.reverseBlock) {
          self.reverseBlock(result.addressDetail.province, result.addressDetail.city, result.address);
      }
      if (self.poiBlock) {
          self.poiBlock(result.poiList);
      }
  }
  else {
      NSLog(@"抱歉，未找到结果");
  }
}


-(void)suggestionSearcsh:(NSString *)detail complete:(suggestionSuccess)block{
    self.suggestionBlock = block;
    _suggestionSearcsher =[[BMKSuggestionSearch alloc]init];
    _suggestionSearcsher.delegate = self;
    BMKSuggestionSearchOption* option = [[BMKSuggestionSearchOption alloc] init];
    option.keyword  = detail;
    BOOL flag = [_suggestionSearcsher suggestionSearch:option];
    if(flag)
    {
        NSLog(@"建议检索发送成功");
    }
    else
    {
        NSLog(@"建议检索发送失败");
    }
}

//实现Delegate处理回调结果
- (void)onGetSuggestionResult:(BMKSuggestionSearch*)searcher result:(BMKSuggestionResult*)result errorCode:(BMKSearchErrorCode)error{
    if (error == BMK_SEARCH_NO_ERROR) {
        if (self.suggestionBlock) {
            self.suggestionBlock(result.cityList, result.keyList);
        }
    }
    else {
        NSLog(@"抱歉，未找到结果");
    }
}

-(void)poiSearchNearby:(CLLocationCoordinate2D)location key:(NSString *)key complete:(poiSuccess)block{
    //初始化检索对象
    self.poiBlock = block;
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
        NSLog(@"周边检索发送失败");
    }
}

-(void)poiSearch:(NSString *)city detail:(NSString *)detail complete:(poiSuccess)block{
    //初始化检索对象
    self.poiBlock = block;
    _poiSearcsher =[[BMKPoiSearch alloc]init];
    _poiSearcsher.delegate = self;
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = 0;
    citySearchOption.pageCapacity = 50;
    citySearchOption.city = city;
    citySearchOption.keyword = detail;
    BOOL flag = [_poiSearcsher poiSearchInCity:citySearchOption];
    if(flag)
    {
        NSLog(@"周边检索发送成功");
    }
    else
    {
        NSLog(@"周边检索发送失败");
    }
}

- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    if (error == BMK_SEARCH_NO_ERROR) {
        if (self.poiBlock) {
            self.poiBlock(result.poiInfoList);
        }
    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }
}
-(void)dealloc{
    [_locService stopUserLocationService];
    _locService.delegate = nil;
    _searcher.delegate = nil;
    _searcher = nil;
    _suggestionSearcsher.delegate = nil;
    _suggestionSearcsher = nil;
    _poiSearcsher.delegate = nil;
    _poiSearcsher = nil;
    
}

@end
