//
//  WSFormTextCell.m
//  OMengMerchant
//
//  Created by jienliang on 14-5-9.
//  Copyright (c) 2014年 YK. All rights reserved.
//

#import "OneButtonCell.h"

@implementation OneButtonItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 38;
        self.btnFrame = CGRectMake(14, 0, SCREEN_WIDTH - 28, 38);
    }
    return self;
}

@end

@interface OneButtonCell()
{
    UIButton *btn;
}
@end

@implementation OneButtonCell
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    
    btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.layer.cornerRadius = 4;
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnPress) forControlEvents:UIControlEventTouchUpInside];
    btn.layer.masksToBounds = YES;
    [self.contentView addSubview:btn];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
    btn.frame = self.item.btnFrame;
    [btn setTitle:self.item.titleText forState:UIControlStateNormal];
    btn.backgroundColor = self.item.bgColor;
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
