//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface HotProductItem : FMBaseItem
@property (nonatomic,copy) NSArray *eventArr;
@property (nonatomic,copy) void (^selectProduct)(id info);
@end

@interface HotProductCell : FMBaseCell
@property (strong, readwrite, nonatomic) HotProductItem *item;

@end
