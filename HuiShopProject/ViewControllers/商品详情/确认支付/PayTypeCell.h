//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface PayTypeItem : FMBaseItem
@property (nonatomic,assign) int payType;
@end

@interface PayTypeCell : FMBaseCell
@property (strong, readwrite, nonatomic) PayTypeItem *item;

@end
