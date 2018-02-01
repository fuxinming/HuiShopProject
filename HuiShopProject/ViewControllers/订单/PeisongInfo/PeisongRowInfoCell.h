//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface PeisongRowInfoItem : FMBaseItem
@property (nonatomic,assign)BOOL isLast;
@property (nonatomic,copy) NSString *t1;
@property (nonatomic,copy) NSString *t2;

@end

@interface PeisongRowInfoCell : FMBaseCell
@property (strong, readwrite, nonatomic) PeisongRowInfoItem *item;

@end
