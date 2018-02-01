//
//  WSMsgCell.m
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//

#import "SelectPingjiaLevelCell.h"


@implementation SelectPingjiaLevelItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 40;
		self.selIndex = 0;
		self.def = -1;
    }
    return self;
}
@end

@interface SelectPingjiaLevelCell ()
{
	UIButton *selbtn1;
	UIButton *selbtn2;
	UIButton *selbtn3;
}
@end
@implementation SelectPingjiaLevelCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
	
	UILabel *tLabel = [self createLabel:@"评价" color:COLOR_333 font:Font_Size_14];
	tLabel.frame = CGRectMake(15, 0, 40, 40);
	[self.contentView addSubview:tLabel];
	
	float w = (SCREEN_WIDTH - 80)/3;
	
	selbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
	[selbtn1 setTitle:@"好评" forState:UIControlStateNormal];
	[selbtn1 setTitleColor:COLOR_999 forState:UIControlStateNormal];
	selbtn1.titleLabel.font = Font_Size_14;
	[selbtn1 setImage:[UIImage imageNamed:@"default_evaluation"] forState:UIControlStateNormal];
	[selbtn1 setImage:[UIImage imageNamed:@"good_evaluation"] forState:UIControlStateSelected];
	selbtn1.frame = CGRectMake(70, 0, w, 40);
//	selbtn1.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 40);
	[selbtn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	selbtn1.tag = 100;
	[self.contentView addSubview:selbtn1];
	
	
	selbtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
	[selbtn2 setTitle:@"中评" forState:UIControlStateNormal];
	[selbtn2 setTitleColor:COLOR_999 forState:UIControlStateNormal];
	selbtn2.titleLabel.font = Font_Size_14;
	[selbtn2 setImage:[UIImage imageNamed:@"default_evaluation"] forState:UIControlStateNormal];
	[selbtn2 setImage:[UIImage imageNamed:@"middle_evaluation"] forState:UIControlStateSelected];
	selbtn2.frame = CGRectMake(70+w, 0, w, 40);
//	selbtn2.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 40);
	[selbtn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	selbtn2.tag = 101;
	[self.contentView addSubview:selbtn2];
	
	
	selbtn3 = [UIButton buttonWithType:UIButtonTypeCustom];
	[selbtn3 setTitle:@"差评" forState:UIControlStateNormal];
	[selbtn3 setTitleColor:COLOR_999 forState:UIControlStateNormal];
	selbtn3.titleLabel.font = Font_Size_14;
	[selbtn3 setImage:[UIImage imageNamed:@"default_evaluation"] forState:UIControlStateNormal];
	[selbtn3 setImage:[UIImage imageNamed:@"bad_evaluation"] forState:UIControlStateSelected];
	selbtn3.frame = CGRectMake(70+2*w, 0, w, 40);
//	selbtn3.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 40);
	[selbtn3 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	selbtn3.tag = 102;
	[self.contentView addSubview:selbtn3];
	
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}
- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
	if (self.item.def == 0) {
		selbtn1.selected = YES;
		selbtn2.selected = NO;
		selbtn3.selected = NO;
	}
	
	if (self.item.def == 1) {
		selbtn1.selected = NO;
		selbtn2.selected = YES;
		selbtn3.selected = NO;
	}
	if (self.item.def == 2) {
		selbtn1.selected = NO;
		selbtn2.selected = NO;
		selbtn3.selected = YES;
	}
}

-(void)btnClick:(UIButton *)btn{
	if (btn.tag == 100) {
		selbtn1.selected = YES;
		selbtn2.selected = NO;
		selbtn3.selected = NO;
		if (self.item.evalListArray.count > 0) {
			self.item.selIndex = StrRelay(self.item.evalListArray[0][@"settingsValue"]);
		}
		self.item.def = 0;
		
	}
	
	if (btn.tag == 101) {
		selbtn2.selected = YES;
		selbtn1.selected = NO;
		selbtn3.selected = NO;
		if (self.item.evalListArray.count > 1) {
			self.item.selIndex = StrRelay(self.item.evalListArray[1][@"settingsValue"]);
		}
		self.item.def = 1;
	}
	if (btn.tag == 102) {
		selbtn3.selected = YES;
		selbtn2.selected = NO;
		selbtn1.selected = NO;
		if (self.item.evalListArray.count > 2) {
			self.item.selIndex = StrRelay(self.item.evalListArray[2][@"settingsValue"]);
		}
		self.item.def = 2;
	}
	
}
@end
