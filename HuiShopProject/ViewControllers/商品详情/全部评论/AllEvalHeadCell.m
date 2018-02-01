//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "AllEvalHeadCell.h"
#import "ShowBigPicViewController.h"
@implementation AllEvalHeadItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 45;
		
    }
    return self;
}

@end

@interface AllEvalHeadCell()
{

}
@end

@implementation AllEvalHeadCell
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
	
	NSArray *arr = self.item.userinfo;
	float w = SCREEN_WIDTH/4;
	for (int i = 0; i < arr.count; i++) {
		NSDictionary *dict = arr[i];
		
		UIButton *btn = [self createImgBtn:@"" tag:100 + i];
		
		btn.frame = CGRectMake(w*i, 0, w, 45);
		btn.userinfo = dict;
		[self.contentView addSubview:btn];
		
		UILabel*tLab = [self createLabel:StrRelay(dict[@"evalDesc"]) color:COLOR_333 font:Font_Size_13];
		tLab.tag = 60;
		tLab.frame = CGRectMake(0, 0, w, 25);
		tLab.textAlignment = NSTextAlignmentCenter;
		tLab.userInteractionEnabled = NO;
		[btn addSubview:tLab];
		
		UILabel*t1Lab = [self createLabel:StrRelay(dict[@"total"]) color:COLOR_333 font:Font_Size_13];
		t1Lab.tag = 61;
		t1Lab.frame = CGRectMake(0, 25, w, 20);
		t1Lab.textAlignment = NSTextAlignmentCenter;
		t1Lab.userInteractionEnabled = NO;
		[btn addSubview:t1Lab];
		if (i == self.item.defIndex) {
			tLab.textColor = COLOR_RED_;
			t1Lab.textColor = COLOR_RED_;
		}
	}

	UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.item.cellHeight - 0.5, SCREEN_WIDTH, 0.5)];
	lineView.backgroundColor = COLOR_ddd;
	[self.contentView addSubview:lineView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}
-(void)btnClick:(UIButton *)btn{
	self.item.defIndex = btn.tag - 100;
	[self changeLabelColor];
	FMBlock(self.item.buttonClick,btn.tag - 100,self.item);
}

-(void)changeLabelColor{
	NSArray *arr = self.item.userinfo;
	for (int i = 0; i < arr.count; i++) {
		UIButton *btn = [self.contentView viewWithTag:100+i];
		UILabel *label1 = [btn viewWithTag:60];
		UILabel *label2 = [btn viewWithTag:61];
		if (i == self.item.defIndex) {
			label1.textColor = COLOR_RED_;
			label2.textColor = COLOR_RED_;
		}else{
			label1.textColor = COLOR_333;
			label2.textColor = COLOR_333;
		}
	}
}
@end
