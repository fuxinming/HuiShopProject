//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface PingLunItem : FMBaseItem
@property (nonatomic,copy)void (^buttonClick)(NSInteger tag,id);
@end

@interface PingLunCell : FMBaseCell
@property (strong, readwrite, nonatomic) PingLunItem *item;

@end
