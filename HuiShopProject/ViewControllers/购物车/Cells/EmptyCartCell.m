//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "EmptyCartCell.h"

@implementation EmptyCartItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = SCREEN_HEIGHT - NavigationBarH - TabBarH;
    }
    return self;
}

@end

@interface EmptyCartCell()
{
}
@end

@implementation EmptyCartCell
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
    
    UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake((SCREEN_WIDTH - 30)/2, (self.item.cellHeight - 120)/2, 30, 30)];
    [icon setImage:[UIImage imageNamed:@"icon_shoppingCart"]];
    [self.contentView addSubview:icon];
    
    UILabel *titleLabel = [self createLabel:@"购物车还是空的 \n 去挑选中意的商品吧" color:COLOR_999 font:Font_Size_13];
    titleLabel.frame = CGRectMake(0, icon.bottom+4, SCREEN_WIDTH, 44);
    titleLabel.numberOfLines = 0;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:titleLabel];
    
    UIButton *btn = [self createBtn:@"去逛逛" color:COLOR_333 font:Font_Size_14 tag:100];
    btn.backgroundColor = COLOR_999;
    btn.frame = CGRectMake((SCREEN_WIDTH - 65)/2, titleLabel.bottom+4, 65, 34);
    View_Border_Radius(btn, 4, 0, Color_Clear);
    View_Shadow(btn, 0.4, [UIColor blackColor], 3, CGSizeMake(2, 2));
    [self.contentView addSubview:btn];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
