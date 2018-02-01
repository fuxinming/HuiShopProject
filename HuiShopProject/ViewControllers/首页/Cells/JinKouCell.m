//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "JinKouCell.h"

@implementation JinKouItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 11000;
    }
    return self;
}

@end

@interface JinKouCell()
{
}
@end

@implementation JinKouCell
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
    
    int row = 0;
    int col = 0;
    float offset = 5;
    float h = 90;
    float width = SCREEN_WIDTH/2 - 20;
    for (int i=0; i < self.item.eventArr.count; i++) {
        col = i%2;
        if (i/2 > row) {
            row++;
        }
        NSDictionary *dict = [self.item.eventArr objectAtIndex:i];
        UIButton *btn = [self createBtn:nil color:Color_Clear font:Font_Size_15 tag:i];
        btn.backgroundColor = [UIColor whiteColor];
		btn.userinfo = dict;
        [self.contentView addSubview:btn];
        
        UIImageView *icon = [[UIImageView alloc]init];
        [icon setWebImageWithUrl:StrRelay(dict[@"picUrl"]) placeHolder:nil];
        [btn addSubview:icon];
        
        UILabel *titleLabel = [self createLabel:StrRelay(dict[@"name"]) color:COLOR_333 font:Font_Size_12];
        [btn addSubview:titleLabel];
        
        NSMutableAttributedString *str1 = [CommonUtil mutableStringAppendString:@"￥".color(COLOR_RED_).font(Font_Size_10)];
        str1.append([NSString stringWithFormat:@"%.2f",DoubleRelay(dict[@"retailPrice"])].color(COLOR_RED_).font(Font_Size_12));
        
        UILabel *priceLabel = [self createLabel:@"" color:COLOR_RED_ font:Font_Size_12];
        priceLabel.attributedText = str1;
        [btn addSubview:priceLabel];
        
        btn.frame =CGRectMake(col*(SCREEN_WIDTH/2),(h+5)*row, width, h);
        icon.frame = CGRectMake(width-70, (h-50)/2, 50, 50);
        titleLabel.frame = CGRectMake(10, icon.top, width-80, 25);
        priceLabel.frame = CGRectMake(10, titleLabel.bottom, width-80, 25);
        
    }
    
    self.item.cellHeight = (row+1)*(h + offset);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
-(void)btnClick:(UIButton *)btn{
	if (self.item.selectProduct) {
		self.item.selectProduct(btn.userinfo);
	}
}
@end
