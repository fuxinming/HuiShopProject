//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface MidMenuItem : FMBaseItem
@property (nonatomic,copy) NSArray *titleArr;
@property (nonatomic,copy) NSArray *countArr;
@end

@interface MidMenuCell : FMBaseCell
@property (strong, readwrite, nonatomic) MidMenuItem *item;

@end
