//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "MineHeadCell.h"

@implementation MineHeadItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = StatusBarH + 180;
        self.bgColor = [UIColor clearColor];
    
    }
    return self;
}

@end

@interface MineHeadCell()
{
    UIButton *headBtn;
    
    UILabel *nickName;
    UILabel *phoneLab;
}
@end

@implementation MineHeadCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    
    UILabel *tLab = [self createLabel:@"我的惠七天" color:[UIColor whiteColor] font:Font_Size_16];
    tLab.frame = CGRectMake(0, StatusBarH + 13, SCREEN_WIDTH, 22);
    tLab.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:tLab];
    
    UIButton *settBtn = [self createImgBtn:@"" tag:101];
	[settBtn setImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    settBtn.frame = CGRectMake(SCREEN_WIDTH - 50,  + 50, 50, 50);
	settBtn.imageEdgeInsets = UIEdgeInsetsMake(14, 14, 14, 14);
    [self.contentView addSubview:settBtn];
    
	headBtn = [self createImgBtn:@"deafaultavatar" tag:100];
    headBtn.frame = CGRectMake(13, 78 + StatusBarH, 66, 66);
    headBtn.layer.masksToBounds = YES;
    headBtn.layer.cornerRadius = 33;
    [self.contentView addSubview:headBtn];
    
    nickName = [self createLabel:@"请登录" color:[UIColor whiteColor] font:Font_Size_16];
    nickName.frame = CGRectMake(headBtn.right + 18, headBtn.top + 13, SCREEN_WIDTH - headBtn.right - 34, 20);
    [self.contentView addSubview:nickName];
    
    phoneLab = [self createLabel:nil color:[UIColor whiteColor] font:Font_Size_16];
    phoneLab.frame = CGRectMake(headBtn.right + 18, nickName.bottom, SCREEN_WIDTH - headBtn.right - 34, 20);
    [self.contentView addSubview:phoneLab];
    
    UIImageView *rightArr = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 13, headBtn.top + 25.5, 15, 15)];
    rightArr.image = [UIImage imageNamed:@"rightArr"];
    [self.contentView addSubview:rightArr];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
    self.contentView.backgroundColor = self.item.bgColor;
    nickName.text = self.item.nameText;
    phoneLab.text = self.item.phoneText;
    if (ISEmptyStr(self.item.nameText)) {
        phoneLab.frame = CGRectMake(headBtn.right + 18, headBtn.top + 23, SCREEN_WIDTH - headBtn.right - 34, 20);
	}else{
		phoneLab.frame = CGRectMake(headBtn.right + 18, headBtn.top + 33, SCREEN_WIDTH - headBtn.right - 34, 20);
	}
    if (ISEmptyStr(self.item.nameText) && ISEmptyStr(self.item.phoneText)) {
        phoneLab.frame = CGRectMake(headBtn.right + 18, headBtn.top + 23, SCREEN_WIDTH - headBtn.right - 34, 20);
        phoneLab.text = @"请点击登录";
    }
    UIImage *placeholder = [UIImage imageNamed:@"deafaultavatar"];
    if ([[CommonUtil strRelay:self.item.imgText] hasPrefix:@"http"]) {
        [headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.item.imgText] forState:UIControlStateNormal];
    } else {
        [headBtn setBackgroundImage:placeholder forState:UIControlStateNormal];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
