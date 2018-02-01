//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "OneTextInputCell.h"

@implementation OneTextInputItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 40;
        self.isSecret = NO;
        self.keyboardType = UIKeyboardTypeDefault;
    }
    return self;
}

@end

@interface OneTextInputCell()<UITextFieldDelegate>
{
    UIButton *rightBtn;
}
@end

@implementation OneTextInputCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
  
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(14, 0, SCREEN_WIDTH - 28, 40)];
    _textField.font = Font_Size_15;
    _textField.backgroundColor = COLOR_ddd;
    _textField.layer.cornerRadius = 5;
    _textField.layer.masksToBounds = YES;
    _textField.delegate = self;
    _textField.textColor = COLOR_333;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 40)];
    _textField.leftView = paddingView;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:_textField];
    
    rightBtn = [self createImgBtn:nil tag:100];
    rightBtn.hidden = YES;
    rightBtn.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    [self.contentView addSubview:rightBtn];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
    
    _textField.keyboardType = self.item.keyboardType;
    _textField.placeholder = [CommonUtil strRelay:self.item.placeholder];
    _textField.text = self.item.value;
    if (self.item.isSecret) {
        _textField.secureTextEntry = YES;
    }else{
        _textField.secureTextEntry = NO;
    }
    
    if (!ISEmptyStr(self.item.rightImage)) {
        rightBtn.hidden = NO;
        
        rightBtn.frame = CGRectMake(SCREEN_WIDTH - 65, 0, 40, 40);
        if (self.item.isSecret) {
            [rightBtn setImage:[UIImage imageNamed:self.item.rightImage1] forState:UIControlStateNormal];
    
        }else{
            [rightBtn setImage:[UIImage imageNamed:self.item.rightImage] forState:UIControlStateNormal];
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(void)textFieldDidChange:(UITextField *)textV {
    [CommonUtil checkTextField:_textField maxLen:self.item.maxLenth];
    self.item.value = textV.text;
    if(self.item.textValueChanged){
        self.item.textValueChanged(textV.text);
    }
}

-(void)btnClick:(UIButton *)btn{
    self.item.isSecret = !self.item.isSecret;
    if (self.item.isSecret) {
        _textField.secureTextEntry = YES;
    }else{
        _textField.secureTextEntry = NO;
    }
    
    if (self.item.isSecret) {
        [rightBtn setImage:[UIImage imageNamed:self.item.rightImage1] forState:UIControlStateNormal];
        
    }else{
        [rightBtn setImage:[UIImage imageNamed:self.item.rightImage] forState:UIControlStateNormal];
    }
}
@end
