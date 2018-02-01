//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface RecordeInfoItem : FMBaseItem

@end

@interface RecordeInfoCell : FMBaseCell
@property (strong, readwrite, nonatomic) RecordeInfoItem *item;

@end
