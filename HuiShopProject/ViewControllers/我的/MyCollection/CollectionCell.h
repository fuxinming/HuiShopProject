//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface CollectionItem : FMBaseItem
@end

@interface CollectionCell : FMBaseCell
@property (strong, readwrite, nonatomic) CollectionItem *item;

@end
