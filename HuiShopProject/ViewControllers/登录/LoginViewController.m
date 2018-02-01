//
//  MineViewController.m
//  HuiShopProject
//
//  Created by 付新明 on 2017/11/2.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "LoginViewController.h"
#import "OneTextInputCell.h"
#import "OneButtonCell.h"
#import "TwoButtonCell.h"
#import "RegisterViewController.h"
#import "ForgetPwdViewController.h"
@interface LoginViewController (){
    OneTextInputItem *itemPhone;
    OneTextInputItem *itemSec;
}

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.formTable.frame = CGRectMake(0,NavigationBarH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarH);
    self.navBar.title = @"账号登录";
    self.formManager[@"OneTextInputItem"] = @"OneTextInputCell";
    self.formManager[@"OneButtonItem"] = @"OneButtonCell";
    self.formManager[@"TwoButtonItem"] = @"TwoButtonCell";
    [self initForm];
}

-(void)initForm{
    WS(bself);
    NSMutableArray *sectionArray = [NSMutableArray array];
    RETableViewSection *section0 = [RETableViewSection section];
    
    [section0 addItem:[[FMEmptyItem alloc]initWithHeight:20 ]];
    
    itemPhone = [[OneTextInputItem alloc]init];
    itemPhone.maxLenth = 11;
    itemPhone.placeholder = @"手机号";
    itemPhone.keyboardType = UIKeyboardTypeNumberPad;
    [section0 addItem:itemPhone];
    
    [section0 addItem:[[FMEmptyItem alloc]initWithHeight:10 ]];
    
    itemSec = [[OneTextInputItem alloc]init];
    itemSec.maxLenth = 30;
    itemSec.placeholder = @"密码";
    itemSec.isSecret = YES;
    itemSec.rightImage = @"xianshidakai";
    itemSec.rightImage1 = @"xianshiguanbi";
    [section0 addItem:itemSec];
    
    [section0 addItem:[[FMEmptyItem alloc]initWithHeight:30 ]];
    
    
    OneButtonItem *btn = [[OneButtonItem alloc]init];
    btn.titleText = @"登录";
    btn.bgColor = COLOR_RED_;
    btn.btnPress = ^{
        [bself nextStep];
    };
    [section0 addItem:btn];
    
    TwoButtonItem *itemRe = [[TwoButtonItem alloc]init];
    itemRe.title1Text = @"忘记密码";
    itemRe.title1Color = COLOR_333;
    itemRe.title1Font = Font_Size_14;
    itemRe.btn1Frame = CGRectMake(13, 0, 85, 40);
    itemRe.btn1AlignMent = UIControlContentHorizontalAlignmentLeft;
    itemRe.title2Text = @"快速注册";
    itemRe.title2Color = COLOR_333;
    itemRe.title2Font = Font_Size_14;
    itemRe.btn2Frame = CGRectMake(SCREEN_WIDTH - 98, 0, 85, 40);
    itemRe.btn2AlignMent = UIControlContentHorizontalAlignmentRight;
    itemRe.btnClick = ^(NSInteger tag) {
        if (tag == 100) {
            ForgetPwdViewController *vc = [[ForgetPwdViewController alloc]init];
            RootNavPush(vc);
        }
        if (tag == 101) {
            RegisterViewController *vc = [[RegisterViewController alloc]init];
            RootNavPush(vc);
        }
    };
    [section0 addItem:itemRe];
    
    [sectionArray addObject:section0];
    [self.formManager replaceSectionsWithSectionsFromArray:sectionArray];
    [self.formTable reloadData];
}

-(void)nextStep{
    if (ISEmptyStr(itemPhone.value)) {
        Toast(@"请输入手机号码");
        return;
    }
    if (itemPhone.value.length < 11) {
        Toast(@"手机号码格式错误");
        return;
    }
    
    if (ISEmptyStr(itemSec.value)) {
        Toast(@"请输入密码");
        return;
    }
    [self login];
}

-(void)login{
    
    [AppUtil loginWith:StrRelay(itemPhone.value) andPass:StrRelay(itemSec.value) complete:^{
		RootNavPop(YES);
		FMBlock(self.saveSuccess);
    } andFail:^(id json) {
        
    }];
}
@end
