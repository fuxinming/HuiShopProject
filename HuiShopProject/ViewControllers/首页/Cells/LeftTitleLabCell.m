//
//  WSMsgCell.m
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//

#import "LeftTitleLabCell.h"


@implementation LeftTitleLabItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 40;
        self.textColor = COLOR_333;
    }
    return self;
}
@end

@interface LeftTitleLabCell ()
{
    UILabel *nameLab;
}
@end
@implementation LeftTitleLabCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    nameLab = [self createLabel:@"" color:COLOR_333 font:Font_Size_14];
    nameLab.frame = CGRectMake(15, 0, SCREEN_WIDTH - 15*2, 36);
    [self.contentView addSubview:nameLab];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}
- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    nameLab.text = self.item.titleText;
    nameLab.height = self.item.cellHeight;
    nameLab.textAlignment = self.item.textAlignment;
    nameLab.textColor = self.item.textColor;
}
@end
