//
//  MineViewController.m
//  HuiShopProject
//
//  Created by 付新明 on 2017/11/2.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "MineViewController.h"
#import "MineHeadCell.h"
#import "TwoMenuCell.h"
#import "TitleTipCell.h"
#import "LoginViewController.h"
#import "MidMenuCell.h"
#import "PersonalInfoViewController.h"
#import "OrdersViewController.h"
#import "MyCollectionViewController.h"
#import "MySettingViewController.h"
#import "AllowanceTicketsViewController.h"
#import "ConsigneeAddressViewController.h"
#import "FeedBackViewController.h"
@interface MineViewController ()
@property (nonatomic, strong) NSMutableArray *myArr1;
@property (nonatomic, strong) NSMutableArray *myArr2;
@property (nonatomic, strong) NSMutableArray *myArr3;
@property (nonatomic, strong) NSMutableArray *countArr;
@property (nonatomic, assign) int coin;
@property (nonatomic, assign) int point;
@end

@implementation MineViewController

- (void)viewDidLoad {
    self.navHidden = YES;
    [super viewDidLoad];
    self.formTable.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TabBarH);
    self.formManager[@"MineHeadItem"] = @"MineHeadCell";
    self.formManager[@"TwoMenuItem"] = @"TwoMenuCell";
    self.formManager[@"TitleTipItem"] = @"TitleTipCell";
    self.formManager[@"MidMenuItem"] = @"MidMenuCell";
	
	if (IsLogin) {
		[self addHeader];
		[self beginRefrash];
	}else{
		[self initForm];
	}
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getData) name:RefreshTable    object:nil];
}

-(void)getData{
	WS(bself);
	dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
	//创建全局并行
	dispatch_group_t group = dispatch_group_create();
	dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
	dispatch_group_async(group, queue, ^{
		[bself getVoucher1Info:^{
			dispatch_semaphore_signal(semaphore);
		}];
	});
	dispatch_group_async(group, queue, ^{
		[bself getVoucher2Info:^{
			dispatch_semaphore_signal(semaphore);
		}];
	});
	dispatch_group_async(group, queue, ^{
		[bself getVoucher3Info:^{
			dispatch_semaphore_signal(semaphore);
		}];
	});
	
	dispatch_group_async(group, queue, ^{
		[bself getOrderCount:^{
			dispatch_semaphore_signal(semaphore);
		}];
	});
	dispatch_group_async(group, queue, ^{
		[bself getPoint:^{
			dispatch_semaphore_signal(semaphore);
		}];
	});
	dispatch_group_async(group, queue, ^{
		[bself getCoin:^{
			dispatch_semaphore_signal(semaphore);
		}];
	});
	dispatch_group_notify(group, queue, ^{
		dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
		dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
		dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
		dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
		dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
		dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
		
		[bself performSelectorOnMainThread:@selector(initForm) withObject:nil waitUntilDone:YES];
		[bself performSelectorOnMainThread:@selector(endRefrash) withObject:nil waitUntilDone:YES];
	});
	
}

-(void)getOrderCount:(void(^)(void))finish{
	WS(bself);

	[NSObject getDataWithHost:Server_Host Path:Api_buyer_order_listcnt Param:nil isCache:NO success:^(id json) {
		bself.countArr = [NSMutableArray arrayWithArray:json[@"obj"]];
		FMBlock(finish);
	} fail:^(id json) {
		FMBlock(finish);
	}];
}

-(void)getPoint:(void(^)(void))finish{
	WS(bself);
	
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_getpoint Param:nil isCache:NO success:^(id json) {
		bself.point = IntRelay(json[@"obj"]);
		FMBlock(finish);
	} fail:^(id json) {
		FMBlock(finish);
	}];
}

-(void)getCoin:(void(^)(void))finish{
	WS(bself);
	
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_getcoin Param:nil isCache:NO success:^(id json) {
		bself.coin = IntRelay(json[@"obj"]);
		FMBlock(finish);
	} fail:^(id json) {
		FMBlock(finish);
	}];
}

