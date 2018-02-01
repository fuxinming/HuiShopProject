//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "NearByMarketInfoCell.h"
#import "ProductDetailViewController.h"
#import "XHStarRateView.h"
@implementation NearByMarketInfoItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 134;
    }
    return self;
}

@end

@interface NearByMarketInfoCell()
{
}
@end

@implementation NearByMarketInfoCell
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
    
    UIImageView *icon = [[UIImageView alloc]init];
    [icon setWebImageWithUrl:StrRelay(self.item.userinfo[@"picUrl"]) placeHolder:nil];
    icon.frame = CGRectMake(15, 15, 50, 50);
    [self.contentView addSubview:icon];
    
    UILabel *titleLabel = [self createLabel:StrRelay(self.item.userinfo[@"name"]) color:COLOR_333 font:Font_Size_14];
	[titleLabel sizeToFit];
    titleLabel.frame = CGRectMake(icon.right + 10, 15, titleLabel.width, 22);
    [self.contentView addSubview:titleLabel];
    
    UILabel *t1Label = [self createLabel:@"配送费" color:COLOR_999 font:Font_Size_14];
	[t1Label sizeToFit];
    t1Label.frame = CGRectMake(SCREEN_WIDTH - 15 - t1Label.width, 15, t1Label.width, 22);
    [self.contentView addSubview:t1Label];
	
	UILabel *t2Label = [self createLabel:[NSString stringWithFormat:@"￥%.2f",DoubleRelay(self.item.userinfo[@"dispatchFee"])] color:COLOR_RED_ font:Font_Size_14];
	[t2Label sizeToFit];
	t2Label.frame = CGRectMake(SCREEN_WIDTH - 15 - t2Label.width, 15, t2Label.width, 22);
	t2Label.right = t1Label.left;
	[self.contentView addSubview:t2Label];
	
	
	XHStarRateView *starRateView = [[XHStarRateView alloc] initWithFrame:CGRectMake(icon.right + 10, icon.top + 30, 110, 15) numberOfStars:5 rateStyle:WholeStar isAnination:YES delegate:self];
	starRateView.userInteractionEnabled = NO;
	starRateView.currentScore = DoubleRelay(self.item.userinfo[@"scoreStar"]);
	[self.contentView addSubview:starRateView];
	
	UILabel *t3Label = [self createLabel:[NSString stringWithFormat:@"%.1f",DoubleRelay(self.item.userinfo[@"scoreStar"])] color:COLOR_RED_ font:Font_Size_14];
	[t3Label sizeToFit];
	t3Label.frame = CGRectMake(starRateView.right + 5, starRateView.top, t3Label.width, 15);
	[self.contentView addSubview:t3Label];
	
	UILabel *t4Label = [self createLabel:[NSString stringWithFormat:@"%.1f千米",DoubleRelay(self.item.userinfo[@"distance"])] color:COLOR_999 font:Font_Size_13];
	[t4Label sizeToFit];
	t4Label.frame = CGRectMake(icon.right + 10, 70, t4Label.width, 15);
	[self.contentView addSubview:t4Label];
	
	UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 12, 72, 12, 12)];
	img1.image = [UIImage imageNamed:@"icon_shop_piao"];
	[self.contentView addSubview:img1];
	
	UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(icon.right + 10,100, SCREEN_WIDTH - icon.right - 10, 0.5)];
	lineView.backgroundColor = COLOR_ddd;
	[self.contentView addSubview:lineView];
	
	UIImageView *img2 = [[UIImageView alloc]initWithFrame:CGRectMake(icon.right+ 10, lineView.bottom + 11, 12, 12)];
	img2.image = [UIImage imageNamed:@"icon_shop_pei"];
	[self.contentView addSubview:img2];
	
	UILabel *t5Label = [self createLabel:[NSString stringWithFormat:@"订单满%.2f免配送费",DoubleRelay(self.item.userinfo[@"freeDispatchLimit"])] color:COLOR_999 font:Font_Size_12];
	[t5Label sizeToFit];
	t5Label.frame = CGRectMake(img2.right + 5, lineView.bottom + 8, t5Label.width, 18);
	[self.contentView addSubview:t5Label];
	
	UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0,133.5, SCREEN_WIDTH , 0.5)];
	lineView2.backgroundColor = COLOR_ddd;
	[self.contentView addSubview:lineView2];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
-(void)btnClick:(UIButton *)btn{
	
}
@end
