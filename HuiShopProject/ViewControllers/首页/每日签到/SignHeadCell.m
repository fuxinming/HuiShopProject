//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "SignHeadCell.h"

@implementation SignHeadItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 226;
    }
    return self;
}

@end

@interface SignHeadCell()
{
}
@end

@implementation SignHeadCell
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
	
	UIImageView *bgImage = [[UIImageView alloc]init];
	bgImage.image = [UIImage imageNamed:@"bkg_sign_in"];
	bgImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, 226);
	[self.contentView addSubview:bgImage];
	
	
	UIButton *signBtn = [self createImgBtn:@"bkg_dao" tag:100];
	signBtn.frame = CGRectMake((SCREEN_WIDTH - 90)/2, 30, 90, 90);
	[signBtn setTitle:@"签到" forState:UIControlStateNormal];
	[signBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[signBtn.titleLabel setFont:Font_Size_24];
	[self.contentView addSubview:signBtn];
	
	
    
    UILabel *titleLabel = [self createLabel:@"今日签到可领金币" color:COLOR_333 font:Font_Size_16];
    titleLabel.frame = CGRectMake(0, signBtn.bottom + 20, SCREEN_WIDTH, 22);
	titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    
    UILabel *t1Label = [self createLabel:@"连续签到有更多惊喜" color:COLOR_333 font:Font_Size_14];
	[t1Label sizeToFit];
    t1Label.frame = CGRectMake((SCREEN_WIDTH - t1Label.width)/2,titleLabel.bottom + 15, t1Label.width, 22);
    [self.contentView addSubview:t1Label];
	
	UIImageView *icon1 = [[UIImageView alloc]init];
	icon1.image = [UIImage imageNamed:@"bkg_sign_in_one"];
	icon1.frame = CGRectMake(15, 30, 13, 13);
	[self.contentView addSubview:icon1];
	[self animation:icon1 withF1:CGRectMake(15, 30, 13, 13) andF2:CGRectMake(signBtn.left - 13 - 10, 45, 13, 13)];
	
	UIImageView *icon2 = [[UIImageView alloc]init];
	icon2.image = [UIImage imageNamed:@"bkg_sign_in_two"];
	icon2.frame = CGRectMake(signBtn.left - 13 - 15, 110, 13, 13);
	[self.contentView addSubview:icon2];
	[self animation:icon2 withF1:CGRectMake(signBtn.left - 13 - 15, 110, 13, 13) andF2:CGRectMake(20, 130, 13, 13)];
	
	
	UIImageView *icon3 = [[UIImageView alloc]init];
	icon3.image = [UIImage imageNamed:@"bkg_sign_in_three"];
	icon3.frame = CGRectMake(signBtn.right + 5, 70, 13, 13);
	[self.contentView addSubview:icon3];
	[self animation:icon3 withF1:CGRectMake(signBtn.right + 5, 70, 13, 13) andF2:CGRectMake(SCREEN_WIDTH - 40, 20, 13, 13)];
	
	UIImageView *icon4 = [[UIImageView alloc]init];
	icon4.image = [UIImage imageNamed:@"bkg_sign_in_four"];
	icon4.frame = CGRectMake(signBtn.right +15, 80, 13, 13);
	[self.contentView addSubview:icon4];
	[self animation:icon4 withF1:CGRectMake(signBtn.right +15, 80, 13, 13) andF2:CGRectMake(SCREEN_WIDTH - 15, 135, 13, 13)];
	
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
-(void)animation:(UIImageView*)img withF1:(CGRect)f1 andF2:(CGRect)f2{
	CGRect begin = f2;
	CGRect end = f1;
	[UIView animateWithDuration:3 animations:^{
		img.frame = f2;
	} completion:^(BOOL finished) {
		if (finished) {
			
			[self animation:img withF1:begin andF2:end];
		}
	}];
}
@end
