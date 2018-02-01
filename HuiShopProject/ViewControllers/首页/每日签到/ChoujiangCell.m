//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "ChoujiangCell.h"

@implementation ChoujiangItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 120;
    }
    return self;
}

@end

@interface ChoujiangCell()
{
}
@end

@implementation ChoujiangCell
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
	bgImage.image = [UIImage imageNamed:@"bkg_gold_sign_in"];
	bgImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, 120);
	[self.contentView addSubview:bgImage];
	
	UIImageView *coinImage = [[UIImageView alloc]init];
	coinImage.image = [UIImage imageNamed:@"img_lucky_draw_sign_in"];
	coinImage.frame = CGRectMake((SCREEN_WIDTH - 40)/2, 30, 40, 40);
	coinImage.userInteractionEnabled = NO;
	[self.contentView addSubview:coinImage];
	
	
	UILabel *t1Label = [self createLabel:@"幸运大转盘，幸运就在手指尖" color:COLOR_999 font:Font_Size_16];
	t1Label.frame = CGRectMake(0,coinImage.bottom + 15, SCREEN_WIDTH, 22);
	t1Label.textAlignment = NSTextAlignmentCenter;
	[self.contentView addSubview:t1Label];

	
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
