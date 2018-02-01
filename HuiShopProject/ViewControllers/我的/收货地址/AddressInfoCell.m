//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "AddressInfoCell.h"

@implementation AddressInfoItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 110;
    }
    return self;
}

@end

@interface AddressInfoCell()
{
}
@end

@implementation AddressInfoCell
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
	
	UIView *bgview = [[UIView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH - 20, 100)];
	bgview.backgroundColor = [UIColor whiteColor];
	[self.contentView addSubview:bgview];
	
	UILabel*lab1 = [self createLabel:StrRelay(self.item.userinfo[@"name"]) color:COLOR_333 font:[UIFont boldSystemFontOfSize:13]];
	lab1.frame = CGRectMake(25, 25, (SCREEN_WIDTH - 50)/2, 20);
	[self.contentView addSubview:lab1];
	
	UILabel*lab2 = [self createLabel:StrRelay(self.item.userinfo[@"tel"]) color:COLOR_333 font:[UIFont boldSystemFontOfSize:13]];
	lab2.frame = CGRectMake(SCREEN_WIDTH/2, 25, (SCREEN_WIDTH - 50)/2, 20);
	lab2.textAlignment = NSTextAlignmentRight;
	[self.contentView addSubview:lab2];

	UILabel* lab3 = [self createLabel:[NSString stringWithFormat:@"%@%@",StrRelay(self.item.userinfo[@"addressInfo"]),StrRelay(self.item.userinfo[@"detailAddr"])] color:COLOR_999 font:[UIFont systemFontOfSize:12]];
	lab3.frame = CGRectMake( 25, lab2.bottom + 4,SCREEN_WIDTH - 50, 24);
	[self.contentView addSubview:lab3];
	
	
	UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(10,74, SCREEN_WIDTH - 20, 1)];
	lineView1.backgroundColor = COLOR_999;
	[self.contentView addSubview:lineView1];
	
	UIButton *myBtn1 = [self createBtn:@"默认地址" color:COLOR_333 font:Font_Size_13 tag:101];
	myBtn1.frame = CGRectMake(25,lineView1.bottom + 6, 70, 20);
	[myBtn1 setImage:[UIImage imageNamed:@"unselectCicle"] forState:UIControlStateNormal];
	[myBtn1 setImage:[UIImage imageNamed:@"selectCircle"] forState:UIControlStateSelected];
	myBtn1.imageEdgeInsets = UIEdgeInsetsMake(2.5, 0, 2.5, 55);
	[self.contentView addSubview:myBtn1];
	
	if (IntRelay(self.item.userinfo[@"isDefault"]) == 1) {
		myBtn1.selected = YES;
	}else{
		myBtn1.selected = NO;
	}
	UIButton *myBtn2 = [self createBtn:@"编辑" color:COLOR_999 font:Font_Size_12 tag:102];
	myBtn2.frame = CGRectMake(SCREEN_WIDTH - 50 - 50 - 10,lineView1.bottom + 6, 50, 20);
	[myBtn2 setImage:[UIImage imageNamed:@"bianji"] forState:UIControlStateNormal];
	myBtn2.imageEdgeInsets = UIEdgeInsetsMake(4, 0, 4, 38);
	[self.contentView addSubview:myBtn2];
	
	UIButton *myBtn3 = [self createBtn:@"删除" color:COLOR_999 font:Font_Size_12 tag:103];
	myBtn3.frame = CGRectMake(SCREEN_WIDTH - 50 - 10,lineView1.bottom + 6, 50, 20);
	[myBtn3 setImage:[UIImage imageNamed:@"img_delete_address"] forState:UIControlStateNormal];
	myBtn3.imageEdgeInsets = UIEdgeInsetsMake(4, 0, 4, 38);
	[self.contentView addSubview:myBtn3];
	
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
-(void)btnClick:(UIButton *)btn{
	if (btn.tag == 101 &&btn.selected) {
		return;
	}
	if (self.item.btnClick) {
		self.item.btnClick(btn.tag,self.item);
	}
}
@end
