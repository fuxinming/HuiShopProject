//
//  PopBottomView.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/9.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "PopBottomView.h"
@interface PopBottomView(){
    
}
@property(nonatomic, strong)UIVisualEffectView *effectView;
@property(nonatomic, strong)UIView *contenV;
@end

@implementation PopBottomView

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
    self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.backgroundColor = [UIColor clearColor];
    [self addSubview:self.effectView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [self.effectView addGestureRecognizer:tap];

}


- (UIVisualEffectView *)effectView
{
    if (!_effectView) {
        _effectView = [[UIVisualEffectView alloc]init];
        _effectView.effect = nil;
        _effectView.frame = self.frame;
        _effectView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        self.effectView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6];
    }
    return _effectView;
}



- (void)showContentView:(UIView *)contentView {
    [self addSubview:contentView];
    self.contenV = contentView;
    [[[UIInputViewController alloc]init]dismissKeyboard];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    CGPoint startPoint = CGPointMake(self.center.x, - CGRectGetHeight(contentView.frame));
    contentView.layer.position = startPoint;
	[UIView animateWithDuration:0.4 animations:^{
		contentView.layer.position = self.center;
	}];
//    [UIView animateWithDuration:0.75 delay:0 usingSpringWithDamping:0.5 initialSpringVelocity:1.0
//                        options:UIViewAnimationOptionCurveEaseIn
//                     animations:^{
////                         self.effectView.effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleExtraLight];
//
//                     } completion:nil];
	
}

- (void)remove{
    CGPoint endPoint = CGPointMake(self.center.x, CGRectGetHeight(self.frame) + CGRectGetHeight(self.contenV.frame));
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{

        self.effectView.effect = nil;
        self.contenV.layer.position = endPoint;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

- (void)tapAction:(UITapGestureRecognizer *)sender{
    [self remove];
    
}
@end
