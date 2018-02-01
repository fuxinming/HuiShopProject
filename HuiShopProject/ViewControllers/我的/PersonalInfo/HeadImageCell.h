//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface HeadImageItem : FMBaseItem
@property (nonatomic,copy) NSString *imgText;
@end

@interface HeadImageCell : FMBaseCell
@property (strong, readwrite, nonatomic) HeadImageItem *item;

@end
