//
//  WSMsgCell.m
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//

#import "ProductReasonSelectCell.h"


@implementation ProductReasonSelectItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 50;
    }
    return self;
}
@end

@interface ProductReasonSelectCell ()
{
}
@end
@implementation ProductReasonSelectCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.contentView.backgroundColor = [UIColor whiteColor];;
    self.backgroundColor = [UIColor whiteColor];
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
    WS(bself);
    [self.contentView removeAllSubviews];

	UIButton *selbtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[selbtn setImage:[UIImage imageNamed:@"fuxuankuangNO"] forState:UIControlStateNormal];
	[selbtn setImage:[UIImage imageNamed:@"fuxuankuangYES"] forState:UIControlStateSelected];
	selbtn.frame = CGRectMake(0, 0, 50, 50);
	selbtn.imageEdgeInsets = UIEdgeInsetsMake(17, 17, 17, 17);
	[selbtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	selbtn.tag = 100;
	if(self.item.isdeSelect){
		selbtn.selected = YES;
	}else{
		selbtn.selected = NO;
	}
	[self.contentView addSubview:selbtn];
	
	UILabel*lab1 = [self createLabel:self.item.t1 color:COLOR_333 font:Font_Size_13];
	[lab1 sizeToFit];
	lab1.frame = CGRectMake(60, 15, lab1.width, 20);
	[self.contentView addSubview:lab1];
}

-(void)btnClick:(UIButton *)btn{
	if(self.item.selectionHandler){
		self.item.selectionHandler(self.item);
	}
}
@end
