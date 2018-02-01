//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface FMEmptyItem : RETableViewItem
@property (nonatomic,copy) UIColor *bgColor;
@property (nonatomic,assign) BOOL hasLine;
- (id)initWithHeight:(float)height;
@end

@interface FMEmptyCell : RETableViewCell
@property (strong, readwrite, nonatomic) FMEmptyItem *item;

@end
