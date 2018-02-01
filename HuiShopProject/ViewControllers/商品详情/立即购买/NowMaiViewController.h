//
//  NowMaiViewController.h
//  HuiShopProject
//
//  Created by cx-fu on 2017/12/21.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "FMKeyBoardFormViewController.h"

@interface NowMaiViewController : FMKeyBoardFormViewController
@property (nonatomic, copy) NSString *type;
@property (nonatomic, copy) NSString *productId;

@property(nonatomic,strong)NSMutableDictionary *orderInfoDict;
@property (nonatomic, assign) BOOL isFormCart;
@end
