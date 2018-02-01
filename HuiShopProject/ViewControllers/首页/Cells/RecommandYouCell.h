//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface RecommandYouItem : FMBaseItem
@property (nonatomic,copy) NSArray *eventArr;
@property (nonatomic,copy) void (^selectProduct)(id info);
@end

@interface RecommandYouCell : FMBaseCell
@property (strong, readwrite, nonatomic) RecommandYouItem *item;

@end
