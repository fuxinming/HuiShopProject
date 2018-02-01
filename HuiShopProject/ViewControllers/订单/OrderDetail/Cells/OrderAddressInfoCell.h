//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface OrderAddressInfoItem : FMBaseItem

@end

@interface OrderAddressInfoCell : FMBaseCell
@property (strong, readwrite, nonatomic) OrderAddressInfoItem *item;

@end
