//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RecommandYouCell.h"

@implementation RecommandYouItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 11000;
    }
    return self;
}

@end

@interface RecommandYouCell()
{
}
@end

@implementation RecommandYouCell
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
    
    
    float w = (SCREEN_WIDTH - 10)/3;
    float w2 = (SCREEN_WIDTH - 5)/2;

    for (int i=0; i < self.item.eventArr.count; i++) {

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

        if (i < 3) {
            btn.frame =CGRectMake((5+w)*i, 0, w, w);
            icon.frame = CGRectMake((w-70)/2, 10, 70, 70);
            titleLabel.frame = CGRectMake(10, icon.bottom , w-20, 18);
            priceLabel.frame = CGRectMake(10, titleLabel.bottom , w-20, 18);
        }else{
            btn.frame =CGRectMake((5+w2)*(i-3), w + 5, w2, w);
            icon.frame = CGRectMake(w2-70, (w-50)/2, 50, 50);
            titleLabel.frame = CGRectMake(10, icon.top, w2-80, 25);
            priceLabel.frame = CGRectMake(10, titleLabel.bottom, w2-80, 25);
        }
    }
    
    self.item.cellHeight = w*2+5;
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
