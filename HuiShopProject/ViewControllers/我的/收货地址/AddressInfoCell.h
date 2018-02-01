//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface AddressInfoItem : FMBaseItem
@property (nonatomic,copy)void (^btnClick)(NSInteger tag,id item);
@end

@interface AddressInfoCell : FMBaseCell
@property (strong, readwrite, nonatomic) AddressInfoItem *item;

@end
