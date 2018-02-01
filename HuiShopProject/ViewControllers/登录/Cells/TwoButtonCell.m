//
//  WSFormTextCell.m
//  OMengMerchant
//
//  Created by jienliang on 14-5-9.
//  Copyright (c) 2014年 YK. All rights reserved.
//

#import "TwoButtonCell.h"

@implementation TwoButtonItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 38;
        self.btn1AlignMent = UIControlContentHorizontalAlignmentCenter;
        self.btn2AlignMent = UIControlContentHorizontalAlignmentCenter;
    }
    return self;
}

@end

@interface TwoButtonCell()
{
}
@end

@implementation TwoButtonCell
@dynamic item;
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
    self.contentView.backgroundColor = self.item.cellBgColor;
    
    if (!ISEmptyStr(self.item.title1Text)) {
        UIButton *btn1 = [self createBtn:self.item.title1Text color:self.item.title1Color font:self.item.title1Font tag:100];
        [self.contentView addSubview:btn1];
        btn1.frame = self.item.btn1Frame;
        btn1.contentHorizontalAlignment = self.item.btn1AlignMent;
    }
    
    if (!ISEmptyStr(self.item.title2Text)) {
        UIButton *btn2 = [self createBtn:self.item.title2Text color:self.item.title2Color font:self.item.title2Font tag:101];
        [self.contentView addSubview:btn2];
        btn2.frame = self.item.btn2Frame;
        btn2.contentHorizontalAlignment = self.item.btn2AlignMent;
    }
    
    self.item.cellHeight = self.item.btn1Frame.size.height;

}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
