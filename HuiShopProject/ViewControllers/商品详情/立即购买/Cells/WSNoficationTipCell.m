//
//  WSXuKeTextCell.m
//  OMengMerchant
//
//  Created by jienliang on 16/3/9.
//  Copyright © 2016年 shanjin. All rights reserved.
//

#import "WSNoficationTipCell.h"
@implementation WSNoficationTipItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 50;
        self.isOn = NO;
        self.hasLine = YES;
        self.hasTopLine = NO;
    }
    return self;
}
@end

@implementation WSNoficationTipCell{
    UILabel *captionLab;
    UIImageView *lineImg1;
    UIImageView *lineImg;
    UISwitch *switchBtn;
}
@synthesize imgLineDown;

- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor whiteColor];
    

    
    captionLab = [[UILabel alloc] initWithFrame:CGRectMake(15, 17.5, SCREEN_WIDTH, 15)];
    captionLab.font = Font_Size_14;
    captionLab.textColor = COLOR_333;
    captionLab.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:captionLab];
    
    switchBtn = [[UISwitch alloc] initWithFrame:CGRectMake(SCREEN_WIDTH-15-40, 10, 7, 12)];
    [switchBtn addTarget:self action:@selector(switchIsChange) forControlEvents:UIControlEventValueChanged];
    switchBtn.transform = CGAffineTransformMakeScale( .75, .75);
//    switchBtn.onTintColor = COLOR_RED_;
    [self.contentView addSubview:switchBtn];
    
	lineImg1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 49.5, SCREEN_WIDTH, 0.5)];
	lineImg1.backgroundColor = COLOR_ddd;
	[self.contentView addSubview:lineImg1];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    captionLab.text = [CommonUtil strRelay:self.item.titleText];
    lineImg.hidden = !self.item.hasLine;
    switchBtn.on = self.item.isOn;
    lineImg1.hidden = !self.item.hasTopLine;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)switchIsChange{
    if (self.item.swichBlock) {
        self.item.swichBlock(switchBtn.on);
    }
    self.item.isOn = switchBtn.on;
}

@end
