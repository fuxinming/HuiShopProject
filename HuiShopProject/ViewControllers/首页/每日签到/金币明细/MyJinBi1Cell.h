//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface MyJinBi1Item : FMBaseItem
@property (copy, nonatomic) NSString *jinbi;
@end

@interface MyJinBi1Cell : FMBaseCell
@property (strong, readwrite, nonatomic) MyJinBi1Item *item;

@end
