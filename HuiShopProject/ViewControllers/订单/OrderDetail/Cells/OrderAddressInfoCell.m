//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "OrderAddressInfoCell.h"

@implementation OrderAddressInfoItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 72;

    }
    return self;
}

@end

@interface OrderAddressInfoCell()
{
 
}
@end

@implementation OrderAddressInfoCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor redColor];
    
    
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
    [self.contentView removeAllSubviews];
	
	self.contentView.backgroundColor = [UIColor whiteColor];
	
	
	UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 18, 18)];
	img1.image = [UIImage imageNamed:@"dingwei"];
	[self.contentView addSubview:img1];
	
	UILabel*lab1 = [self createLabel:StrRelay(self.item.userinfo[@"name"]) color:COLOR_333 font:[UIFont boldSystemFontOfSize:13]];
	[lab1 sizeToFit];
	lab1.frame = CGRectMake(img1.right + 10, 10, lab1.width, 18);
	[self.contentView addSubview:lab1];
	
	UILabel*lab2 = [self createLabel:StrRelay(self.item.userinfo[@"tel"]) color:COLOR_333 font:[UIFont boldSystemFontOfSize:13]];
	[lab2 sizeToFit];
	lab2.frame = CGRectMake(SCREEN_WIDTH - lab2.width - 15, 10,lab2.width, 18);
	[self.contentView addSubview:lab2];

	UILabel* lab3 = [self createLabel:[NSString stringWithFormat:@"%@%@",StrRelay(self.item.userinfo[@"addressInfo"]),StrRelay(self.item.userinfo[@"detailAddr"])] color:COLOR_333 font:[UIFont systemFontOfSize:13]];
	lab3.frame = CGRectMake( img1.right + 10,44,SCREEN_WIDTH - 50, 18);
	[self.contentView addSubview:lab3];
	

	
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
