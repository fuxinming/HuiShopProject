//
//  WSMsgCell.m
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//

#import "SelectSexCell.h"


@implementation SelectSexItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 40;
		self.selIndex = 1;
    }
    return self;
}
@end

@interface SelectSexCell ()
{
	UIButton *selbtn1;
	UIButton *selbtn2;
	
}
@end
@implementation SelectSexCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
	
	selbtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
	[selbtn1 setTitle:@"先生" forState:UIControlStateNormal];
	[selbtn1 setTitleColor:COLOR_333 forState:UIControlStateNormal];
	selbtn1.titleLabel.font = Font_Size_14;
	[selbtn1 setImage:[UIImage imageNamed:@"unselectCicle"] forState:UIControlStateNormal];
	[selbtn1 setImage:[UIImage imageNamed:@"selectCircle"] forState:UIControlStateSelected];
	selbtn1.frame = CGRectMake(90, 0, 60, 40);
	selbtn1.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 40);
	[selbtn1 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	selbtn1.tag = 100;
	
	[self.contentView addSubview:selbtn1];
	
	
	selbtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
	[selbtn2 setTitle:@"女士" forState:UIControlStateNormal];
	[selbtn2 setTitleColor:COLOR_333 forState:UIControlStateNormal];
	selbtn2.titleLabel.font = Font_Size_14;
	[selbtn2 setImage:[UIImage imageNamed:@"unselectCicle"] forState:UIControlStateNormal];
	[selbtn2 setImage:[UIImage imageNamed:@"selectCircle"] forState:UIControlStateSelected];
	selbtn2.frame = CGRectMake(165, 0, 60, 40);
	selbtn2.imageEdgeInsets = UIEdgeInsetsMake(10, 0, 10, 40);
	[selbtn2 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	selbtn2.tag = 101;
	[self.contentView addSubview:selbtn2];
	
	
	UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,39.5, SCREEN_WIDTH, 0.5)];
	lineView.backgroundColor = [UIColor whiteColor];
	[self.contentView addSubview:lineView];
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
    WS(bself);
	if (self.item.selIndex == 1) {
		selbtn1.selected = YES;
		selbtn2.selected = NO;
	}
	if (self.item.selIndex == 2) {
		selbtn1.selected = NO;
		selbtn2.selected = YES;
	}
}

-(void)btnClick:(UIButton *)btn{
	if (btn.tag == 100) {
		selbtn1.selected = YES;
		selbtn2.selected = NO;
		self.item.selIndex = 1;
		
	}
	
	if (btn.tag == 101) {
		selbtn2.selected = YES;
		selbtn1.selected = NO;
		self.item.selIndex = 2;
	}
	
}
@end
