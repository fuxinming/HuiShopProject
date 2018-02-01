//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "NowOrderAddressCell.h"

@implementation NowOrderAddressItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 72;
    }
    return self;
}

@end

@interface NowOrderAddressCell()
{
}
@end

@implementation NowOrderAddressCell
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
	
	UILabel*lab1 = [self createLabel:StrRelay(self.item.userinfo[@"name"]) color:COLOR_333 font:[UIFont boldSystemFontOfSize:13]];
	[lab1 sizeToFit];
	lab1.frame = CGRectMake(15, 12, lab1.width, 17);
	[self.contentView addSubview:lab1];
	
	UILabel*lab2 = [self createLabel:StrRelay(self.item.userinfo[@"tel"]) color:COLOR_333 font:[UIFont boldSystemFontOfSize:13]];
	[lab2 sizeToFit];
	lab2.frame = CGRectMake(lab1.right + 30, 12,lab2.width, 17);
	[self.contentView addSubview:lab2];
	
	if (IntRelay(self.item.userinfo[@"isDefault"]) == 1) {
		UILabel*def = [self createLabel:@"默认" color:[UIColor whiteColor] font:Font_Size_13];
		[def sizeToFit];
		def.frame = CGRectMake(lab2.right + 30, 12,def.width + 20, 17);
		def.textAlignment = NSTextAlignmentCenter;
		def.backgroundColor = COLOR_RED_;
		[self.contentView addSubview:def];
	}
	
	UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 47, 18, 18)];
	img1.image = [UIImage imageNamed:@"dingwei"];
	[self.contentView addSubview:img1];
	
	UILabel* lab3 = [self createLabel:[NSString stringWithFormat:@"%@%@",StrRelay(self.item.userinfo[@"addressInfo"]),StrRelay(self.item.userinfo[@"detailAddr"])] color:COLOR_333 font:[UIFont systemFontOfSize:13]];
	lab3.frame = CGRectMake( img1.right + 5,img1.top,SCREEN_WIDTH - 50, 18);
	[self.contentView addSubview:lab3];
	
	UIButton *myBtn1 = [self createBtn:@"" color:COLOR_333 font:Font_Size_13 tag:101];
	myBtn1.frame = CGRectMake(SCREEN_WIDTH - 50,11, 50, 50);
	[myBtn1 setImage:[UIImage imageNamed:@"rightArr"] forState:UIControlStateNormal];
	[myBtn1 addTarget:self action:@selector(btnSelect) forControlEvents:UIControlEventTouchUpInside];
//	myBtn1.imageEdgeInsets = UIEdgeInsetsMake(2.5, 0, 2.5, 55);
	[self.contentView addSubview:myBtn1];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(void)btnSelect{
	if (self.item.selectionHandler) {
		self.item.selectionHandler(self.item);
	}
}

@end
