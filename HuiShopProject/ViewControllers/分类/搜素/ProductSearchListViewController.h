//
//  ProductSearchListViewController.h
//  HuiShopProject
//
//  Created by cx-fu on 2017/11/20.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "FMListView2Controller.h"

@interface ProductSearchListViewController : FMListView2Controller
@property (nonatomic, strong) NSMutableArray *myArr;
@property (nonatomic, copy) NSString *keyWord;
@property (nonatomic, copy) NSString *marketId;
@end
