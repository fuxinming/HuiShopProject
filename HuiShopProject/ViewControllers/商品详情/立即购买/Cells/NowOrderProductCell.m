//
//  WSMsgCell.m
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//

#import "NowOrderProductCell.h"


@implementation NowOrderProductItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 93;
    }
    return self;
}
@end

@interface NowOrderProductCell ()
{
}
@end
@implementation NowOrderProductCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.contentView.backgroundColor = COLOR_BACKGROUND;
    self.backgroundColor = [UIColor clearColor];
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
    [self.contentView removeAllSubviews];
	
	UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 63, 63)];
	[img1 sd_setImageWithURL:[NSURL URLWithString:self.item.userinfo[@"picUrl"]]];
	[self.contentView addSubview:img1];
	
	UILabel*lab1 = [self createLabel:StrRelay(self.item.userinfo[@"name"]) color:COLOR_333 font:Font_Size_13];
	[lab1 sizeToFit];
	lab1.frame = CGRectMake(img1.right +5, 15, lab1.width, 20);
	[self.contentView addSubview:lab1];
	
	UILabel *price1Label = [self createLabel:[NSString stringWithFormat:@"￥%@",StrRelay(self.item.userinfo[@"marketPrice"])] color:COLOR_RED_ font:Font_Size_13];
	[price1Label sizeToFit];
	price1Label.frame = CGRectMake(img1.right +5, lab1.bottom + 23, price1Label.width, 20);
	[self.contentView addSubview:price1Label];
	
	UILabel*lab3 = [self createLabel:[NSString stringWithFormat:@"x%@",StrRelay(self.item.userinfo[@"qty"])] color:COLOR_333 font:Font_Size_13];
	[lab3 sizeToFit];
	lab3.frame = CGRectMake(SCREEN_WIDTH - 40, price1Label.top, lab3.width, 20);
	[self.contentView addSubview:lab3];
	
	UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,91, SCREEN_WIDTH, 2)];
	lineView.backgroundColor = [UIColor whiteColor];
	[self.contentView addSubview:lineView];
}


@end
