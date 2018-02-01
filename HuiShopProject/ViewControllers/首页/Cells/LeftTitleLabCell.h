//
//  WSMsgCell.h
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//
#import "RETableViewCell.h"
#import "RETableViewItem.h"
@interface LeftTitleLabItem : FMBaseItem
@property (nonatomic,copy) NSString *titleText;
@property (nonatomic,copy) UIColor  *textColor;
@end

@interface LeftTitleLabCell : FMBaseCell
@property (nonatomic,strong) LeftTitleLabItem *item;
@end
