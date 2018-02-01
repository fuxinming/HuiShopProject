//
//  PersonalInfoViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/11/9.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "PersonalInfoViewController.h"
#import "HeadImageCell.h"
#import "TitleTipCell.h"
#import "WSImageUtils.h"
#import "ChangeNickViewController.h"
#import "BottomSelectView.h"
#import "ChangePhoneViewController.h"
#import "AFNetworking.h"

@interface PersonalInfoViewController ()

@end

@implementation PersonalInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.title = @"个人信息";
    self.formManager[@"TitleTipItem"] = @"TitleTipCell";
    self.formManager[@"HeadImageItem"] = @"HeadImageCell";
    [self initForm];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(initForm) name:RefreshTable    object:nil];
}

-(void)initForm{
    WS(bself);
    NSMutableArray *sectionArray = [NSMutableArray array];
    RETableViewSection *section0 = [RETableViewSection section];
    AppDelegate *del = [CommonUtil appDelegate];
    HeadImageItem *item01 = [[HeadImageItem alloc]init];
	item01.selectionHandler = ^(HeadImageItem *item){
		[bself showAlertHeadData:item];
	};
	item01.imgText = StrRelay(del.loginInfo.picUrl);
    [section0 addItem:item01];
	
    TitleTipItem *item02 = [[TitleTipItem alloc]init];
    item02.t1 = @"昵称";
    item02.t2 = StrRelay(del.loginInfo.nickName);
	item02.selectionHandler = ^(TitleTipItem * item) {
		ChangeNickViewController *vc = [[ChangeNickViewController alloc]init];
		vc.saveSuccess1 = ^(NSString *str1){
			item.t2 = StrRelay(str1);
			[item reloadRowWithAnimation:UITableViewRowAnimationNone];
			[[CommonUtil appDelegate]getUserInfo];
		};
		RootNavPush(vc);
	};
    [section0 addItem:item02];
	
	NSString *sexStr = @"保密";
	if (IntRelay(del.loginInfo.sex) == 1) {
		sexStr = @"男";
	}
	if (IntRelay(del.loginInfo.sex) == 2) {
		sexStr = @"女";
	}
    TitleTipItem *item03 = [[TitleTipItem alloc]init];
    item03.t1 = @"性别";
    item03.t2 = sexStr;
	item03.selectionHandler = ^(TitleTipItem * item) {
		[bself popChangeSex:item];
	};
    [section0 addItem:item03];
    
    TitleTipItem *item04 = [[TitleTipItem alloc]init];
    item04.t1 = @"账号";
    item04.t2 = UserDefaultObjectForKey(LoginPhone);
    [section0 addItem:item04];
    
    TitleTipItem *item05 = [[TitleTipItem alloc]init];
    item05.t1 = @"绑定手机";
	item05.t2 = StrRelay([CommonUtil appDelegate].loginInfo.mobile);
    item05.haveLine = NO;
	item05.selectionHandler = ^(TitleTipItem * item) {
		ChangePhoneViewController *vc = [[ChangePhoneViewController alloc]init];
		RootNavPush(vc);
	};
    [section0 addItem:item05];
    
    
    
    [sectionArray addObject:section0];
    [self.formManager replaceSectionsWithSectionsFromArray:sectionArray];
    [self.formTable reloadData];
    
}

-(void)showAlertHeadData:(HeadImageItem *)item {
	WS(bself);
	[WSImageUtils sharedInstance].canEditPic = YES;
	[WSImageUtils sharedInstance].canMultiSelect = NO;
	[[WSImageUtils sharedInstance] showAlertSheet:self];
	[WSImageUtils sharedInstance].didFinishCamera = ^(NSString *path1) {
		UIImage *image = [UIImage imageWithContentsOfFile:path1];
		NSData *imagdata = UIImageJPEGRepresentation(image, 0.6);
		NSString *dataStr = [imagdata base64EncodedStringWithOptions:0];
		NSArray *arr = @[dataStr];
		NSString *param = [NSString jsonStringWithObject:arr];
		[bself uploadFile:item ImagePath:param];
	};
}
-(void)uploadFile:(HeadImageItem *)item ImagePath:(NSString*)data{
	WS(bself);
	[self showLoading];

	[NSObject postDataWithHost:Server_Host Path:Api_buyer_avatar_change Param:data success:^(id json) {
			[bself hiddenLoading];
		[[CommonUtil appDelegate]getUserInfo];
	} fail:^(id json) {
		[bself hiddenLoading];
				Toast(@"上传失败");
	}];
}
-(void)popChangeSex:(TitleTipItem *) item{
	BottomSelectView *view = [[BottomSelectView alloc]initWithArr:@[@"男",@"女"]];
	
	view.rebackBlock = ^(NSString *str1, int index) {
		item.t2 = str1;
		[item reloadRowWithAnimation:UITableViewRowAnimationNone];
		NSString *str = @"1";
		if (index == 1) {
			str = @"2";
		}
		[self changeSex:str];
	};
	[self.view addSubview:view];
}

-(void)changeSex:(NSString *)str{
	WS(bself);
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:str forKey:@"sex"];
	[param setObject:StrRelay([CommonUtil appDelegate].loginInfo.nickName) forKey:@"name"];
	[param setObject:StrRelay(UserDefaultObjectForKey(LoginPhone)) forKey:@"mobile"];
	[self showLoading];
	[NSObject postDataWithHost:Server_Host Path:Api_buyer_modify Param:param isCache:NO success:^(id json) {
		[[CommonUtil appDelegate]getUserInfo];
		[bself hiddenLoading];
		Toast(json[@"msg"]);
	} fail:^(id json) {
		[bself hiddenLoading];
		Toast(@"网络连接失败，请检查你的网络");
	}];
}
@end
