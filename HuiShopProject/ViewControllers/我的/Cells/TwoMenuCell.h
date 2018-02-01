//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface TwoMenuItem : FMBaseItem
@property (nonatomic,copy) NSString *t1;
@property (nonatomic,copy) NSString *t2;
@property (nonatomic,copy) NSString *t3;
@property (nonatomic,copy) NSString *t4;
@end

@interface TwoMenuCell : FMBaseCell
@property (strong, readwrite, nonatomic) TwoMenuItem *item;

@end
