//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface PeisongHeadItem : FMBaseItem
@property (nonatomic,copy) NSString *t1;
@property (nonatomic,copy) NSString *t2;

@property (nonatomic,copy) UIFont *t1Font;
@property (nonatomic,copy) UIFont *t2Font;
@property (nonatomic,copy) UIColor *backColor;
@property (nonatomic,copy) UIColor *t1Color;
@property (nonatomic,copy) UIColor *t2Color;

@end

@interface PeisongHeadCell : FMBaseCell
@property (strong, readwrite, nonatomic) PeisongHeadItem *item;

@end
