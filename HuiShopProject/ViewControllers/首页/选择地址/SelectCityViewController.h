//
//  ImportProductViewController.h
//  HuiShopProject
//
//  Created by cx-fu on 2017/11/23.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "FMFormViewController.h"

@interface SelectCityViewController : FMFormViewController
@property (nonatomic,strong)NSMutableArray *poiArray;
@property (nonatomic,copy)void (^selectAddress)(BMKPoiInfo *info);
@end
