//
//  WSMsgCell.h
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//
#import "RETableViewCell.h"
#import "RETableViewItem.h"
@interface OneTipLabItem : FMBaseItem
@property (nonatomic,copy) UIFont *textFont;
@property (nonatomic,assign) float width;
@property (nonatomic,assign) NSTextAlignment textAlignment;
@property (nonatomic,copy) UIColor *textColor;
@property (nonatomic,copy) NSArray *tipArray;

@property (nonatomic,copy) UIColor  *cellBgColor;
@end

@interface OneTipLabCell : FMBaseCell
@property (nonatomic,strong) OneTipLabItem *item;
@end
