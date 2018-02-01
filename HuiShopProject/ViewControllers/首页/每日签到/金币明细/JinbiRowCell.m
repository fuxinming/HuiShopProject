//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "JinbiRowCell.h"

@implementation JinbiRowItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 90;
    }
    return self;
}

@end

@interface JinbiRowCell()
{
}
@end

@implementation JinbiRowCell
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
	
	UIView *v1 = [[UIView alloc]initWithFrame:CGRectMake(15,15, 7, 7)];
	v1.backgroundColor = COLOR_ddd;
	View_Border_Radius(v1, 3.5, 0, Color_Clear);
	[self.contentView addSubview:v1];
	
	UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(18,v1.bottom + 10, 1, 50)];
	lineView1.backgroundColor = COLOR_ddd;
	[self.contentView addSubview:lineView1];
	
	UILabel *titleLabel = [self createLabel:self.item.jinbi color:COLOR_333 font:Font_Size_16];
	titleLabel.frame = CGRectMake(lineView1.right + 14, v1.bottom , 200, 20);
	[self.contentView addSubview:titleLabel];
	
	UILabel *t1Label = [self createLabel:@"连续签到奖励（App端）" color:COLOR_999 font:Font_Size_13];
	t1Label.frame = CGRectMake(lineView1.right + 14,titleLabel.bottom, SCREEN_WIDTH,18);
	[self.contentView addSubview:t1Label];

	UILabel *t2Label = [self createLabel:self.item.time color:COLOR_999 font:Font_Size_13];
	t2Label.frame = CGRectMake(lineView1.right + 14,t1Label.bottom, SCREEN_WIDTH,18);
	[self.contentView addSubview:t2Label];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
