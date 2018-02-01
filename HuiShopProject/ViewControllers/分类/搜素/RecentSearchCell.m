//
//  WSFormTextCell.m
//  OMengMerchant
//
//  Created by jienliang on 14-5-9.
//  Copyright (c) 2014年 YK. All rights reserved.
//

#import "RecentSearchCell.h"

@implementation RecentSearchItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 50;
    
    }
    return self;
}

@end

@interface RecentSearchCell()
{
    UIButton *btn;
}
@end

@implementation RecentSearchCell
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    UILabel *nameLable = [self createLabel:@"最近搜索" color:COLOR_333 font:[UIFont boldSystemFontOfSize:14]];
    nameLable.frame = CGRectMake(15, 0, SCREEN_WIDTH/2, 50);
    [self.contentView addSubview:nameLable];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(btnPress) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"sousuoShanchu"] forState:UIControlStateNormal];
    btn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    btn.frame = CGRectMake(SCREEN_WIDTH - 50, 0, 50, 50);
    [self.contentView addSubview:btn];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)btnPress{
    if (self.item.btnPress) {
        self.item.btnPress();
    }
}
@end
