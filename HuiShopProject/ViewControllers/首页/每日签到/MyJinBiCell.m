//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "MyJinBiCell.h"

@implementation MyJinBiItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 90;
    }
    return self;
}

@end

@interface MyJinBiCell()
{
}
@end

@implementation MyJinBiCell
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
	bgImage.frame = CGRectMake(0, 0, SCREEN_WIDTH, 90);
	[self.contentView addSubview:bgImage];
	
	UIImageView *coinImage = [[UIImageView alloc]init];
	coinImage.image = [UIImage imageNamed:@"img_gold"];
	coinImage.frame = CGRectMake((SCREEN_WIDTH - 30)/2, 30, 30, 30);
	[self.contentView addSubview:coinImage];
	
	UILabel *titleLabel = [self createLabel:self.item.jinbi color:COLOR_333 font:Font_Size_16];
	titleLabel.frame = CGRectMake(coinImage.right + 4, coinImage.bottom - 20, 100, 20);
	[self.contentView addSubview:titleLabel];
	
	UILabel *t1Label = [self createLabel:@"我的金币明细" color:COLOR_999 font:Font_Size_13];
	t1Label.frame = CGRectMake(0,titleLabel.bottom + 5, SCREEN_WIDTH, 22);
	t1Label.textAlignment = NSTextAlignmentCenter;
	[self.contentView addSubview:t1Label];
	
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
