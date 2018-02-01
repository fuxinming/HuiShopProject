//
//  MySettingViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/12/14.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "MySettingViewController.h"
#import "TitleTipCell.h"
#import "TitleSwitchCell.h"
#import "LoginInfo.h"
#import "AboutViewController.h"
@interface MySettingViewController (){
	TitleSwitchItem *item02;
}

@end

@implementation MySettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	self.navBar.title = @"更多设置";
	self.formManager[@"TitleTipItem"] = @"TitleTipCell";
	self.formManager[@"TitleSwitchItem"] = @"TitleSwitchCell";
	self.formManager[@"FreeViewItem"] = @"FreeViewCell";
	[self initForm];
}

-(void)initForm{
	WS(bself);
	RETableViewSection *section0 = [RETableViewSection section];
	
	item02 = [[TitleSwitchItem alloc]init];
	item02.t1 = @"消息推送设置";
	UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
	if (UIUserNotificationTypeNone == setting.types) {
		item02.switchFlag = NO;
	}else{
		item02.switchFlag = YES;
	}
	item02.switchChange = ^(BOOL isOn,TitleSwitchItem *item) {
		if (isOn != item.switchFlag) {
			NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
			
			if ([[UIApplication sharedApplication] canOpenURL:url]) {
				
				if (@available(iOS 10.0, *)) {
					[[UIApplication sharedApplication] openURL:url options:nil completionHandler:^(BOOL success) {
						UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
						if (UIUserNotificationTypeNone == setting.types) {
							item.switchFlag = NO;
						}else{
							item.switchFlag = YES;
						}
						[item reloadRowWithAnimation:UITableViewRowAnimationNone];
					}];
				} else {
					[[UIApplication sharedApplication] openURL:url];
					
				}
				
			}
		}
	};
	[section0 addItem:item02];
	
	TitleTipItem *item03 = [[TitleTipItem alloc]init];
	item03.t1 = @"清除缓存";
	item03.selectionHandler = ^(id item) {
		[bself showAlertSheet];
	};
	[section0 addItem:item03];
	
	
	TitleSwitchItem *item04 = [[TitleSwitchItem alloc]init];
	item04.t1 = @"非wifi情况下手动下载图片";
	item04.switchFlag = YES;
	[section0 addItem:item04];


	[section0 addItem:[[FMEmptyItem alloc]initWithHeight:8]];
	
	TitleTipItem *item05 = [[TitleTipItem alloc]init];
	item05.t1 = @"关于惠七天";
	item05.t2 = [NSString stringWithFormat:@"V%@",[AppUtil getAppVersion]];
	item05.selectionHandler = ^(id item) {
		AboutViewController *vc = [[AboutViewController alloc]init];
		RootNavPush(vc);
	};
	[section0 addItem:item05];
	
	[section0 addItem:[[FMEmptyItem alloc]initWithHeight:18]];
	
	
	if(IsLogin){
		UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
		[btn setTitle:@"退出当前账号" forState:UIControlStateNormal];
		[btn setTitleColor:COLOR_RED_ forState:UIControlStateNormal];
		[btn.titleLabel setFont:Font_Size_14];
		btn.tag = 100;
		btn.frame = CGRectMake((SCREEN_WIDTH - 150)/2, 0, 150, 40);
		[btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
		View_Border_Radius(btn, 4, 1, COLOR_RED_);
		FreeViewItem *itemF = [[FreeViewItem alloc]init];
		itemF.cellHeight = 40;
		itemF.freeView = btn;
		[section0 addItem:itemF];
	}
	
	
	[self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
	[self.formTable reloadData];
}

-(void)showAlertSheet{
	UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"" message:@"删除后图片等多媒体消息需要重新下载查看。确定删除？" preferredStyle:UIAlertControllerStyleActionSheet];
	
	UIAlertAction* cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * action) {
			NSLog(@"action = %@", action);
														 }];
	UIAlertAction* deleteAction = [UIAlertAction actionWithTitle:@"删除" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * action) {
		[[SDImageCache sharedImageCache] clearDiskOnCompletion:nil];
		[[SDImageCache sharedImageCache] clearMemory];
	}];
	
	[alert addAction:cancelAction];
	[alert addAction:deleteAction];
	[self presentViewController:alert animated:YES completion:nil];
}

-(void)btnClick:(UIButton *)btn{
	
	[AppUtil showAlert:@"提示" msg:@"退出后你将不能查看个人信息，确定退出吗？" handle:^(BOOL cancelled, NSInteger buttonIndex) {
		if(buttonIndex == 1){
			[LoginInfo clearLoginInfo];
			UserDefaultRemoveObjectForKey(LoginPhone);
			UserDefaultRemoveObjectForKey(LoginPwd);
			if (self.saveSuccess) {
				self.saveSuccess();
			}
			RootNavPop(YES);
		}
	}];
}
@end
