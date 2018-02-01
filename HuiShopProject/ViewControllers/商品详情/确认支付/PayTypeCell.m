//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "PayTypeCell.h"

@implementation PayTypeItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 110;
		self.payType = 1;
    }
    return self;
}

@end

@interface PayTypeCell()
{
}
@end

@implementation PayTypeCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
	
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
    [self.contentView removeAllSubviews];
	self.contentView.backgroundColor = [UIColor whiteColor];
    UIImageView *icon1 = [[UIImageView alloc]init];
	icon1.image = [UIImage imageNamed:@"selectCircle"];
    icon1.frame = CGRectMake(15, 20, 15, 15);
	icon1.tag = 200;
    [self.contentView addSubview:icon1];
	
	UIImageView *image1 = [[UIImageView alloc]init];
	image1.image = [UIImage imageNamed:@"zhifubaozhifu"];
	image1.frame = CGRectMake(55, 11, 33, 33);
	[self.contentView addSubview:image1];
    
    UILabel *lab1 = [self createLabel:@"支付宝支付" color:COLOR_333 font:Font_Size_15];
    [lab1 sizeToFit];
    lab1.frame = CGRectMake(image1.right + 10, image1.top, lab1.width, 16);
    [self.contentView addSubview:lab1];
	
	UILabel *lab2 = [self createLabel:@"大家都在用的支付" color:COLOR_999 font:Font_Size_12];
	[lab2 sizeToFit];
	lab2.frame = CGRectMake(image1.right + 10, lab1.bottom + 3, lab2.width, 16);
	[self.contentView addSubview:lab2];
	
	UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0,55, SCREEN_WIDTH, 0.5)];
	lineView1.backgroundColor = COLOR_ddd;
	[self.contentView addSubview:lineView1];
	
	UIButton *btn1 = [self createImgBtn:@"" tag:100];
	btn1.frame =  CGRectMake(0, 0, SCREEN_WIDTH, 55);
	[self.contentView addSubview:btn1];
	
	
	
	UIImageView *icon2 = [[UIImageView alloc]init];
	icon2.image = [UIImage imageNamed:@"unselectCicle"];
	icon2.frame = CGRectMake(15, 20 + 55, 15, 15);
	icon2.tag = 300;
	[self.contentView addSubview:icon2];
	
	UIImageView *image2 = [[UIImageView alloc]init];
	image2.image = [UIImage imageNamed:@"weixinzhifu"];
	image2.frame = CGRectMake(55, 11 + 55, 33+3, 33);
	[self.contentView addSubview:image2];
	
	UILabel *lab11 = [self createLabel:@"微信支付" color:COLOR_333 font:Font_Size_15];
	[lab11 sizeToFit];
	lab11.frame = CGRectMake(image2.right + 10, image2.top, lab11.width, 16);
	[self.contentView addSubview:lab11];
	
	UILabel *lab22 = [self createLabel:@"微信安全支付" color:COLOR_999 font:Font_Size_12];
	[lab22 sizeToFit];
	lab22.frame = CGRectMake(image2.right + 10, lab11.bottom + 3, lab22.width, 16);
	[self.contentView addSubview:lab22];
	
	UIButton *btn2 = [self createImgBtn:@"" tag:101];
	btn2.frame =  CGRectMake(0, 55, SCREEN_WIDTH, 55);
	[self.contentView addSubview:btn2];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(void)btnClick:(UIButton *)btn{
	if (btn.tag == 100) {
		UIImageView *icon1 = [self.contentView viewWithTag:200];
		icon1.image = [UIImage imageNamed:@"selectCircle"];
		UIImageView *icon2 = [self.contentView viewWithTag:300];
		icon2.image = [UIImage imageNamed:@"unselectCicle"];
		self.item.payType = 1;
	}
	
	if (btn.tag == 101) {
		UIImageView *icon1 = [self.contentView viewWithTag:200];
		icon1.image = [UIImage imageNamed:@"unselectCicle"];
		UIImageView *icon2 = [self.contentView viewWithTag:300];
		icon2.image = [UIImage imageNamed:@"selectCircle"];
		self.item.payType = 2;
	}
}
@end
