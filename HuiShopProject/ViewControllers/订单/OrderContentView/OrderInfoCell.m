//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "OrderInfoCell.h"

@implementation OrderInfoItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 200;

    }
    return self;
}

@end

@interface OrderInfoCell()
{
 
}
@end

@implementation OrderInfoCell
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
    
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(14, 8, 20, 20)];
    icon.image = [UIImage imageNamed:@"marckrt"];
    [self.contentView addSubview:icon];
    
    UILabel*lab1 = [self createLabel:StrRelay(self.item.userinfo[@"marketName"]) color:COLOR_999 font:Font_Size_14];
    lab1.frame = CGRectMake(icon.right+5, 10, SCREEN_WIDTH -  145, 16);
    [self.contentView addSubview:lab1];
    
    NSString *statStr = [AppUtil getOrderStatus:IntRelay(self.item.userinfo[@"orderState"])];
	UILabel* lab2 = [self createLabel:statStr color:COLOR_RED_ font:Font_Size_14];
    lab2.frame = CGRectMake(SCREEN_WIDTH - 100, 10, 85, 16);
    lab2.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:lab2];
    
    float Y = 68;
	int jisanshu = 0;
	NSArray *pArr = self.item.userinfo[@"goodsList"];
	for (int i = 0; i < pArr.count; i ++) {
		NSDictionary *dict = [pArr objectAtIndex:i];
		UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(0, 36+Y*i, SCREEN_WIDTH , 68)];
		bgView.backgroundColor = COLOR_BACKGROUND;
		[self.contentView addSubview:bgView];
		
		UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 6, 56, 56)];
		[img1 sd_setImageWithURL:[NSURL URLWithString:dict[@"picUrl"]]];
		[bgView addSubview:img1];
		
		UILabel*lab3 = [self createLabel:StrRelay(dict[@"goodsName"]) color:COLOR_333 font:Font_Size_13];
		[lab3 sizeToFit];
		lab3.frame = CGRectMake(img1.right +10, img1.top, lab1.width, 20);
		[bgView addSubview:lab3];
		
		UILabel *price1Label = [self createLabel:[NSString stringWithFormat:@"￥%@",StrRelay(dict[@"goodsPrice"])] color:COLOR_RED_ font:Font_Size_13];
		[price1Label sizeToFit];
		price1Label.frame = CGRectMake(img1.right +10, lab1.bottom + 16, price1Label.width, 20);
		[bgView addSubview:price1Label];
		
		UILabel*lab4= [self createLabel:[NSString stringWithFormat:@"x%@",StrRelay(dict[@"goodsQty"])] color:COLOR_333 font:Font_Size_13];
		[lab4 sizeToFit];
		lab4.frame = CGRectMake(SCREEN_WIDTH - 40, price1Label.top, lab4.width, 20);
		[bgView addSubview:lab4];
		
		
		UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,67.5, SCREEN_WIDTH, 0.5)];
		lineView.backgroundColor = [UIColor whiteColor];
		[bgView addSubview:lineView];
		
		jisanshu += IntRelay(dict[@"goodsQty"]);
	}
    
    UILabel*lab5= [self createLabel:[NSString stringWithFormat:@"共%d件商品  合计：￥%.2f  (含运费￥%.2f)",jisanshu,DoubleRelay(self.item.userinfo[@"payFee"]),DoubleRelay(self.item.userinfo[@"freight"])] color:COLOR_333 font:Font_Size_13];
    [lab5 sizeToFit];
    lab5.frame = CGRectMake(SCREEN_WIDTH - 15 -lab5.width ,Y*pArr.count + 36, lab5.width, 38);
    lab5.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:lab5];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(15, lab5.bottom, SCREEN_WIDTH - 15 , 0.5)];
    lineView.backgroundColor = COLOR_ddd;
	
	
	UIButton *btn1 = [self createBtn:@"立即付款" color:COLOR_333 font:Font_Size_13 tag:100];
	btn1.frame = CGRectMake(SCREEN_WIDTH - 175, lineView.bottom+11, 70, 24);
	View_Border_Radius(btn1, 3, 1, COLOR_999);
	
	UIButton *btn2 = [self createBtn:@"取消订单" color:COLOR_333 font:Font_Size_13 tag:101];
	btn2.frame = CGRectMake(SCREEN_WIDTH - 85, lineView.bottom+11, 70, 24);
	View_Border_Radius(btn2, 3, 1, COLOR_999);
	
	
	UIButton *btn3 = [self createBtn:@"确认收货" color:COLOR_333 font:Font_Size_13 tag:103];
	btn3.frame = CGRectMake(SCREEN_WIDTH - 175, lineView.bottom+11, 70, 24);
	View_Border_Radius(btn3, 3, 1, COLOR_999);
	
	UIButton *btn4 = [self createBtn:@"配送信息" color:COLOR_333 font:Font_Size_13 tag:104];
	btn4.frame = CGRectMake(SCREEN_WIDTH - 85, lineView.bottom+11, 70, 24);
	View_Border_Radius(btn4, 3, 1, COLOR_999);
	
	UIButton *btn5 = [self createBtn:@"评价订单" color:COLOR_333 font:Font_Size_13 tag:105];
	btn5.frame = CGRectMake(SCREEN_WIDTH - 175, lineView.bottom+11, 70, 24);
	View_Border_Radius(btn5, 3, 1, COLOR_999);
	
	UIButton *btn6 = [self createBtn:@"订单投诉" color:COLOR_333 font:Font_Size_13 tag:106];
	btn6.frame = CGRectMake(SCREEN_WIDTH - 265, lineView.bottom+11, 70, 24);
	View_Border_Radius(btn6, 3, 1, COLOR_999);
	
	UIButton *btn7 = [self createBtn:@"删除订单" color:COLOR_333 font:Font_Size_13 tag:107];
	btn7.frame = CGRectMake(SCREEN_WIDTH - 85, lineView.bottom+11, 70, 24);
	View_Border_Radius(btn7, 3, 1, COLOR_999);
	
	if (IntRelay(self.item.userinfo[@"orderState"]) == 1) {
		[self.contentView addSubview:btn1];
		[self.contentView addSubview:btn2];
		[self.contentView addSubview:lineView];
		self.item.cellHeight = btn2.bottom + 11;
	}else if (IntRelay(self.item.userinfo[@"orderState"]) == 4) {
		[self.contentView addSubview:btn3];
		[self.contentView addSubview:btn4];
		[self.contentView addSubview:lineView];
		self.item.cellHeight = btn2.bottom + 11;
	}else if (IntRelay(self.item.userinfo[@"orderState"]) == 5) {
		[self.contentView addSubview:btn5];
		[self.contentView addSubview:btn6];
		[self.contentView addSubview:btn7];
		[self.contentView addSubview:lineView];
		self.item.cellHeight = btn2.bottom + 11;
	}else if (IntRelay(self.item.userinfo[@"orderState"]) == 10) {
		[self.contentView addSubview:btn7];
		[self.contentView addSubview:lineView];
		self.item.cellHeight = btn2.bottom + 11;
	}else if (IntRelay(self.item.userinfo[@"orderState"]) == 11) {
		[self.contentView addSubview:btn7];
		[self.contentView addSubview:lineView];
		self.item.cellHeight = btn2.bottom + 11;
	}else{
		self.item.cellHeight = lab5.bottom + 2;
	}
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
-(void)btnClick:(UIButton *)btn{
	FMBlock(self.item.btnClick,btn.tag,self.item);
}
@end
