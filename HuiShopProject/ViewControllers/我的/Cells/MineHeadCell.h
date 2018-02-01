//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface MineHeadItem : FMBaseItem
@property (nonatomic,copy) UIColor *bgColor;
@property (nonatomic,copy) NSString *imgText;
@property (nonatomic,copy) NSString *nameText;
@property (nonatomic,copy) NSString *phoneText;
@end

@interface MineHeadCell : FMBaseCell
@property (strong, readwrite, nonatomic) MineHeadItem *item;

@end
