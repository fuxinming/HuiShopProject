//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface MyJinBiItem : FMBaseItem
@property (copy, nonatomic) NSString *jinbi;
@end

@interface MyJinBiCell : FMBaseCell
@property (strong, readwrite, nonatomic) MyJinBiItem *item;

@end
