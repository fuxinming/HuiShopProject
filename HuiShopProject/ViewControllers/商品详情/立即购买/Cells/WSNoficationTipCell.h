//
//  WSXuKeTextCell.h
//  OMengMerchant
//
//  Created by jienliang on 16/3/9.
//  Copyright © 2016年 shanjin. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"
typedef void(^swichValueChangeBlock)(BOOL isOn);

@interface WSNoficationTipItem : RETableViewItem
@property (nonatomic, copy) NSString *titleText;
@property (nonatomic, copy) NSString *subTitleText;
@property (nonatomic, assign) BOOL isOn;
@property (nonatomic, assign) BOOL hasLine;
@property (nonatomic, assign) BOOL hasTopLine;

@property (nonatomic,copy)swichValueChangeBlock swichBlock;

@end


@interface WSNoficationTipCell : RETableViewCell
@property (strong, nonatomic) WSNoficationTipItem *item;
@property (strong, readwrite, nonatomic) UIImageView *imgLineDown;
@end
