//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "AddressDetailInfoCell.h"

@implementation AddressDetailInfoItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 40;

    }
    return self;
}

@end

@interface AddressDetailInfoCell()
{
 
}
@end

@implementation AddressDetailInfoCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
	[self.contentView removeAllSubviews];
    
    UILabel*lab1 = [self createLabel:StrRelay(self.item.str1) color:COLOR_333 font:Font_Size_14];
    lab1.frame = CGRectMake(15, 0, SCREEN_WIDTH -  30, 24);
    [self.contentView addSubview:lab1];

	UILabel* lab2 = [self createLabel:StrRelay(self.item.str2) color:COLOR_999 font:Font_Size_12];
    lab2.frame = CGRectMake(15, 24, SCREEN_WIDTH -  30, 16);
    [self.contentView addSubview:lab2];
    
	UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,39.5, SCREEN_WIDTH, 0.5)];
	lineView.backgroundColor = COLOR_ddd;
	[self.contentView addSubview:lineView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
