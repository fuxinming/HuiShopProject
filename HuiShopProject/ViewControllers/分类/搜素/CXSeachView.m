//
//  WSServiceSeachView.m
//  OMengMerchant
//
//  Created by ZhangQun on 2017/5/3.
//  Copyright © 2017年 shanjin. All rights reserved.
//

#import "CXSeachView.h"

@implementation CXSeachView
@synthesize seachTF;
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self initparameter];
    }
    return  self;
}
- (void)initparameter
{
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, StatusBarH, 50, 44);
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 15, 12, 15);
    leftBtn.tag= 100;
    [leftBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [rightBtn setTitleColor:COLOR_RED_ forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH-50, StatusBarH, 50, 44);
    rightBtn.tag= 101;
    [rightBtn addTarget:self action:@selector(SerchClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightBtn];
    
    UIView *BGView = [[UIView alloc]initWithFrame:CGRectMake(60, StatusBarH + 7, SCREEN_WIDTH - 120, 30)];
    BGView.backgroundColor =COLOR_ddd;
    BGView.layer.cornerRadius = 3;
    BGView.layer.masksToBounds = YES;
    [self addSubview:BGView];
    
    UIImageView *serchImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 18, 18)];
    serchImg.image = [UIImage imageNamed:@"search"];
    [BGView addSubview:serchImg];
    
    
    seachTF = [[UITextField alloc]initWithFrame:CGRectMake(33, 0,BGView.width -33 - 10, 30)];
    seachTF.placeholder = @"请输入商品名称或品牌";
    seachTF.font = Font_Size_14;
    seachTF.delegate = self;
//    [seachTF becomeFirstResponder];
    seachTF.clearButtonMode =UITextFieldViewModeAlways;
    seachTF.returnKeyType = UIReturnKeySearch;
	[seachTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [BGView addSubview:seachTF];
    
    
    self.actionBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    self.actionBar.backgroundColor = [UIColor whiteColor];
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:COLOR_RED_ forState:UIControlStateNormal];
    doneBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 0, 60, 30);
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.actionBar addSubview:doneBtn];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line1.backgroundColor = COLOR_ddd;
    [self.actionBar addSubview:line1];
    
    seachTF.inputAccessoryView = self.actionBar;
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.height - 0.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = COLOR_ddd;
    [self addSubview:line];
    
}

-(void)layoutSubviews{
    [super layoutSubviews];
    if (!ISEmptyStr(self.keyWord)) {
        seachTF.text = self.keyWord;
    }
}
- (void)SerchClick
{
    
    if ([seachTF.text trim].length > 0) {
        if (self.searchBtnPress) {
            self.searchBtnPress([seachTF.text trim]);
        }
        [seachTF resignFirstResponder];
    }else{
        Toast(@"搜索内容为空");
    }
}
-(void)textFieldDidChanged:(UITextField *)textField{
    [CommonUtil checkTextField:textField maxLen:100];
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.shouldEditPress) {
        self.shouldEditPress();
    }
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField.text trim].length > 0) {
        if (self.searchBtnPress) {
            self.searchBtnPress([textField.text trim]);
        }
        [textField resignFirstResponder];
    }
    return YES;
}

-(void)btnPress:(UIButton *)btn{
    
    if (self.btnClick) {
        self.btnClick(btn.tag);
    }
}

-(void)doneBtnClick{
    [seachTF resignFirstResponder];
}
@end


