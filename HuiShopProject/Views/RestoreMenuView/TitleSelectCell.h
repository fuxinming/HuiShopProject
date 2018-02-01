//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface TitleSelectItem : FMBaseItem
@property (nonatomic,copy) NSString *t1;

@property (nonatomic,copy) NSString *leftImage;
@property (nonatomic,copy) NSString *leftSelectImage;
@property (nonatomic,assign) BOOL haveLine;
@end

@interface TitleSelectCell : FMBaseCell
@property (strong, readwrite, nonatomic) TitleSelectItem *item;

@end
