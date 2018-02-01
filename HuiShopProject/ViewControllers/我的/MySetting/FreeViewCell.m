//
//  WSFormTextCell.m
//  OMengMerchant
//
//  Created by jienliang on 14-5-9.
//  Copyright (c) 2014年 YK. All rights reserved.
//

#import "FreeViewCell.h"

@implementation FreeViewItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 38;
		self.bgColor = Color_Clear;
    }
    return self;
}

@end

@interface FreeViewCell()
{

}
@end

@implementation FreeViewCell
- (void)cellDidLoad
{
    [super cellDidLoad];
	self.backgroundColor = [UIColor clearColor];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
	[self.contentView removeAllSubviews];
	self.contentView.backgroundColor = self.item.bgColor;
	[self.contentView addSubview:self.item.freeView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}


@end
