//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface SignWeekDayItem : FMBaseItem
@property(assign,nonatomic)BOOL isSign;
@end

@interface SignWeekDayCell : FMBaseCell
@property (strong, readwrite, nonatomic) SignWeekDayItem *item;

@end
