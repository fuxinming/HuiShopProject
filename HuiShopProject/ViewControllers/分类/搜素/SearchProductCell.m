//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "SearchProductCell.h"
#import "ProductDetailViewController.h"
@implementation SearchProductItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 65;
    }
    return self;
}

@end

@interface SearchProductCell()
{
}
@end

@implementation SearchProductCell
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
        
        UILabel *titleLabel = [self createLabel:StrRelay(dict[@"name"]) color:COLOR_333 font:Font_Size_12];
        [conView addSubview:titleLabel];
        
        UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
        img1.image = [UIImage imageNamed:@"marckrt"];
        [conView addSubview:img1];
        
        UILabel *marketLabel = [self createLabel:StrRelay(dict[@"marketName"]) color:COLOR_999 font:Font_Size_12];
        [conView addSubview:marketLabel];
        
        NSMutableAttributedString *str1 = [CommonUtil mutableStringAppendString:@"￥".color(COLOR_RED_).font(Font_Size_10)];
        str1.append([NSString stringWithFormat:@"%.2f",DoubleRelay(dict[@"retailPrice"])].color(COLOR_RED_).font(Font_Size_12));
        
        UILabel *priceLabel = [self createLabel:@"" color:COLOR_RED_ font:Font_Size_12];
        priceLabel.attributedText = str1;
        [conView addSubview:priceLabel];
        
        UILabel *disLabel = [self createLabel:[NSString stringWithFormat:@"%@千米",StrRelay(dict[@"distance"])] color:COLOR_999 font:Font_Size_11];
        [conView addSubview:disLabel];
		
		
		UIButton *btn = [self createBtn:nil color:Color_Clear font:Font_Size_15 tag:i];
		btn.backgroundColor = [UIColor clearColor];
		btn.userinfo = dict;
		[self.contentView addSubview:btn];
		
		conView.frame =CGRectMake(col*(w+5),(w+5)*row, w, w);
        btn.frame =CGRectMake(col*(w+5),(w+5)*row, w, w);
        icon.frame = CGRectMake((w-100)/2, 10, 100, 100);
        titleLabel.frame = CGRectMake(10, icon.bottom +3, w-20, 18);
        img1.frame = CGRectMake(10, titleLabel.bottom +3, 15, 15);
        marketLabel.frame = CGRectMake(img1.right+5, img1.top, w-20 - 20, 15);
        priceLabel.frame = CGRectMake(10, marketLabel.bottom +3, w/2-10, 18);
        disLabel.frame = CGRectMake(w/2, marketLabel.bottom +3 ,w/2-10, 18);
        
    }
    
    self.item.cellHeight = (row+1)*(w + offset);
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
-(void)btnClick:(UIButton *)btn{
	ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
	vc.userinfo = btn.userinfo;
	RootNavPush(vc);
}
@end
