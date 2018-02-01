//
//  TestViewController.h
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/20.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "FMFormViewController.h"

@interface TestViewController : FMFormViewController
@property (nonatomic, strong) NSMutableArray *myArr;
@property (nonatomic, copy) NSString *str1;
@property (nonatomic, assign) int  flag;
@property (nonatomic, assign) BOOL  isHave;

@property (nonatomic, copy) dispatch_block_t saveSuccess;
@property (nonatomic, copy) void (^myblock) (NSString *str1);
@end
