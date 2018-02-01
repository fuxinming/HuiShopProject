//
//  ChangeNickViewController.h
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/4.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "FMFormViewController.h"

@interface ChangeNickViewController : FMFormViewController
@property (nonatomic,copy) void(^saveSuccess1)(NSString *name);
@end
