//
//  WSMsgCell.m
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//

#import "CartProductCell.h"


@implementation CartProductItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 93;
    }
    return self;
}
@end

@interface CartProductCell ()
{
	UIButton *selbtn;
	UIImageView *img1;
	UILabel*lab1;
	UILabel *price1Label;
	
	UILabel*lab3;
	UIView *editView;
	
	UIButton *ebtn1;
	UILabel*elab;
	UIButton *ebtn2;
}
@end
@implementation CartProductCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.contentView.backgroundColor = COLOR_BACKGROUND;
    self.backgroundColor = [UIColor clearColor];
	
	selbtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[selbtn setImage:[UIImage imageNamed:@"unselectCicle"] forState:UIControlStateNormal];
	[selbtn setImage:[UIImage imageNamed:@"selectCircle"] forState:UIControlStateSelected];
	selbtn.frame = CGRectMake(0, 21.5, 50, 50);
	selbtn.imageEdgeInsets = UIEdgeInsetsMake(17.5, 17.5, 17.5, 17.5);
	[selbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	selbtn.tag = 100;
	[self.contentView addSubview:selbtn];
	
	img1 = [[UIImageView alloc]initWithFrame:CGRectMake(65, 15, 63, 63)];
	[self.contentView addSubview:img1];
	
	lab1 = [self createLabel:@"" color:COLOR_333 font:Font_Size_13];
	[self.contentView addSubview:lab1];
	
	price1Label = [self createLabel:@"" color:COLOR_RED_ font:Font_Size_13];
	[self.contentView addSubview:price1Label];
	
	lab3 = [self createLabel:@"" color:COLOR_333 font:Font_Size_13];
	[self.contentView addSubview:lab3];
	
	editView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 105, 50, 90, 30)];
	editView.hidden = YES;
	View_Border_Radius(editView, 3, 0.5, COLOR_ddd);
	[self.contentView addSubview:editView];
	
	ebtn1 = [self createBtn:@"-" color:COLOR_999 font:Font_Size_13 tag:101];
	ebtn1.frame = CGRectMake(0, 0, 29.5, 30);
	[editView  addSubview:ebtn1];
	
	UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(ebtn1.right,0, 0.5, 30)];
	lineView1.backgroundColor = COLOR_ddd;
	[editView addSubview:lineView1];
	
	elab = [self createLabel:@"" color:COLOR_333 font:Font_Size_13];
	elab.frame = CGRectMake(lineView1.right, 0, 29.5, 30);
	elab.textAlignment = NSTextAlignmentCenter;
	[editView addSubview:elab];
	
	UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(elab.right,0, 0.5, 30)];
	lineView2.backgroundColor = COLOR_ddd;
	[editView addSubview:lineView2];
	
	ebtn2 = [self createBtn:@"+" color:COLOR_999 font:Font_Size_13 tag:102];
	ebtn2.frame = CGRectMake(lineView2.right, 0, 30, 30);
	[editView  addSubview:ebtn2];
	
	UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,91, SCREEN_WIDTH, 2)];
	lineView.backgroundColor = [UIColor whiteColor];
	[self.contentView addSubview:lineView];
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
	selbtn.selected = self.item.isBtnSelect;
	[img1 sd_setImageWithURL:[NSURL URLWithString:self.item.userinfo[@"picUrl"]]];
	lab1.text = StrRelay(self.item.userinfo[@"goodsName"]);
	[lab1 sizeToFit];
	lab1.frame = CGRectMake(img1.right +5, 15, lab1.width, 20);
	
	price1Label.text = [NSString stringWithFormat:@"￥%@",StrRelay(self.item.userinfo[@"retailPrice"])];
	[price1Label sizeToFit];
	price1Label.frame = CGRectMake(img1.right +5, lab1.bottom + 23, price1Label.width, 20);
	self.item.qty = IntRelay(self.item.userinfo[@"goodsQty"]);
	
	lab3.text = [NSString stringWithFormat:@"x%d",self.item.qty];
	[lab3 sizeToFit];
	lab3.frame = CGRectMake(SCREEN_WIDTH - lab3.width-20, price1Label.top, lab3.width, 20);
	elab.text = [NSString stringWithFormat:@"%d",self.item.qty];
	
	if (self.item.isEdict) {
		editView.hidden = NO;
		lab3.hidden = YES;
	}else{
		editView.hidden = YES;
		lab3.hidden = NO;
	}
}

-(void)btnClick:(UIButton *)btn{
	if (btn.tag == 100) {
		btn.selected = !btn.selected;
		self.item.isBtnSelect = btn.isSelected;
		FMBlock(self.item.btnClick,btn.tag);
	}
	
	if (btn.tag == 101) {
		if (self.item.qty <=1) {
			Toast(@"商品数量不能少于1");
			return;
		}
		self.item.qty --;
		elab.text = [NSString stringWithFormat:@"%d",self.item.qty];
	}
	if (btn.tag == 102) {
		
		self.item.qty ++;
		elab.text = [NSString stringWithFormat:@"%d",self.item.qty];
	}
}
@end
