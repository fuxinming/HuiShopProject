//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface AddressDetailInfoItem : FMBaseItem
@property (nonatomic, copy) NSString *str1;
@property (nonatomic, copy) NSString *str2;
@property (nonatomic,strong)BMKPoiInfo *info;
@end

@interface AddressDetailInfoCell : FMBaseCell
@property (strong, readwrite, nonatomic) AddressDetailInfoItem *item;

@end
