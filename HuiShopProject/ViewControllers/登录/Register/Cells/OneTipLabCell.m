//
//  WSMsgCell.m
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//

#import "OneTipLabCell.h"


@implementation OneTipLabItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 68;
        self.textFont = Font_Size_14;
        self.textColor = COLOR_666;
    }
    return self;
}
@end

@interface OneTipLabCell ()
{
    
}
@end
@implementation OneTipLabCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
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
    
    [self.contentView removeAllSubviews];
    self.contentView.backgroundColor = self.item.cellBgColor;
    WS(bself);
    float alleight = 0;
    float offset = 5;
    for (int i=0; i < self.item.tipArray.count; i++) {
        NSString *t = [self.item.tipArray objectAtIndex:i];
        UILabel *nameLab = [self createLabel:t color:self.item.textColor font:self.item.textFont];
        nameLab.textAlignment = self.item.textAlignment;
        nameLab.numberOfLines = 0;
        float height = [CommonUtil heightForFont:t Font:self.item.textFont CtrlSize:CGSizeMake(self.item.width, 2000)];
        nameLab.frame = CGRectMake((SCREEN_WIDTH - self.item.width)/2, alleight, self.item.width, height);
        alleight += nameLab.height;
        alleight+=offset;
        [self.contentView addSubview:nameLab];
    }
    self.item.cellHeight =alleight + offset;
}
@end
