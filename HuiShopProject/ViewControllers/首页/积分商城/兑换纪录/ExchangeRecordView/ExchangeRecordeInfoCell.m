//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "ExchangeRecordeInfoCell.h"

@implementation ExchangeRecordeInfoItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 90;
    }
    return self;
}

@end

@interface ExchangeRecordeInfoCell()
{
}
@end

@implementation ExchangeRecordeInfoCell
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
	
	
	UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(15, 5,80 , 80)];
	[icon sd_setImageWithURL:[NSURL URLWithString:self.item.userinfo[@"picUrl"]] placeholderImage:[UIImage imageNamed:@""]];
	[self.contentView addSubview:icon];
	
	UILabel*nameLab = [self createLabel:StrRelay(self.item.userinfo[@"shakeGoodName"]) color:COLOR_333 font:Font_Size_14];
	nameLab.frame = CGRectMake(icon.right + 5, icon.top+ 10, SCREEN_WIDTH - 10 - 29, 20);
	[self.contentView addSubview:nameLab];
	
	UILabel*chaoshiLab = [self createLabel:[NSString stringWithFormat:@"兑换时间 %@",StrRelay(self.item.userinfo[@"luckyTime"])] color:COLOR_999 font:Font_Size_12];
	chaoshiLab.frame = CGRectMake(icon.right + 5, nameLab.bottom, SCREEN_WIDTH - 10 - 29, 15);
	[self.contentView addSubview:chaoshiLab];
	
	UILabel*priceLab = [self createLabel:[NSString stringWithFormat:@"截止时间 %@",StrRelay(self.item.userinfo[@"exchangeExpireTime"])] color:COLOR_RED_ font:Font_Size_14];
	priceLab.frame = CGRectMake(icon.right + 5, chaoshiLab.bottom + 5, SCREEN_WIDTH - 10 - 29, 20);
	[self.contentView addSubview:priceLab];
	
	UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,89.5, SCREEN_WIDTH, 0.5)];
	lineView.backgroundColor = COLOR_ddd;
	[self.contentView addSubview:lineView];
	
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
