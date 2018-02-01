//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "HeadImageCell.h"

@implementation HeadImageItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 60;
    
    }
    return self;
}

@end

@interface HeadImageCell()
{
    UIButton *headBtn;
    
    UILabel *rightLab;
}
@end

@implementation HeadImageCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    headBtn = [self createImgBtn:@"deafaultavatar" tag:100];
    headBtn.frame = CGRectMake(13, 7.5 , 45, 45);
    headBtn.layer.masksToBounds = YES;
    headBtn.layer.cornerRadius = 45/2;
    [self.contentView addSubview:headBtn];
    
    
    UIImageView *rightArr = [[UIImageView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH - 15 - 13, 45/2, 15, 15)];
    rightArr.image = [UIImage imageNamed:@"rightArr"];
    [self.contentView addSubview:rightArr];
    
    rightLab = [self createLabel:@"点击修改头像" color:COLOR_999 font:Font_Size_14];
    rightLab.frame = CGRectMake(rightArr.left - 110, 20, 100, 20);
    rightLab.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:rightLab];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(14, 59.5, SCREEN_WIDTH - 14, 0.5)];
    lineView.backgroundColor = COLOR_ddd;
    [self.contentView addSubview:lineView];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
    UIImage *placeholder = [UIImage imageNamed:@"deafaultavatar"];
    if ([[CommonUtil strRelay:self.item.imgText] hasPrefix:@"http"]) {
        [headBtn sd_setBackgroundImageWithURL:[NSURL URLWithString:self.item.imgText] forState:UIControlStateNormal placeholderImage:placeholder];
    } else {
        if (ISEmptyStr(self.item.imgText)) {
            [headBtn setBackgroundImage:placeholder forState:UIControlStateNormal];
        }else{
           [headBtn setBackgroundImage:[UIImage imageWithContentsOfFile:self.item.imgText] forState:UIControlStateNormal];
        }
        
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