-(void)getVoucher1Info:(void(^)(void))finish{
	WS(bself);
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:@"1" forKey:@"status"];
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_voucher Param:param isCache:NO success:^(id json) {
		
		bself.myArr1 = [NSMutableArray arrayWithArray:json[@"obj"]];
		FMBlock(finish);
	} fail:^(id json) {
		FMBlock(finish);
	}];
}
-(void)getVoucher2Info:(void(^)(void))finish{
	WS(bself);
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:@"2" forKey:@"status"];
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_voucher Param:param isCache:NO success:^(id json) {
		bself.myArr2 = [NSMutableArray arrayWithArray:json[@"obj"]];
		FMBlock(finish);
	} fail:^(id json) {
		FMBlock(finish);
	}];
}
-(void)getVoucher3Info:(void(^)(void))finish{
	WS(bself);
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:@"3" forKey:@"status"];
	[NSObject getDataWithHost:Server_Host Path:Api_buyer_voucher Param:param isCache:NO success:^(id json) {
		bself.myArr3 = [NSMutableArray arrayWithArray:json[@"obj"]];
		FMBlock(finish);
	} fail:^(id json) {
		FMBlock(finish);
	}];
}

-(void)initForm{
	WS(bself);
    NSMutableArray *sectionArray = [NSMutableArray array];
    RETableViewSection *section0 = [RETableViewSection section];
	AppDelegate *del = [CommonUtil appDelegate];
	
    MineHeadItem *itemHead = [[MineHeadItem alloc]init];
    itemHead.bgColor = COLOR_RED_;
    itemHead.phoneText = StrRelay(del.loginInfo.name);
    itemHead.nameText = StrRelay(del.loginInfo.nickName);
	itemHead.imgText = StrRelay(del.loginInfo.picUrl);
    itemHead.selectionHandler = ^(MineHeadItem * item) {
        if (IsLogin) {
            PersonalInfoViewController *vc = [[PersonalInfoViewController alloc]init];
            RootNavPush(vc);
        }else{
            LoginViewController *vc = [[LoginViewController alloc]init];
            vc.saveSuccess = ^{
				[bself addHeader];
				[bself beginRefrash];
            };
            RootNavPush(vc);
        }
        
    };
	
	itemHead.btnClick = ^(NSInteger tag) {
		if(tag == 101){
			MySettingViewController *vc = [[MySettingViewController alloc]init];
			vc.saveSuccess = ^{
				[bself initForm];
			};
			RootNavPush(vc);
		}
	};
    [section0 addItem:itemHead];
    
    NSArray *arr1 = UserDefaultObjectForKey(MyCollectionProduct);
	NSArray *arr2 = UserDefaultObjectForKey(MyLookedProduct);
    TwoMenuItem *item02 = [[TwoMenuItem alloc]init];
    item02.t1 = [NSString stringWithFormat:@"%ld",arr1.count];
    item02.t2 = @"收藏的商品";
    item02.t3 = [NSString stringWithFormat:@"%ld",arr2.count];
    item02.t4 = @"浏览足迹";
	item02.btnClick = ^(NSInteger tag) {
		if (tag == 100) {
			MyCollectionViewController *vc = [[MyCollectionViewController alloc]init];
			vc.saveSuccess = ^(){
				[bself initForm];
			};
			vc.type = 1;
			RootNavPush(vc);
		}
		if (tag == 101) {
			MyCollectionViewController *vc = [[MyCollectionViewController alloc]init];
			vc.saveSuccess = ^(){
				[bself initForm];
			};
			vc.type = 2;
			RootNavPush(vc);
		}
	};
    [section0 addItem:item02];
    
    [section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
    
    TitleTipItem *item03 = [[TitleTipItem alloc]init];
    item03.t1 = @"我的订单";
    item03.t2 = @"查看全部订单";
    item03.selectionHandler = ^(id item) {
		if (IsLogin) {
			OrdersViewController *vc = [[OrdersViewController alloc]init];
			RootNavPush(vc);
		}else{
			LoginViewController *vc = [[LoginViewController alloc]init];
			vc.saveSuccess = ^{
				[bself addHeader];
				[bself beginRefrash];
			};
			RootNavPush(vc);
		}
		
        
    };
    [section0 addItem:item03];
    
    MidMenuItem *item04 = [[MidMenuItem alloc]init];
    item04.titleArr = @[@{@"image":@"OrderDaiFahuo",@"title":@"待付款"},
                        @{@"image":@"OrderDaiFahuo",@"title":@"待发货"},
                        @{@"image":@"OrderDaishouhuo",@"title":@"待收货"},
                        @{@"image":@"OrderDaiPingjia",@"title":@"待评价"},
                        @{@"image":@"drawback",@"title":@"已退款"},
                        @{@"image":@"OrderDaiPingjia",@"title":@"已投诉"}];
	
	if (IsLogin) {
		item04.countArr = self.countArr;
	}else{
		item04.countArr = nil;
	}
	item04.btnClick = ^(NSInteger tag) {
		if (IsLogin) {
			OrdersViewController *vc = [[OrdersViewController alloc]init];
			vc.curIndex = tag - 99;
			RootNavPush(vc);
		}else{
			LoginViewController *vc = [[LoginViewController alloc]init];
			vc.saveSuccess = ^{
				[bself addHeader];
				[bself beginRefrash];
			};
			RootNavPush(vc);
		}
		
	};
    [section0 addItem:item04];
    
    [section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
    TitleTipItem *item05 = [[TitleTipItem alloc]init];
	item05.haveArrow = NO;
    item05.t1 = @"我的钱包";
    [section0 addItem:item05];
    
    TwoMenuItem *item06 = [[TwoMenuItem alloc]init];
    item06.t1 = [NSString stringWithFormat:@"%d",self.point];
    item06.t2 = @"积分";
    item06.t3 = [NSString stringWithFormat:@"%d",self.coin];
    item06.t4 = @"金币";
    [section0 addItem:item06];
    
    [section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
    
    TitleTipItem *item07 = [[TitleTipItem alloc]init];
    item07.t1 = @"点击查看代金券";
    item07.leftImage = @"daijinquan";
	item07.selectionHandler = ^(TitleTipItem * item) {
		if (IsLogin) {
			AllowanceTicketsViewController *vc = [[AllowanceTicketsViewController alloc]init];
			vc.myArr1 = self.myArr1;
			vc.myArr2 = self.myArr2;
			vc.myArr3 = self.myArr3;
			RootNavPush(vc);
		}else{
			LoginViewController *vc = [[LoginViewController alloc]init];
			vc.saveSuccess = ^{
				[bself beginRefrash];
			};
			RootNavPush(vc);
		}
		
	};
    [section0 addItem:item07];
    
    TitleTipItem *item08 = [[TitleTipItem alloc]init];
    item08.t1 = [NSString stringWithFormat:@"未使用 %ld",self.myArr1.count];
    item08.tFont = Font_Size_12;
    item08.marginLeft = 55;
	item08.haveArrow = NO;
    [section0 addItem:item08];
	
	TitleTipItem *item10 = [[TitleTipItem alloc]init];
	item10.t1 = [NSString stringWithFormat:@"已过期 %ld",self.myArr3.count];
	item10.tFont = Font_Size_12;
	item10.marginLeft = 55;
	item10.haveArrow = NO;
	[section0 addItem:item10];
	
	
    TitleTipItem *item09 = [[TitleTipItem alloc]init];
    item09.t1 = [NSString stringWithFormat:@"已使用 %ld",self.myArr2.count];
    item09.tFont = Font_Size_12;
    item09.marginLeft = 55;
	item09.haveArrow = NO;
    [section0 addItem:item09];

	[section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
    
    TitleTipItem *item11 = [[TitleTipItem alloc]init];
    item11.t1 = @"收货地址";
	item11.selectionHandler = ^(id item) {
		if (IsLogin) {
			ConsigneeAddressViewController *vc = [[ConsigneeAddressViewController alloc]init];
			RootNavPush(vc);
		}else{
			LoginViewController *vc = [[LoginViewController alloc]init];
			vc.saveSuccess = ^{
				[bself addHeader];
				[bself beginRefrash];
			};
			RootNavPush(vc);
		}
	};
    item11.leftImage = @"icon_add";
    [section0 addItem:item11];
    
    [section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
    
    TitleTipItem *item12 = [[TitleTipItem alloc]init];
    item12.t1 = @"意见反馈";
    item12.leftImage = @"icon_tickling";
	item12.selectionHandler = ^(id item) {
		if (IsLogin) {
			FeedBackViewController *vc = [[FeedBackViewController alloc]init];
			RootNavPush(vc);
		}else{
			LoginViewController *vc = [[LoginViewController alloc]init];
			vc.saveSuccess = ^{
				[bself addHeader];
				[bself beginRefrash];
			};
			RootNavPush(vc);
		}
	};
    [section0 addItem:item12];
    
    [section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
    
    [sectionArray addObject:section0];
    [self.formManager replaceSectionsWithSectionsFromArray:sectionArray];
    [self.formTable reloadData];
}
@end
