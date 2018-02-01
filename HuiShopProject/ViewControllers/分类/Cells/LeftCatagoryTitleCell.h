//
//  WSMsgCell.h
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//
#import "RETableViewCell.h"
#import "RETableViewItem.h"
@interface LeftCatagoryTitleItem : FMBaseItem
@property (nonatomic,copy) NSString *titleText;
@property (nonatomic,assign) int tag;
@end

@interface LeftCatagoryTitleCell : FMBaseCell
@property (nonatomic,strong) LeftCatagoryTitleItem *item;
@end
