//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "PhoneCodeInputCell.h"

@implementation PhoneCodeInputItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 40;
        
        self.keyboardType = UIKeyboardTypeDefault;
    }
    return self;
}

@end

@interface PhoneCodeInputCell()<UITextFieldDelegate>
{
    UIButton *rightBtn;
}
@end

@implementation PhoneCodeInputCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor clearColor];
    self.t = 60;

    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(13, 0, SCREEN_WIDTH - 140 - 13 - 13 - 10, 40)];
    _textField.font = Font_Size_15;
    _textField.backgroundColor = COLOR_ddd;
    _textField.layer.cornerRadius = 5;
    _textField.layer.masksToBounds = YES;
    _textField.delegate = self;
    _textField.textColor = COLOR_333;
    UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 40)];
    _textField.leftView = paddingView;
    _textField.leftViewMode = UITextFieldViewModeAlways;
    _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:_textField];
    
    rightBtn = [self createBtn:@"获取短信验证码" color:COLOR_RED_ font:Font_Size_15 tag:100];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH - 140 - 13, 0, 140, 40);
    View_Border_Radius(rightBtn, 5, 0.5, COLOR_RED_);
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

	
	if (_time) {
		rightBtn.enabled = YES;
		[rightBtn setTitle:@"获取短信验证码" forState:UIControlStateNormal];
		[_time invalidate];
		_time= nil;
	}
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(void)textFieldDidChange:(UITextField *)textV {
    [CommonUtil checkTextField:_textField maxLen:self.item.maxLenth];
    self.item.value = textV.text;
}

-(void)btnClick:(UIButton *)btn{
    WS(bself);
    [self endEditing:YES];
    
    _time = [NSTimer scheduledTimerWithTimeInterval:1 target:bself selector:@selector(timerStart) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:_time forMode:NSRunLoopCommonModes];
    [self getMessage];
}

- (void)timerStart {
    self.t = self.t - 1;
    if (self.t <= 1) {
        rightBtn.enabled = YES;
        [rightBtn setTitle:@"获取短信验证码" forState:UIControlStateNormal];
        [_time invalidate];
        _time= nil;
        self.t = 60;
    }
    else{
        rightBtn.enabled = NO;
        [rightBtn setTitle:[NSString stringWithFormat:@"%ds后获取验证码",self.t] forState:UIControlStateNormal];
    }
    
    [rightBtn setNeedsDisplay];
}

-(void)getMessage{
    FMBlock(self.item.getPhoneCode);
}
-(void)dealloc{
    _time= nil;
}
@end
