//
//  FMSwipeCell.m
//  SwipeCell
//
//  Created by Steven on 15/12/17.
//  Copyright © 2015年 Steven. All rights reserved.
//

#import "FMBaseCell.h"

@implementation FMBaseItem

- (instancetype)init
{
    self = [super init];
    if (self) {
    }    
    return self;
}

@end



@interface FMBaseCell()
{
}
@end

@implementation FMBaseCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    
}

- (UILabel *)createLabel:(NSString *)text color:(UIColor *)color font:(UIFont *)font {
    
    UILabel *label = [[UILabel alloc] init];
    label.text = text;
    label.textColor = color;
    label.font = font;
    label.backgroundColor = [UIColor clearColor];
    
    return label;
}
- (UIButton *)createBtn:(NSString *)title  color:(UIColor *)color font:(UIFont *)font tag:(int)tag {
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:color forState:UIControlStateNormal];
    [btn.titleLabel setFont:font];
    btn.tag = tag;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}
- (UIButton *)createImgBtn:(NSString *)img tag:(int)tag{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:img] forState:UIControlStateNormal];
    btn.tag = tag;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    return btn;
}
-(void)btnClick:(UIButton *)btn{
    if (self.item.btnClick) {
        self.item.btnClick(btn.tag);
    }
    if (self.btnClick) {
        self.btnClick(btn.tag);
    }
}
@end
