//
//  ConsigneeAddressViewController.h
//  HuiShopProject
//
//  Created by cx-fu on 2017/12/18.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "FMFormViewController.h"

@interface ConsigneeAddressViewController : FMFormViewController
@property (nonatomic , copy)void (^saveSuc)(id info);
@end
