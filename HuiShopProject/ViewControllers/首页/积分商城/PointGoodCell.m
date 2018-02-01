//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "PointGoodCell.h"

@implementation PointGoodItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 65;
    }
    return self;
}

@end

@interface PointGoodCell()
{
}
@end

@implementation PointGoodCell
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
    float w = SCREEN_WIDTH/2 - 2.5;
    for (int i=0; i < self.item.eventArr.count; i++) {
        col = i%2;
        if (i/2 > row) {
            row++;
        }
        NSDictionary *dict = [self.item.eventArr objectAtIndex:i];
		
		UIView *conView = [[UIView alloc]initWithFrame:CGRectMake(0,0,0,0)];
		conView.backgroundColor = [UIColor whiteColor];
		[self.contentView addSubview:conView];
		
		
        
        UIImageView *icon = [[UIImageView alloc]init];
        [icon setWebImageWithUrl:StrRelay(dict[@"picUrl"]) placeHolder:nil];
        [conView addSubview:icon];
        
        UILabel *titleLabel = [self createLabel:StrRelay(dict[@"goodsName"]) color:COLOR_333 font:Font_Size_14];
        [conView addSubview:titleLabel];
		
        NSMutableAttributedString *str1 = [CommonUtil mutableStringAppendString:[NSString stringWithFormat:@"%@",StrRelay(dict[@"consumption"])].color(COLOR_RED_).font(Font_Size_15)];
        str1.append(@"  积分".color(COLOR_999).font(Font_Size_13));
        UILabel *priceLabel = [self createLabel:@"" color:COLOR_RED_ font:Font_Size_12];
        priceLabel.attributedText = str1;
        [conView addSubview:priceLabel];
		
		UIButton *btn = [self createBtn:nil color:Color_Clear font:Font_Size_15 tag:i];
		btn.backgroundColor = [UIColor clearColor];
		btn.userinfo = dict;
		[self.contentView addSubview:btn];
		
		conView.frame =CGRectMake(col*(w+5),(w+5)*row, w, w);
        btn.frame =CGRectMake(col*(w+5),(w+5)*row, w, w);
        icon.frame = CGRectMake((w-100)/2, 10, 100, 100);
        titleLabel.frame = CGRectMake(10, icon.bottom +4, w-20, 18);
        priceLabel.frame = CGRectMake(10, titleLabel.bottom +13, w/2-10, 18);
    }
    
    self.item.cellHeight = (row+1)*(w + offset);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
-(void)btnClick:(UIButton *)btn{
	if (self.item.mybtnClick) {
		self.item.mybtnClick(btn.userinfo);
	}
}
@end
