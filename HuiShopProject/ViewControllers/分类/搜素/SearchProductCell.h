//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface SearchProductItem : FMBaseItem
@property (nonatomic,copy) NSArray *eventArr;
@end

@interface SearchProductCell : FMBaseCell
@property (strong, readwrite, nonatomic) SearchProductItem *item;

@end
