//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface JinKouItem : FMBaseItem
@property (nonatomic,copy) NSArray *eventArr;
@property (nonatomic,copy) void (^selectProduct)(id info);
@end

@interface JinKouCell : FMBaseCell
@property (strong, readwrite, nonatomic) JinKouItem *item;

@end
