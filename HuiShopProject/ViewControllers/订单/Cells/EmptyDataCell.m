//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "EmptyDataCell.h"

@implementation EmptyDataItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 80;
        self.bgColor = [UIColor clearColor];
    }
    return self;
}

- (id)initWithHeight:(float)height andType:(int)type{
    if (self = [super init]) {
		if (type == 1) {//无数据
			self.tipStr = @"暂无数据,您可以进行其他操作";
			self.imageStr = @"huiqitian";
			self.iconRect = CGRectMake((SCREEN_WIDTH - 209)/2, 40, 209, 44);
		}else{//网络错误
			self.tipStr = @"网络错误";
			self.imageStr = @"noNetworkIcon";
			self.iconRect = CGRectMake((SCREEN_WIDTH - 70)/2, 40, 70, 70);
		}
        self.cellHeight = height;
        self.bgColor = [UIColor clearColor];
    }
    return self;
}

@end

@interface EmptyDataCell()
{
    UILabel *tLab;
    UIImageView *icon;
}
@end

@implementation EmptyDataCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    icon = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 96)/2, 80, 96, 77)];
    [self.contentView addSubview:icon];
    
    tLab = [self createLabel:@"暂无数据" color:COLOR_999 font:Font_Size_14];
    tLab.textAlignment = NSTextAlignmentCenter;
    tLab.frame = CGRectMake(0, icon.bottom +25, SCREEN_WIDTH, 22);
    [self.contentView addSubview:tLab];
    
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
    icon.image = [UIImage imageNamed:self.item.imageStr];
	icon.frame  = self.item.iconRect;
    tLab.text = self.item.tipStr;
	tLab.top = icon.bottom +25;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.contentView.backgroundColor = self.item.bgColor;
}

@end
