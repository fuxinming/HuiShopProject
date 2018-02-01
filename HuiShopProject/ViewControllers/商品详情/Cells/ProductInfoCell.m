//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "ProductInfoCell.h"

@implementation ProductInfoItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 490;
    }
    return self;
}

@end

@interface ProductInfoCell()
{
}
@end

@implementation ProductInfoCell
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
    UIImageView *icon = [[UIImageView alloc]init];
    [icon setWebImageWithUrl:StrRelay(self.item.userinfo[@"picUrl"]) placeHolder:nil];
    icon.frame = CGRectMake((SCREEN_WIDTH-300)/2, 10, 300, 300);
    [self.contentView addSubview:icon];
    
    UILabel *price1Label = [self createLabel:[NSString stringWithFormat:@"￥%@",StrRelay(self.item.userinfo[@"marketPrice"])] color:COLOR_RED_ font:Font_Size_16];
    [price1Label sizeToFit];
    price1Label.frame = CGRectMake(15, 320, price1Label.width, 44);
    [self.contentView addSubview:price1Label];
	
	UILabel *price2Label = [self createLabel:[NSString stringWithFormat:@"￥%@",StrRelay(self.item.userinfo[@"retailPrice"])] color:COLOR_999 font:Font_Size_13];
	[price2Label sizeToFit];
	price2Label.frame = CGRectMake(price1Label.right + 10, 320, price2Label.width, 44);
	[self.contentView addSubview:price2Label];
	
	UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0,22, price2Label.width, 0.5)];
	lineView1.backgroundColor = COLOR_ddd;
	[price2Label addSubview:lineView1];
	
	UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0,price2Label.bottom, SCREEN_WIDTH, 1.5)];
	lineView2.backgroundColor = COLOR_ddd;
	[self.contentView addSubview:lineView2];
	
	UILabel *tLabel = [self createLabel:StrRelay(self.item.userinfo[@"name"]) color:COLOR_333 font:Font_Size_16];
	[tLabel sizeToFit];
	tLabel.frame = CGRectMake(15, lineView2.bottom, tLabel.width, 44);
	[self.contentView addSubview:tLabel];
	
	UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0,tLabel.bottom, SCREEN_WIDTH, 25)];
	lineView3.backgroundColor = COLOR_ddd;
	[self.contentView addSubview:lineView3];
	
	UILabel *xianLabel = [self createLabel:@"现货" color:COLOR_RED_ font:Font_Size_12];
	[xianLabel sizeToFit];
	xianLabel.frame = CGRectMake(15, 0, xianLabel.width, 25);
	[lineView3 addSubview:xianLabel];
	
	UILabel *chaoshiLabel = [self createLabel:StrRelay(self.item.userinfo[@"marketName"]) color:COLOR_999 font:Font_Size_12];
	[chaoshiLabel sizeToFit];
	chaoshiLabel.frame = CGRectMake(xianLabel.right + 35, 0, chaoshiLabel.width, 25);
	[lineView3 addSubview:chaoshiLabel];
	
	UILabel *shuomingLabel = [self createLabel:@"" color:COLOR_333 font:Font_Size_16];
	shuomingLabel.frame = CGRectMake(15, lineView3.bottom, SCREEN_WIDTH - 30, 44);
	NSMutableAttributedString *str1 = [CommonUtil mutableStringAppendString:@"说明：  ".color(COLOR_333).font(Font_Size_15)];
	str1.append(@"•".color(COLOR_RED_).font(Font_Size_15));
	str1.append([NSString stringWithFormat:@"满%.2f元免配送",DoubleRelay(self.item.userinfo[@"freeDispatchLimit"])].color(COLOR_333).font(Font_Size_15));
	shuomingLabel.attributedText = str1;
	[self.contentView addSubview:shuomingLabel];
	
	
	UIView *lineView4 = [[UIView alloc]initWithFrame:CGRectMake(0,shuomingLabel.bottom, SCREEN_WIDTH, 25)];
	lineView4.backgroundColor = COLOR_ddd;
	[self.contentView addSubview:lineView4];
	
	UILabel *xiangLabel = [self createLabel:@"商品详细：" color:COLOR_999 font:Font_Size_15];
	[xiangLabel sizeToFit];
	xiangLabel.frame = CGRectMake(15, 0, xiangLabel.width, 25);
	[lineView4 addSubview:xiangLabel];
	
	self.item.cellHeight = lineView4.bottom;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
