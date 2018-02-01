//
//  CXMatchContentView.h
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/7.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "FMFormView.h"

@interface VouchersContentView : FMFormView
- (id)initWithFrame:(CGRect)frame withUserInfo:(id)myInfo andDealtSel:(NSDictionary *)selInfo andLimit:(double)price;
@property (copy, readwrite, nonatomic) void (^btnSelect)(id item);
@property (copy, readwrite, nonatomic)	NSDictionary *selectInfo;
@property (assign, readwrite, nonatomic)	double price;
@end
