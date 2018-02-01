//
//  ChangeNickViewController.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/4.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "ChangeNickViewController.h"
#import "OneButtonCell.h"
#import "ImageTextInputCell.h"
#import "OneTipLabCell.h"
@interface ChangeNickViewController ()
@property (nonatomic,strong) ImageTextInputItem *itemNick;
@end

@implementation ChangeNickViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.title = @"更改昵称";

    self.formManager[@"ImageTextInputItem"] = @"ImageTextInputCell";
    self.formManager[@"OneButtonItem"] = @"OneButtonCell";
    [self initForm];
}
-(void)initForm{
    WS(bself);
    NSMutableArray *sectionArray = [NSMutableArray array];
    RETableViewSection *section0 = [RETableViewSection section];
	
    _itemNick = [[ImageTextInputItem alloc]init];
    _itemNick.maxLenth = 20;
    _itemNick.value =StrRelay([CommonUtil appDelegate].loginInfo.nickName);
    _itemNick.placeholder = @"请输入您的昵称";
    _itemNick.keyboardType = UIKeyboardTypeDefault;
    _itemNick.cellHeight = 50;
    [section0 addItem:_itemNick];

	[section0 addItem:[[FMEmptyItem alloc]initWithHeight:20]];
    
	OneButtonItem *btn = [[OneButtonItem alloc]init];
	btn.titleText = @"更改昵称";
	btn.bgColor = COLOR_RED_;
	btn.btnPress = ^{
		[bself save];
	};
	[section0 addItem:btn];
    [sectionArray addObject:section0];
    [self.formManager replaceSectionsWithSectionsFromArray:sectionArray];
    [self.formTable reloadData];
}

-(void)save{
    WS(bself);
    if (ISEmptyStr(_itemNick.value)) {
        Toast(@"请输入昵称");
        return;
    }
    
    NSMutableDictionary *param = [AppUtil getPublicParam];
    [param setObject:_itemNick.value forKey:@"nickName"];
	[param setObject:_itemNick.value forKey:@"name"];
    [param setObject:StrRelay(UserDefaultObjectForKey(LoginPhone)) forKey:@"mobile"];
    [self showLoading];
    [NSObject postDataWithHost:Server_Host Path:Api_buyer_modify Param:param isCache:NO success:^(id json) {
        [bself hiddenLoading];
		
        if (IntRelay(json[@"state"]) == 1) {
            if(bself.saveSuccess1){
                bself.saveSuccess1(bself.itemNick.value);
            }
            RootNavPop(YES);
        }
		Toast(json[@"msg"]);
    } fail:^(id json) {
        [bself hiddenLoading];
        Toast(@"网络连接失败，请检查你的网络");
    }];
}
@end
