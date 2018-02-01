//
//  WSMsgCell.m
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//

#import "MainMenuCell.h"


@implementation MainMenuItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 124;
    }
    return self;
}
@end

@interface MainMenuCell ()
{
    
}
@end
@implementation MainMenuCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}
- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    [self.contentView removeAllSubviews];
    float l = (SCREEN_WIDTH - (45 * 5))/6;
    NSArray *titleArr = @[@"附近商店",@"每日签到",@"进口食品",@"积分商城",@"浏览记录"];
    NSArray *imgArr = @[@"menu_fujin",@"menu_day",@"menu_food",@"menu_jifen",@"menu_jilu"];
    for (int i = 0; i < titleArr.count; i ++) {
        UIImageView *icon = [[UIImageView alloc]initWithFrame:CGRectMake(l+ (45+ l)*i, 30, 45, 45)];
        icon.image = [UIImage imageNamed:imgArr[i]];
        [self.contentView addSubview:icon];
        
		UILabel *nameLab = [self createLabel:titleArr[i] color:COLOR_333 font:Font_Size_13];
		nameLab.frame = CGRectMake(icon.left - l/2, icon.bottom + 5, icon.width+l, 20);
        nameLab.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:nameLab];
        
        
        UIButton *btn = [self createImgBtn:@"" tag:100+i];
        btn.frame = CGRectMake(l+ (45+ l)*i, 0, 45, 124);
        [self.contentView addSubview:btn];

    }
    
}
@end
