//
//  MineViewController.m
//  HuiShopProject
//
//  Created by 付新明 on 2017/11/2.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "RegisterViewController.h"
#import "OneButtonCell.h"
#import "OneTextInputCell.h"
#import "TwoButtonCell.h"
#import "PhoneCodeInputCell.h"
#import "SettingSecCodeViewController.h"
@interface RegisterViewController (){
    
}
@property (nonatomic,strong)OneTextInputItem *itemPhone;
@property (nonatomic,strong)PhoneCodeInputItem *codeItem;
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.title = @"快速注册";
    self.formTable.frame = CGRectMake(0,NavigationBarH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarH);
    
    self.formManager[@"OneButtonItem"] = @"OneButtonCell";
    self.formManager[@"OneTextInputItem"] = @"OneTextInputCell";
    self.formManager[@"TwoButtonItem"] = @"TwoButtonCell";
    self.formManager[@"PhoneCodeInputItem"] = @"PhoneCodeInputCell";
    [self initForm];
}

-(void)initForm{
    WS(bself);
    NSMutableArray *sectionArray = [NSMutableArray array];
    RETableViewSection *section0 = [RETableViewSection section];
    
    [section0 addItem:[[FMEmptyItem alloc]initWithHeight:20 ]];
    
    self.itemPhone = [[OneTextInputItem alloc]init];
    self.itemPhone.maxLenth = 11;
    self.itemPhone.placeholder = @"请输入手机号";
    self.itemPhone.keyboardType = UIKeyboardTypeNumberPad;
    self.itemPhone.textValueChanged = ^(NSString *str) {
    };
    [section0 addItem:self.itemPhone];
    
    [section0 addItem:[[FMEmptyItem alloc]initWithHeight:10 ]];

    self.codeItem = [[PhoneCodeInputItem alloc]init];
    self.codeItem.maxLenth = 6;
    self.codeItem.placeholder = @"请输短信验证码";
    self.codeItem.keyboardType = UIKeyboardTypeNumberPad;
    self.codeItem.getPhoneCode = ^{
        [bself checkPhone];
    };
    [section0 addItem:self.codeItem];
    
    [section0 addItem:[[FMEmptyItem alloc]initWithHeight:30 ]];
    
    
    OneButtonItem *btn = [[OneButtonItem alloc]init];
    btn.titleText = @"下一步";
    btn.btnPress = ^{
        [bself nextStep];
    };
    btn.bgColor = COLOR_RED_;
    [section0 addItem:btn];
    
    [section0 addItem:[[FMEmptyItem alloc]initWithHeight:30 ]];
    
    TwoButtonItem *itemXieyi = [[TwoButtonItem alloc]init];
    itemXieyi.title1Text = @"确认表示同意《惠七天注册协议》";
    itemXieyi.title1Color = COLOR_BLUE_;
    itemXieyi.title1Font = Font_Size_12;
    itemXieyi.btn1Frame = CGRectMake(0, 0, SCREEN_WIDTH, 40);
    itemXieyi.btnClick = ^(NSInteger tag) {
        if (tag == 100) {
            
        }
    };
    [section0 addItem:itemXieyi];
    
    
    [sectionArray addObject:section0];
    [self.formManager replaceSectionsWithSectionsFromArray:sectionArray];
    [self.formTable reloadData];
}

-(void)checkPhone{
    WS(bself);
	if (self.itemPhone.value.length < 11) {
		Toast(@"手机号格式错误");
		[self.codeItem reloadRowWithAnimation:UITableViewRowAnimationNone];
		return ;
	}
    NSMutableDictionary *param = [AppUtil getPublicParam];
    [param setObject:self.itemPhone.value forKey:@"mobile"];
    [self showLoading];
    [NSObject postDataWithHost:Server_Host Path:Api_BuyerCkmobile Param:param isCache:NO success:^(id json) {
        [bself hiddenLoading];
        if (IntRelay(json[@"state"]) == 1) {
			[bself getCode];
		}else{
			 Toast(StrRelay(json[@"msg"]));
			[bself.codeItem reloadRowWithAnimation:UITableViewRowAnimationNone];
		}
    } fail:^(id json) {
        [bself hiddenLoading];
        Toast(@"网络错误");
    }];
}

-(void)getCode{
    WS(bself);
    NSMutableDictionary *param = [AppUtil getPublicParam];
    [param setObject:self.itemPhone.value forKey:@"mobile"];
    [self showLoading];
    [NSObject postDataWithHost:Server_Host Path:Api_GetPhoneCode Param:param isCache:NO success:^(id json) {
        [bself hiddenLoading];
        if (IntRelay(json[@"state"]) == 1) {
			
		}else{
			[bself.codeItem reloadRowWithAnimation:UITableViewRowAnimationNone];
			Toast(StrRelay(json[@"msg"]));
		}
    } fail:^(id json) {
        [bself hiddenLoading];
        Toast(@"无网络连接");
    }];
}

-(void)nextStep{
    if (ISEmptyStr(self.itemPhone.value)) {
        Toast(@"请输入手机号码");
        return;
    }
    if (self.itemPhone.value.length < 11) {
        Toast(@"手机号码格式错误");
        return;
    }
    
    if (ISEmptyStr(self.codeItem.value)) {
        Toast(@"请输入验证码");
        return;
    }
    
    [self checkCode];
    
}

-(void)checkCode{
    WS(bself);
    NSMutableDictionary *param = [AppUtil getPublicParam];
    [param setObject:self.itemPhone.value forKey:@"mobile"];
    [param setObject:self.codeItem.value forKey:@"pin"];
    [self showLoading];
    [NSObject postDataWithHost:Server_Host Path:Api_CheckPhoneCode Param:param isCache:NO success:^(id json) {
        [bself hiddenLoading];
        if (IntRelay(json[@"state"]) == 1) {
          SettingSecCodeViewController *vc =      [[SettingSecCodeViewController alloc]init];
            vc.phone = bself.itemPhone.value;
            vc.code = bself.codeItem.value;
            RootNavPush(vc);
        }
        Toast(StrRelay(json[@"msg"]));
    } fail:^(id json) {
        [bself hiddenLoading];
        Toast(@"无网络连接");
    }];
}
@end
