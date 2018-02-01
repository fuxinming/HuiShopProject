//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "TicketInfoCell.h"

@implementation TicketInfoItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 120;
        self.haveLine = YES;
    }
    return self;
}

@end

@interface TicketInfoCell()
{
}
@end

@implementation TicketInfoCell
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
	UIImageView *bgImage = [[UIImageView alloc]initWithFrame:CGRectMake( 25, 5, SCREEN_WIDTH - 50, 110)];
	bgImage.image = [UIImage imageNamed:@"img_back_voucher"];
	[self.contentView addSubview:bgImage];
	
	UIImageView *image1 = [[UIImageView alloc]initWithFrame:CGRectMake( 25 + 20, 12, 22, 22)];
	image1.image = [UIImage imageNamed:@"marckrt"];
	[self.contentView addSubview:image1];
	
	UILabel*lab1 = [self createLabel:@"所有超市通用" color:COLOR_333 font:Font_Size_12];
	lab1.frame = CGRectMake(image1.right, 12, 100, 22);
	[self.contentView addSubview:lab1];
	
	UIButton *btn = [self createBtn:@"查看使用规则" color:COLOR_RED_ font:Font_Size_13 tag:100];
	btn.frame = CGRectMake(SCREEN_WIDTH - 20 - 25 - 80, 12,80 , 22);
	[self.contentView addSubview:btn];

	UILabel* lab2 = [self createLabel:[NSString stringWithFormat:@"￥%.2f",DoubleRelay(self.item.userinfo[@"amount"])] color:COLOR_333 font:[UIFont systemFontOfSize:22]];
	lab2.frame = CGRectMake(20 + 25, 60,70, 24);
	lab2.textAlignment = NSTextAlignmentCenter;
	[self.contentView addSubview:lab2];
	
	UILabel* lab3 = [self createLabel:[NSString stringWithFormat:@"满￥%.2f使用",DoubleRelay(self.item.userinfo[@"amountLimit"])] color:COLOR_666 font:[UIFont systemFontOfSize:10]];
	lab3.frame = CGRectMake(20 + 25, lab2.bottom,70, 20);
	lab3.textAlignment = NSTextAlignmentCenter;
	[self.contentView addSubview:lab3];
	
	UILabel* lab4 = [self createLabel:[NSString stringWithFormat:@"使用期限 %@-%@",StrRelay(self.item.userinfo[@"strAffectDate"]),StrRelay(self.item.userinfo[@"strExpireDate"])] color:COLOR_999 font:[UIFont systemFontOfSize:10]];
	lab4.frame = CGRectMake( bgImage.width*0.381 + 20 + 25, lab2.top,170, 20);
	lab4.textAlignment = NSTextAlignmentLeft;
	[self.contentView addSubview:lab4];
	
	UILabel* lab5 = [self createLabel:@"所有商品可用" color:COLOR_333 font:[UIFont systemFontOfSize:12]];
	lab5.frame = CGRectMake( bgImage.width*0.381 + 20 + 25, lab2.bottom,150, 20);
	lab5.textAlignment = NSTextAlignmentLeft;
	[self.contentView addSubview:lab5];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(void)btnClick:(UIButton *)btn{
	[AppUtil showAlert:@"温馨提示" msg:@"每笔订单只能使用一张代金券，代金券所有解释权归总公司所有" handle:^(BOOL cancelled, NSInteger buttonIndex) {
		
	}];
}
@end
