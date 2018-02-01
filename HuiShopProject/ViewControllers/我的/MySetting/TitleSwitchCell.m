//
//  FMFormTextCell.m
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "TitleSwitchCell.h"
#import "SwitchView.h"
@implementation TitleSwitchItem
- (id)init{
    if (self = [super init]) {
        self.cellHeight = 48;
        self.haveLine = YES;
        
    }
    return self;
}

@end

@interface TitleSwitchCell()
{
    UIImageView *leftImage;
    UILabel *lab1;
    UIView *lineView;
    
    SwitchView *myswitch;
}
@end

@implementation TitleSwitchCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.backgroundColor = [UIColor clearColor];
    self.contentView.backgroundColor = [UIColor whiteColor];
    
    leftImage = [[UIImageView alloc]init];
    [self.contentView addSubview:leftImage];
    
    lab1 = [self createLabel:@"" color:COLOR_333 font:Font_Size_14];
    lab1.frame = CGRectMake(0, 14, SCREEN_WIDTH/2, 18);
    lab1.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:lab1];
    
    lineView = [[UIView alloc]initWithFrame:CGRectMake(14, 47.5, SCREEN_WIDTH - 14, 0.5)];
    lineView.backgroundColor = COLOR_ddd;
    [self.contentView addSubview:lineView];
    
    myswitch = [[SwitchView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH -42 -14, (48-24)/2, 42, 24)];
    myswitch.backgroundColor = [UIColor clearColor];
    myswitch.tintColor = COLOR_999;
    myswitch.textColor = COLOR_333;
	myswitch.onText = @"开";
	myswitch.offText = @"关";
    myswitch.onTintColor = COLOR_RED_;
    myswitch.thumbTintColor = COLOR_GREEN;
    View_Border_Radius(myswitch, 24/2, 0.5, COLOR_999);
    [myswitch addTarget:self action:@selector(switchIsChange) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:myswitch];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}

- (void)cellWillAppear
{
    [super cellWillAppear];
    lab1.text = StrRelay(self.item.t1);
    [lab1 sizeToFit];
    
    if (ISEmptyStr(self.item.leftImage)) {
        lab1.frame = CGRectMake(14, 0, lab1.width, 48);
    }else{
        leftImage.image = [UIImage imageNamed:self.item.leftImage];
        leftImage.frame = CGRectMake(14, 14, 20, 20);
        lab1.frame = CGRectMake(leftImage.right + 14, 0, lab1.width, 48);
        lineView.frame = CGRectMake(48, 47.5, SCREEN_WIDTH - 14, 0.5);
    }
    myswitch.on = self.item.switchFlag;
    lineView.hidden = !self.item.haveLine;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
}
-(void)switchIsChange{
	self.item.switchFlag = myswitch.on;
	if (self.item.switchChange) {
		self.item.switchChange(myswitch.on,self.item);
	}
	
}
@end
