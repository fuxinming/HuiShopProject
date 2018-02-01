//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface TicketInfoItem : FMBaseItem
@property (nonatomic,copy) NSString *t1;
@property (nonatomic,copy) NSMutableAttributedString *t2;
@property (nonatomic,copy) NSString *rightImage;
@property (nonatomic,assign) BOOL haveLine;
@end

@interface TicketInfoCell : FMBaseCell
@property (strong, readwrite, nonatomic) TicketInfoItem *item;

@end
