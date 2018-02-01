//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "PingjiaHeadCell.h"

@implementation PingjiaHeadItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 70;

    }
    return self;
}

@end

@interface PingjiaHeadCell()
{
    UIImageView *icon;
    UILabel *lab2;
}
@end

@implementation PingjiaHeadCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
	icon = [[UIImageView alloc]init];
	icon.frame = CGRectMake(15, 5, 60, 60);
	[self.contentView addSubview:icon];
    
    lab2 = [self createLabel:@"" color:COLOR_999 font:Font_Size_14];
    lab2.frame = CGRectMake(90, 0, SCREEN_WIDTH-100, 70);
    [self.contentView addSubview:lab2];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
	[icon setWebImageWithUrl:StrRelay(self.item.t1) placeHolder:nil];
	lab2.text = self.item.t2;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
