//
//  FMNavBar.m
//  FMBaseProject
//
//  Created by shanjin on 2016/10/10.
//  Copyright © 2016年 付新明. All rights reserved.
//

#import "ConditionSiftBar1.h"
#import "FMButton.h"



@implementation ConditionSiftBar1{
}

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.backgroundColor = [UIColor whiteColor];
        float w = SCREEN_WIDTH/4;
        NSArray *tArr = @[@"销量",@"口碑",@"价格",@"距离"];
        NSArray *cArr = @[@"qty",@"score",@"price",@"distance"];
        for (int i = 0; i < tArr.count; i ++) {
            FMButton *btn1 = [[FMButton alloc] initWithFrame:CGRectMake(w*i,0, w, self.height)];
            btn1.tag = 100+i;
            btn1.selected = NO;
            btn1.userInfo = cArr[i];
            [btn1 addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:btn1];
            
            UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 12, 12)];
            img1.image = [UIImage imageNamed:@"siftNormal"];
            [btn1 addSubview:img1];
            
            UILabel *label = [[UILabel alloc] init];
            label.text = tArr[i];
            label.textColor = COLOR_333;
            label.font = Font_Size_13;
            label.tag = 201;
            [label sizeToFit];
            label.frame = CGRectMake((btn1.width - label.width - 5 - 8)/2, 11, label.width, 20);
            
            img1.frame = CGRectMake(label.right + 5, 15, 12, 12);
            img1.tag = 202;
            [btn1 addSubview:label];
            
            if (i == 0) {
                label.textColor = COLOR_RED_;
                img1.image = [UIImage imageNamed:@"upSanjiao"];
                btn1.selected = YES;
            }
        }
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.height-0.5, SCREEN_WIDTH, 0.5)];
        lineView.backgroundColor = COLOR_ddd;
        [self addSubview:lineView];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
}
-(void)btnPress:(FMButton *)btn{
    for (UIView *v in self.subviews) {
        if([v isKindOfClass:[FMButton class]]){
            if (v.tag == btn.tag) {
                if (!btn.selected) {
                    FMButton *vb = (FMButton *)v;
                    UILabel *lab = [vb viewWithTag:201];
                    lab.textColor = COLOR_RED_;
                    
                    UIImageView *img = [vb viewWithTag:202];
                    img.image = [UIImage imageNamed:@"upSanjiao"];
                    btn.selected = YES;
                    
                    if (self.rightBtnClick) {
                        self.rightBtnClick(btn.userInfo);
                    }
                }
                
            }else{
                FMButton *vb = (FMButton *)v;
                UILabel *lab = [vb viewWithTag:201];
                lab.textColor = COLOR_333;
                
                UIImageView *img = [vb viewWithTag:202];
                img.image = [UIImage imageNamed:@"siftNormal"];
                btn.selected = NO;
            }
        }
    }
}



@end
