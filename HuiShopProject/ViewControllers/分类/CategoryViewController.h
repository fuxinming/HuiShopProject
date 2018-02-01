//
//  CategoryViewController.h
//  HuiShopProject
//
//  Created by 付新明 on 2017/11/2.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMFormViewController.h"
@interface CategoryViewController : FMFormViewController
@property (nonatomic, strong) RETableViewManager *formManager1;  //表单管理器
@property (nonatomic, strong) UITableView *formTable1;           //表单表格
@end
