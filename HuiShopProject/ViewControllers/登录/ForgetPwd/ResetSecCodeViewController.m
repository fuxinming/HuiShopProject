//
//  MineViewController.m
//  HuiShopProject
//
//  Created by 付新明 on 2017/11/2.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "ResetSecCodeViewController.h"
#import "OneTextInputCell.h"
#import "OneButtonCell.h"

#import "OneTextInputCell.h"
#import "OneButtonCell.h"
@interface ResetSecCodeViewController (){
    OneTextInputItem *itemSec;
    OneTextInputItem *itemSecNew;
}

@end

@implementation ResetSecCodeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.title = @"密码重置";
    self.formTable.frame = CGRectMake(0,NavigationBarH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarH);
    
    self.formManager[@"OneTextInputItem"] = @"OneTextInputCell";
    self.formManager[@"OneButtonItem"] = @"OneButtonCell";
    [self initForm];
}

-(void)initForm{
    WS(bself);
    NSMutableArray *sectionArray = [NSMutableArray array];
    RETableViewSection *section0 = [RETableViewSection section];
    
    [section0 addItem:[[FMEmptyItem alloc]initWithHeight:20 ]];
    
    itemSec = [[OneTextInputItem alloc]init];
    itemSec.maxLenth = 30;
    itemSec.placeholder = @"请设置登录密码";
    itemSec.isSecret = YES;
    itemSec.rightImage = @"xianshidakai";
    itemSec.rightImage1 = @"xianshiguanbi";
    [section0 addItem:itemSec];
    
    [section0 addItem:[[FMEmptyItem alloc]initWithHeight:10 ]];
    
    itemSecNew = [[OneTextInputItem alloc]init];
    itemSecNew.maxLenth = 30;
    itemSecNew.placeholder = @"再次确认输入密码";
    itemSecNew.isSecret = YES;
    itemSecNew.rightImage = @"xianshidakai";
    itemSecNew.rightImage1 = @"xianshiguanbi";
    [section0 addItem:itemSecNew];
    
    [section0 addItem:[[FMEmptyItem alloc]initWithHeight:30 ]];
    
    
    OneButtonItem *btn = [[OneButtonItem alloc]init];
    btn.titleText = @"完成";
    btn.bgColor = COLOR_RED_;
    btn.btnPress = ^{
        [bself nextStep];
        
    };
    [section0 addItem:btn];
    
    
    [sectionArray addObject:section0];
    [self.formManager replaceSectionsWithSectionsFromArray:sectionArray];
    [self.formTable reloadData];
}

-(void)nextStep{

    if (itemSec.value.length < 6) {
        Toast(@"密码长度不足");
        return;
    }
    
    if (![itemSecNew.value isEqualToString:itemSec.value]){
        Toast(@"两次密码输入不一致");
        return;
    }
    
    
    [self goReg];
    
}

-(void)goReg{
    WS(bself);
    NSMutableDictionary *param = [AppUtil getPublicParam];
    
    [param setObject:StrRelay(self.phone) forKey:@"mobile"];
    [param setObject:StrRelay(self.code) forKey:@"pin"];
    [param setObject:StrRelay(itemSec.value) forKey:@"password"];
    [self showLoading];
    [NSObject postDataWithHost:Server_Host Path:Api_resetpw Param:param isCache:NO success:^(id json) {
        [bself hiddenLoading];
        if (IntRelay(json[@"state"]) == 1) {
            [bself popToViewController:@"LoginViewController"];
        }
        Toast(StrRelay(json[@"msg"]));
    } fail:^(id json) {
        [bself hiddenLoading];
        Toast(@"无网络连接");
    }];
}
@end
