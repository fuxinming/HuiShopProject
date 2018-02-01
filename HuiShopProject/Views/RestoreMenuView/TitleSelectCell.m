//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "TitleSelectCell.h"

@implementation TitleSelectItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 60;
        self.haveLine = YES;
    }
    return self;
}

@end

@interface TitleSelectCell()
{
    UIImageView *leftImage;
    UILabel *lab1;
    UIView *lineView;
}
@end

@implementation TitleSelectCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    leftImage = [[UIImageView alloc]init];
    [self.contentView addSubview:leftImage];
    
    lab1 = [self createLabel:@"" color:COLOR_333 font:Font_Size_15];
    lab1.frame = CGRectMake(0, 14, SCREEN_WIDTH/2, 18);
    lab1.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:lab1];
    

    lineView = [[UIView alloc]initWithFrame:CGRectMake(14, 47.5, SCREEN_WIDTH - 14, 0.5)];
    lineView.backgroundColor = COLOR_ddd;
    [self.contentView addSubview:lineView];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    if(selected){
        leftImage.image = [UIImage imageNamed:self.item.leftSelectImage];
    }else{
        leftImage.image = [UIImage imageNamed:self.item.leftImage];
    }
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    lab1.text = StrRelay(self.item.t1);
    
    if (ISEmptyStr(self.item.leftImage)) {
        lab1.frame = CGRectMake(24, 20, self.parentTableView.width - 48, 20);
        lineView.frame = CGRectMake(24, self.item.cellHeight - 0.5, self.parentTableView.width - 24, 0.5);
    }else{
        leftImage.image = [UIImage imageNamed:self.item.leftImage];
        leftImage.frame = CGRectMake(14, 23, 14, 14);
        lab1.frame = CGRectMake(leftImage.right + 14, 20, self.parentTableView.width - leftImage.right - 24, 20);
        lineView.frame = CGRectMake(lab1.left, self.item.cellHeight - 0.5, self.parentTableView.width - lab1.left, 0.5);
    }
    

    lineView.hidden = !self.item.haveLine;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

@end
