//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"
#import "FMBaseCell.h"
@interface EmptyDataItem : FMBaseItem
@property (nonatomic,copy) UIColor *bgColor;
@property (nonatomic,copy) NSString *tipStr;
@property (nonatomic,copy) NSString *imageStr;
@property (nonatomic,assign) CGRect iconRect;
@property (nonatomic,assign) int  type;
- (id)initWithHeight:(float)height andType:(int)type;
@end

@interface EmptyDataCell : FMBaseCell
@property (strong, readwrite, nonatomic) EmptyDataItem *item;

@end
