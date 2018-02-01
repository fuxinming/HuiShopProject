//
//  MapViewController.h
//  HuiShopProject
//
//  Created by 付新明 on 2017/12/31.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "BaseViewController.h"
#import "FMActMenu.h"
#import "FMScrollContentView.h"
#import "BaiduMapService.h"
@interface MapViewController : BaseViewController
@property (nonatomic, strong) RETableViewManager *formManager;  //表单管理器
@property (nonatomic, strong) UITableView *formTable;      
@property (nonatomic,copy) NSString *city;
@property (nonatomic,assign) int curIndex;
@property (nonatomic,strong) FMActMenu *mMenuHriZontal;
@property (nonatomic,strong) FMScrollContentView *mScrollPageView;
@property (nonatomic,copy)void (^selectAddress)(BMKPoiInfo *info);
@end
