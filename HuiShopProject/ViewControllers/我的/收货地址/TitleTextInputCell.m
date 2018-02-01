//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "TitleTextInputCell.h"

@implementation TitleTextInputItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 40;
    }
    return self;
}

@end

@interface TitleTextInputCell()<UITextFieldDelegate>
{
    UILabel *tLab;
	
}
@end

@implementation TitleTextInputCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
	
	tLab = [[UILabel alloc]init];
	tLab.font = Font_Size_15;
	tLab.textColor = COLOR_333;
	[self.contentView addSubview:tLab];
	
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(14, 0, SCREEN_WIDTH - 28, 40)];
    _textField.font = Font_Size_15;
    _textField.delegate = self;
	_textField.keyboardType = UIKeyboardTypeDefault;
    _textField.textColor = COLOR_333;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 40)];
    _textField.leftView = paddingView;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
	[self.contentView addSubview:_textField];
	
	UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(14, 39.5, SCREEN_WIDTH - 14, 0.5)];
	lineView.backgroundColor = COLOR_ddd;
	[self.contentView addSubview:lineView];
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
	tLab.text = self.item.titleText;
	tLab.width = 80;
	tLab.frame = CGRectMake(15, 0, tLab.width, 40);
	
//    _textField.keyboardType = self.item.keyboardType;
    _textField.placeholder = [CommonUtil strRelay:self.item.placeholder];
    _textField.text = self.item.value;
	_textField.frame = CGRectMake(tLab.right + 5, 0, SCREEN_WIDTH - 35 - tLab.width, 40);
	_textField.keyboardType = self.item.keyboardType;
	
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
@end
