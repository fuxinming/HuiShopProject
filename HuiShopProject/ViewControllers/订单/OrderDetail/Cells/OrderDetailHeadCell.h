//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface OrderDetailHeadItem : FMBaseItem

@end

@interface OrderDetailHeadCell : FMBaseCell
@property (strong, readwrite, nonatomic) OrderDetailHeadItem *item;

@end
