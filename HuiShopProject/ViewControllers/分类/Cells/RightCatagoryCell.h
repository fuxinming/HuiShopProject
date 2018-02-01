//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface RightCatagoryItem : FMBaseItem
@property (nonatomic,copy) NSArray *eventArr;
@property (nonatomic,copy) NSString *typeName;
@end

@interface RightCatagoryCell : FMBaseCell
@property (strong, readwrite, nonatomic) RightCatagoryItem *item;

@end
