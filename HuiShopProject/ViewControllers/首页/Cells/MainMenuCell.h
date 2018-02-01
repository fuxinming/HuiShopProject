//
//  WSMsgCell.h
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//
#import "RETableViewCell.h"
#import "RETableViewItem.h"
@interface MainMenuItem : FMBaseItem

@end

@interface MainMenuCell : FMBaseCell
@property (nonatomic,strong) MainMenuItem *item;
@end
