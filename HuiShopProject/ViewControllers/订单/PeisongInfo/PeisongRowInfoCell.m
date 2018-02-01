//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "PeisongRowInfoCell.h"

@implementation PeisongRowInfoItem
- (id)init{
    if (self = [super init]) {
		self.cellHeight = 76;
		self.isLast = NO;
    }
    return self;
}

@end

@interface PeisongRowInfoCell()
{
	
}
@end

@implementation PeisongRowInfoCell
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
	
	UIView *cirView = [[UIView alloc]initWithFrame:CGRectMake(15,8 + 5, 6, 6)];
	cirView.backgroundColor = COLOR_999;
	if (self.item.isLast) {
		cirView.backgroundColor = COLOR_RED_;
	}
	View_Border_Radius(cirView, 3, 0, COLOR_999);
	[self.contentView addSubview:cirView];
	
	UIView *shuView = [[UIView alloc]initWithFrame:CGRectMake(15+1.5,28 , 3, 45)];
	shuView.backgroundColor = COLOR_999;
	[self.contentView addSubview:shuView];
	
	UILabel *lab1;
	UILabel *lab2;
	lab1 = [self createLabel:StrRelay(self.item.t1) color:COLOR_999 font:Font_Size_13];
	lab1.frame = CGRectMake(36, 8, SCREEN_WIDTH - 40, 200);
	lab1.numberOfLines = 0;
	[lab1 sizeToFit];
	lab1.frame = CGRectMake(36, 8, SCREEN_WIDTH - 40, lab1.height);
	lab1.textAlignment = NSTextAlignmentLeft;
	[self.contentView addSubview:lab1];
	
	lab2 = [self createLabel:StrRelay(self.item.t2) color:COLOR_999 font:Font_Size_13];
	lab2.frame = CGRectMake(36, lab1.bottom + 6, SCREEN_WIDTH - 40, 20);
	[self.contentView addSubview:lab2];
	
	if (self.item.isLast) {
		lab1.textColor  = COLOR_333;
		lab2.textColor  = COLOR_333;
	}
	
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
