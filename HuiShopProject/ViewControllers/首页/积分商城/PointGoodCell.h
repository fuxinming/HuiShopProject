//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface PointGoodItem : FMBaseItem
@property (nonatomic,copy) NSArray *eventArr;
@property (nonatomic,copy) void (^mybtnClick)(id item);
@end

@interface PointGoodCell : FMBaseCell
@property (strong, readwrite, nonatomic) PointGoodItem *item;

@end
