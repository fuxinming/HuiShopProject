//
//  WSMsgCell.m
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//

#import "VouchersSelectCell.h"


@implementation VouchersSelectItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 70;
    }
    return self;
}
@end

@interface VouchersSelectCell ()
{
}
@end
@implementation VouchersSelectCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.contentView.backgroundColor = [UIColor whiteColor];;
    self.backgroundColor = [UIColor whiteColor];
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
	
	UILabel *price1Label = [self createLabel:[NSString stringWithFormat:@"￥%.2f",DoubleRelay(self.item.userinfo[@"amount"])] color:COLOR_RED_ font:Font_Size_13];
	[price1Label sizeToFit];
	price1Label.frame = CGRectMake(15, 0, price1Label.width, 30);
	[self.contentView addSubview:price1Label];
	
	UILabel*lab1 = [self createLabel:[NSString stringWithFormat:@"订单满%.2f使用（不包含配送费）",DoubleRelay(self.item.userinfo[@"amountLimit"])] color:COLOR_333 font:Font_Size_13];
	[lab1 sizeToFit];
	lab1.frame = CGRectMake(15, 30, lab1.width, 20);
	[self.contentView addSubview:lab1];
	
	UILabel*lab3 = [self createLabel:[NSString stringWithFormat:@"使用期限 %@-%@",StrRelay(self.item.userinfo[@"strAffectDate"]),StrRelay(self.item.userinfo[@"strExpireDate"])] color:COLOR_999 font:Font_Size_12];
	[lab3 sizeToFit];
	lab3.frame = CGRectMake(15, 50, lab3.width, 20);
	[self.contentView addSubview:lab3];
	
	
	UIButton *selbtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[selbtn setImage:[UIImage imageNamed:@"fuxuankuangNO"] forState:UIControlStateNormal];
	[selbtn setImage:[UIImage imageNamed:@"fuxuankuangYES"] forState:UIControlStateSelected];
	selbtn.frame = CGRectMake(SCREEN_WIDTH - 56, 7, 56, 56);
	selbtn.imageEdgeInsets = UIEdgeInsetsMake(20, 20, 20, 20);
	[selbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	selbtn.tag = 100;
	if(self.item.isdeSelect){
		selbtn.selected = YES;
	}else{
		selbtn.selected = NO;
	}
	if (self.item.price >= DoubleRelay(self.item.userinfo[@"amountLimit"])) {
		selbtn.enabled = YES;
	}else{
		selbtn.enabled = NO;
	}
	[self.contentView addSubview:selbtn];
	
	UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15,69, SCREEN_WIDTH - 30, 1)];
	lineView.backgroundColor = COLOR_ddd;
	[self.contentView addSubview:lineView];
}

-(void)btnClick:(UIButton *)btn{
	if(self.item.btnSelect){
		self.item.btnSelect(self.item);
	}
}
@end
