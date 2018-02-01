//
//  AllEvalViewController.h
//  HuiShopProject
//
//  Created by cx-fu on 2018/1/11.
//  Copyright © 2018年 付新明. All rights reserved.
//

#import "FMListViewController.h"

@interface AllEvalViewController : FMListViewController
@property (nonatomic, copy) NSString *type;
@property (nonatomic, strong) NSMutableArray *tagArr;
@property (nonatomic, strong) NSMutableArray *pingLunArr;
@property (nonatomic, strong) NSMutableArray *levelList;
@end
