//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface ProductInfoItem : FMBaseItem
@property (nonatomic,copy) NSArray *eventArr;
@end

@interface ProductInfoCell : FMBaseCell
@property (strong, readwrite, nonatomic) ProductInfoItem *item;

@end
