//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface JinbiRowItem : FMBaseItem
@property (copy, nonatomic) NSString *jinbi;
@property (copy, nonatomic) NSString *time;
@end

@interface JinbiRowCell : FMBaseCell
@property (strong, readwrite, nonatomic) JinbiRowItem *item;

@end
