//
//  WSMsgCell.m
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//

#import "LeftCatagoryTitleCell.h"


@implementation LeftCatagoryTitleItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 50;
    }
    return self;
}
@end

@interface LeftCatagoryTitleCell ()
{
    UILabel *nameLab;
}
@end
@implementation LeftCatagoryTitleCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    nameLab = [self createLabel:@"" color:COLOR_333 font:Font_Size_14];
    nameLab.frame = CGRectMake(15, 0, SCREEN_WIDTH/4 - 15, 50);
    [self.contentView addSubview:nameLab];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, 49.5, SCREEN_WIDTH/4, 0.5)];
    line.backgroundColor = COLOR_ddd;
    [self.contentView addSubview:line];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    if (selected) {
        self.contentView.backgroundColor = COLOR_BACKGROUND;
        nameLab.textColor = COLOR_RED_;
        
    }else{
        self.contentView.backgroundColor = [UIColor whiteColor];
        nameLab.textColor = COLOR_333;
    }
}
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

}
@end
