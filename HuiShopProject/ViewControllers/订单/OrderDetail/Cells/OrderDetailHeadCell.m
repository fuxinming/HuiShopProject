//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "OrderDetailHeadCell.h"

@implementation OrderDetailHeadItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 110;

    }
    return self;
}

@end

@interface OrderDetailHeadCell()
{
 
}
@end

@implementation OrderDetailHeadCell
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
	
	NSString *sta = [AppUtil getOrderStatus:IntRelay(self.item.userinfo[@"orderState"])];
	UILabel*lab1 = [self createLabel:sta color:[UIColor whiteColor] font:Font_Size_14];
	lab1.frame = CGRectMake(30, 45, SCREEN_WIDTH -  145, 20);
	[self.contentView addSubview:lab1];
	
	
	
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 90, 25, 60, 60)];
    icon.image = [UIImage imageNamed:@"lihe"];
    [self.contentView addSubview:icon];
	
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
