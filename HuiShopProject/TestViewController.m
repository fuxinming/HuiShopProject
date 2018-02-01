//
//  TestViewController.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/20.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "TestViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

-(UIView *)createLineView{
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = COLOR_ddd;
    [self.view addSubview:lineView];
    return lineView;
}
-(UILabel *)createLabel{
    UILabel *label = [[UILabel alloc] init];
    label.text = @"";
    label.textColor = COLOR_333;
    label.font = Font_Size_14;
    label.frame = CGRectMake(0, 0, 0, 0);
    [self.view addSubview:label];
    return label;
}
-(UILabel*)createAttributedTextLabel{
    NSMutableAttributedString *str1 = [CommonUtil mutableStringAppendString:@"英超".color(COLOR_RED_).font(Font_Size_12)];
    str1.append(@" | 09-05 20:07    310阅读".color(COLOR_999).font(Font_Size_12));
    UILabel *label = [[UILabel alloc] init];
    label.attributedText = str1;
    label.frame = CGRectMake(0, 0, 0, 0);
    [self.view addSubview:label];
    return label;
}
-(UIImageView *)createImageView{
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 0, 0)];
    img1.image = [UIImage imageNamed:@""];
    [self.view addSubview:img1];
    
    return img1;
}

-(UIButton *)createImageButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    btn.tag = 100;
    btn.frame = CGRectMake(0, 0, 0, 0);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    return btn;
}

-(UIButton *)createTitleButton{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"" forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_333 forState:UIControlStateNormal];
    [btn.titleLabel setFont:Font_Size_14];
    btn.tag = 100;
    btn.frame = CGRectMake(0, 0, 0, 0);
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    return btn;
}
-(void)CreateFor{
    for (int i = 0; i < self.myArr.count; i ++) {
        
    }
}
-(void)initForm{
	WS(bself);
    RETableViewSection *section0 = [RETableViewSection section];
    
    
    
    [self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
    [self.formTable reloadData];
	
}

-(void)btnClick:(UIButton *)btn{
}
@end
