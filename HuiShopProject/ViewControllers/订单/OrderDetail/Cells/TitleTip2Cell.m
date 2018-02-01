//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "TitleTip2Cell.h"

@implementation TitleTip2Item
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 40;

        self.t1Font = Font_Size_14;
		self.t2Font = Font_Size_13;
		self.backColor = [UIColor whiteColor];
		self.t1Color = COLOR_333;
		self.t2Color = COLOR_999;
    }
    return self;
}

@end

@interface TitleTip2Cell()
{
    UILabel *lab1;
    UILabel *lab2;
}
@end

@implementation TitleTip2Cell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    lab1 = [self createLabel:@"" color:COLOR_333 font:Font_Size_15];
    lab1.frame = CGRectMake(0, 14, SCREEN_WIDTH/2, 18);
    lab1.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:lab1];
    
    lab2 = [self createLabel:@"" color:COLOR_999 font:Font_Size_14];
    lab2.frame = CGRectMake(0, lab1.bottom + 6, SCREEN_WIDTH/2, 15);
    lab2.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:lab2];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
	self.contentView.backgroundColor = self.item.backColor;
	lab1.textColor = self.item.t1Color;
    lab1.text = StrRelay(self.item.t1);
    lab1.font = self.item.t1Font;
    [lab1 sizeToFit];
	lab1.frame = CGRectMake(15, 0, lab1.width, self.item.cellHeight);
	
	lab2.textColor = self.item.t2Color;
	lab2.text = StrRelay(self.item.t2);
	lab2.font = self.item.t2Font;
	[lab2 sizeToFit];
	lab2.frame = CGRectMake(SCREEN_WIDTH - lab2.width - 15, 0, lab2.width, self.item.cellHeight);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
