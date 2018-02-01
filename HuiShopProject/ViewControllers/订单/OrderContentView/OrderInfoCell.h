//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface OrderInfoItem : FMBaseItem
@property (nonatomic,copy)void (^btnClick)(NSInteger tag,id item);
@end

@interface OrderInfoCell : FMBaseCell
@property (strong, readwrite, nonatomic) OrderInfoItem *item;

@end
