//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface TitleSwitchItem : FMBaseItem
@property (nonatomic,copy) NSString *t1;
@property (nonatomic,copy) NSString *leftImage;
@property (nonatomic,assign)BOOL switchFlag;
@property (nonatomic,assign) BOOL haveLine;
@property (nonatomic,copy)void(^switchChange)(BOOL isOn,id);
@end

@interface TitleSwitchCell : FMBaseCell
@property (strong, readwrite, nonatomic) TitleSwitchItem *item;

@end
