//
//  BaiduMapService.h
//  SunnyCar
//
//  Created by q on 2017/9/21.
//  Copyright © 2017年 jienliang. All rights reserved.
//

#import <Foundation/Foundation.h>
 #import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

typedef void(^geoSeachCompletedBlock)(CLLocationDegrees lat,CLLocationDegrees lon);
typedef void(^reverseGeoCompletedBlock)(NSString *province,NSString *city,NSString *address);
typedef void(^suggestionSuccess)(NSArray *cityArray,NSArray *keyArray);
typedef void(^poiSuccess)(NSArray *poiInfoArray);
@interface BaiduMapService : NSObject<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate,BMKSuggestionSearchDelegate,BMKPoiSearchDelegate>
@property (nonatomic,strong)BMKLocationService *locService;
@property (nonatomic,strong) BMKGeoCodeSearch *searcher;
@property (nonatomic,strong) BMKSuggestionSearch *suggestionSearcsher;
@property (nonatomic,strong) BMKPoiSearch *poiSearcsher;

@property (nonatomic,assign)CLLocationDegrees lat;
@property (nonatomic,assign)CLLocationDegrees lon;
@property (nonatomic,copy)NSString * currentAddress;
@property (nonatomic,assign)CLLocationCoordinate2D pt;

@property (nonatomic,copy)geoSeachCompletedBlock geoBlock;
@property (nonatomic,copy)reverseGeoCompletedBlock reverseBlock;
@property (nonatomic,copy)suggestionSuccess suggestionBlock;
@property (nonatomic,copy)poiSuccess poiBlock;
+ (BaiduMapService *)sharedInstance;

-(void)starLocation;
-(void)stopLocation;
//正向地理编码 地址转坐标
-(void)geoCodeSearchAddress:(NSString *)city detail:(NSString *)detail complete:(geoSeachCompletedBlock)block;
-(void)reverseGeoCodeSearchLocationLat:( CLLocationDegrees)lat lon:(CLLocationDegrees)lon complete:(reverseGeoCompletedBlock)block;

-(void)suggestionSearcsh:(NSString *)detail complete:(suggestionSuccess)block;

-(void)poiSearch:(NSString *)city detail:(NSString *)detail complete:(poiSuccess)block;
-(void)poiSearchNearby:(CLLocationCoordinate2D)location key:(NSString *)key complete:(poiSuccess)block;

-(void)starLocationComplete:(poiSuccess)block;
@end
