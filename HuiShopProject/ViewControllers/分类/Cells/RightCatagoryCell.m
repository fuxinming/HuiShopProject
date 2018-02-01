//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RightCatagoryCell.h"
#import "FMButton.h"
#import "CatListViewController.h"
@implementation RightCatagoryItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 65;
    }
    return self;
}

@end

@interface RightCatagoryCell()
{
}
@end

@implementation RightCatagoryCell
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
    
    UILabel *nameLable = [self createLabel:self.item.typeName color:COLOR_333 font:Font_Size_14];
    nameLable.frame = CGRectMake(0, 0, SCREEN_WIDTH*0.75, 45);
    nameLable.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:nameLable];
    
    UIView *bgView = [[UIView alloc]initWithFrame:CGRectMake(10, 45, SCREEN_WIDTH*0.75 -20, 100)];
    bgView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:bgView];
    
    int row = 0;
    int col = 0;
    float width = (SCREEN_WIDTH*0.75 -20)/ 3;
    float h = 100;
    for (int i=0; i < self.item.eventArr.count; i++) {
        col = i%3;
        if (i/3 > row) {
            row++;
        }
        NSDictionary *dict = [self.item.eventArr objectAtIndex:i];
        NSString *str = dict[@"name"];
        
		UIView *conView = [[UIView alloc]initWithFrame:CGRectMake(col*width+10,row*h + 45, width, h)];
		conView.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:conView];
		
        
        UIView *imgbgView = [[UIView alloc]initWithFrame:CGRectMake(12, 12, width - 24, width - 24)];
        imgbgView.backgroundColor = [UIColor clearColor];
        View_Border_Radius(imgbgView, 4, 0.5, COLOR_ddd);
        [conView addSubview:imgbgView];
        
        UIImageView *img = [[UIImageView alloc]initWithFrame:CGRectMake(14, 14, width - 28, width - 28)];
        [img setWebImageWithUrl:dict[@"picUrl"] placeHolder:[UIImage imageNamed:@""]];
        [conView addSubview:img];
        
        
        UILabel *titleLabel = [self createLabel:str color:COLOR_666 font:Font_Size_12];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.frame = CGRectMake(0,img.bottom + 5, conView.width, 20);
        [conView addSubview:titleLabel];
        
		FMButton *btn = [[FMButton alloc]init];
		btn.userInfo = dict;
		btn.frame =CGRectMake(col*width+10,row*h + 45, width, h);
		btn.backgroundColor = [UIColor clearColor];
		[btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:btn];
    }
    
    self.item.cellHeight =(row+1)*h + 45;
    bgView.height = (row+1)*h;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
-(void)btnClicked:(FMButton *)btn{
	CatListViewController *vc = [[CatListViewController alloc]init];
	vc.userinfo = btn.userInfo;
	RootNavPush(vc);
}
@end
