//
//  MineViewController.m
//  HuiShopProject
//
//  Created by 付新明 on 2017/11/2.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "ChangePhoneViewController.h"
#import "OneButtonCell.h"
#import "OneTextInputCell.h"
#import "TwoButtonCell.h"
#import "PhoneCodeInputCell.h"
#import "SettingSecCodeViewController.h"
#import "OneTipLabCell.h"
@interface ChangePhoneViewController (){
    
}
@property (nonatomic,strong)OneTextInputItem *itemPhone;
@property (nonatomic,strong)PhoneCodeInputItem *codeItem;
@property (nonatomic,assign)BOOL haveCode;
@end

@implementation ChangePhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.title = @"手机号绑定";
    self.formTable.frame = CGRectMake(0,NavigationBarH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarH);
    
    self.formManager[@"OneButtonItem"] = @"OneButtonCell";
    self.formManager[@"OneTextInputItem"] = @"OneTextInputCell";
    self.formManager[@"TwoButtonItem"] = @"TwoButtonCell";
    self.formManager[@"PhoneCodeInputItem"] = @"PhoneCodeInputCell";
	self.formManager[@"OneTipLabItem"] = @"OneTipLabCell";
    [self initForm];
}

-(void)initForm{
    WS(bself);
    NSMutableArray *sectionArray = [NSMutableArray array];
    RETableViewSection *section0 = [RETableViewSection section];
    
    [section0 addItem:[[FMEmptyItem alloc]initWithHeight:20 ]];
	
	NSString *str11 = [NSString stringWithFormat:@"已绑定手机号:%@", StrRelay([CommonUtil appDelegate].loginInfo.mobile)];
	
	NSString *str12 = @"绑定手机号,可以提高账号的安全等级";
	OneTipLabItem *tipItem = [[OneTipLabItem alloc]init];
	tipItem.textAlignment = NSTextAlignmentLeft;
	tipItem.width = SCREEN_WIDTH - 70;
	tipItem.textColor = COLOR_999;
	tipItem.textFont = Font_Size_12;
	tipItem.cellBgColor = [UIColor clearColor];
	tipItem.tipArray = @[str11,str12];
	[section0 addItem:tipItem];
	
	[section0 addItem:[[FMEmptyItem alloc]initWithHeight:20 ]];
	
    self.itemPhone = [[OneTextInputItem alloc]init];
    self.itemPhone.maxLenth = 11;
    self.itemPhone.placeholder = @"请输入手机号";
    self.itemPhone.keyboardType = UIKeyboardTypeNumberPad;
    self.itemPhone.textValueChanged = ^(NSString *str) {
        bself.codeItem.phone = str;
        [bself.codeItem reloadRowWithAnimation:UITableViewRowAnimationNone];
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
    btn.titleText = @"更换手机号";
    btn.btnPress = ^{
		if(bself.haveCode){
			[bself nextStep];
		}
		
        
    };
    btn.bgColor = COLOR_RED_;
    [section0 addItem:btn];
    
    [section0 addItem:[[FMEmptyItem alloc]initWithHeight:40 ]];
	
	NSString *str21 = @"温馨提示:";
	NSString *str22 = @"1:一个手机号尽显绑定一个账号。";
	NSString *str23 = @"2:为了保证账号安全,手机号绑定后无法解除绑定,可以更换绑定";
	NSString *str24 = @"3:绑定或更换绑定手机号后3个月内不能再次更换,3个月后可以自行更换绑定。";
	NSString *str25 = @"4:遇到其他问题,请联系在线客服。";
	
	OneTipLabItem *tip1Item = [[OneTipLabItem alloc]init];
	tip1Item.textAlignment = NSTextAlignmentLeft;
	tip1Item.width = SCREEN_WIDTH - 70;
	tip1Item.textColor = COLOR_999;
	tip1Item.textFont = Font_Size_12;
	tip1Item.cellBgColor = [UIColor clearColor];
	tip1Item.tipArray = @[str21,str22,str23,str24,str25];
	[section0 addItem:tip1Item];
    
    [sectionArray addObject:section0];
    [self.formManager replaceSectionsWithSectionsFromArray:sectionArray];
    [self.formTable reloadData];
}

-(void)checkPhone{
    WS(bself);
    NSMutableDictionary *param = [AppUtil getPublicParam];
    [param setObject:self.itemPhone.value forKey:@"mobile"];
    [self showLoading];
	[NSObject getDataWithHost:Server_Host Path:Api_BuyerCkmobile Param:param isCache:NO success:^(id json) {
		if (IntRelay(json[@"state"]) == 1) {
			bself.haveCode = YES;
		}
		[bself hiddenLoading];
		Toast(StrRelay(json[@"msg"]));
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
		[[CommonUtil appDelegate]getUserInfo];
        Toast(StrRelay(json[@"msg"]));
    } fail:^(id json) {
        [bself hiddenLoading];
        Toast(@"网络错误");
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
    [NSObject postDataWithHost:Server_Host Path:Api_buyer_setmobile Param:param isCache:NO success:^(id json) {
        [bself hiddenLoading];
        if (IntRelay(json[@"state"]) == 1) {
			UserDefaultSetObjectForKey(bself.itemPhone.value, BindPhone);
			FMBlock(bself.saveSuccess);
			RootNavPop(YES);
        }
        Toast(StrRelay(json[@"msg"]));
    } fail:^(id json) {
        [bself hiddenLoading];
        Toast(@"无网络连接");
    }];
}
@end
