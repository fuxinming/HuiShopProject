//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "TwoMenuCell.h"

@implementation TwoMenuItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 60;
    
    }
    return self;
}

@end

@interface TwoMenuCell()
{
    
    UILabel *lab1;
    UILabel *lab2;
    UILabel *lab3;
    UILabel *lab4;
}
@end

@implementation TwoMenuCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    lab1 = [self createLabel:@"" color:COLOR_333 font:Font_Size_15];
    lab1.frame = CGRectMake(0, 14, SCREEN_WIDTH/2, 18);
    lab1.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:lab1];
    
    lab2 = [self createLabel:@"" color:COLOR_999 font:Font_Size_13];
    lab2.frame = CGRectMake(0, lab1.bottom + 6, SCREEN_WIDTH/2, 15);
    lab2.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:lab2];
    
    
    
    lab3 = [self createLabel:@"" color:COLOR_333 font:Font_Size_15];
    lab3.frame = CGRectMake(SCREEN_WIDTH/2, 14, SCREEN_WIDTH/2, 18);
    lab3.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:lab3];
    
    lab4 = [self createLabel:@"" color:COLOR_999 font:Font_Size_13];
    lab4.frame = CGRectMake(SCREEN_WIDTH/2, lab3.bottom + 6, SCREEN_WIDTH/2, 15);
    lab4.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:lab4];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2,5, 1, 50)];
    lineView.backgroundColor = COLOR_ddd;
    [self.contentView addSubview:lineView];
    
    UIButton *settBtn1 = [self createImgBtn:@"" tag:100];
    settBtn1.frame = CGRectMake(0, 0, SCREEN_WIDTH/2, 60);
    [self.contentView addSubview:settBtn1];
    
    UIButton *settBtn2 = [self createImgBtn:@"" tag:101];
    settBtn2.frame = CGRectMake(SCREEN_WIDTH/2, 0, SCREEN_WIDTH/2, 60);
    [self.contentView addSubview:settBtn2];

    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
    lab1.text = StrRelay(self.item.t1);
    lab2.text = StrRelay(self.item.t2);
    lab3.text = StrRelay(self.item.t3);
    lab4.text = StrRelay(self.item.t4);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
