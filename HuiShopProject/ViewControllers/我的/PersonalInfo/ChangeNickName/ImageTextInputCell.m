//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "ImageTextInputCell.h"

@implementation ImageTextInputItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 50;
        self.isSecret = NO;
        self.keyboardType = UIKeyboardTypeDefault;
        self.haveLine = YES;
    }
    return self;
}

@end

@interface ImageTextInputCell()<UITextFieldDelegate>
{
    UIImageView *leftImage;
    UIView *lineView;
}
@end

@implementation ImageTextInputCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
  
    leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(32, 15, 20, 20)];
    [self.contentView addSubview:leftImage];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(leftImage.right + 8, 0, SCREEN_WIDTH - 14 - 60, 50)];
    _textField.font = Font_Size_14;
    _textField.delegate = self;
    _textField.textColor = COLOR_333;
    [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:_textField];

    
    lineView = [[UIView alloc]initWithFrame:CGRectMake(60, 49.5, SCREEN_WIDTH - 60, 0.5)];
    lineView.backgroundColor = COLOR_ddd;
    [self.contentView addSubview:lineView];
    
    
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
    if(ISEmptyStr(self.item.leftImage)){
        leftImage.hidden = YES;
        _textField.frame = CGRectMake(35, 0, SCREEN_WIDTH - 10 - 35, 50);
        lineView.frame = CGRectMake(35, self.item.cellHeight - 0.5, SCREEN_WIDTH - 35, 0.5);
    }else{
        leftImage.hidden = NO;
        leftImage.image = [UIImage imageNamed:self.item.leftImage];
        _textField.frame = CGRectMake(60, 0, SCREEN_WIDTH - 14 - 60, 50);
        lineView.frame = CGRectMake(60, self.item.cellHeight - 0.5, SCREEN_WIDTH - 60, 0.5);
    }
    _textField.secureTextEntry = self.item.isSecret;
    _textField.keyboardType = self.item.keyboardType;
    _textField.placeholder = [CommonUtil strRelay:self.item.placeholder];
    _textField.text = self.item.value;
    
    lineView.hidden = !self.item.haveLine;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}

-(void)textFieldDidChange:(UITextField *)textV {
    [CommonUtil checkTextField:_textField maxLen:self.item.maxLenth];
    self.item.value = textV.text;
    if(self.item.textChange){
        self.item.textChange(textV.text);
    }
}

@end
