//
//  PopBottomView.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/9.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "PopBottomView1.h"
@interface PopBottomView1(){
	UIView *tapView;
}

@end

@implementation PopBottomView1

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        [self setupDefault];
    }
    return self;
}

- (void)setupDefault
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
	
	self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
	
	tapView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 0.5)];
	tapView.backgroundColor = Color_Clear;
	[self addSubview:tapView];
	UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
	tap.numberOfTapsRequired = 1;
	tap.numberOfTouchesRequired = 1;
	[tapView addGestureRecognizer:tap];
}

- (void)showContentView:(UIView *)contentView {
    [self addSubview:contentView];
	tapView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - contentView.height);
	[[[UIInputViewController alloc]init]dismissKeyboard];
	[[UIApplication sharedApplication].keyWindow addSubview:self];
	
}

- (void)remove{
    [self removeFromSuperview];
}

- (void)tapAction:(UITapGestureRecognizer *)sender{
    [self remove];
    
}
@end
