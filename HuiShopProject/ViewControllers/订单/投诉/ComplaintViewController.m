//
//  PingJiaViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2018/1/8.
//  Copyright © 2018年 付新明. All rights reserved.
//

#import "ComplaintViewController.h"

#import "WSFeedBackCell.h"
#import "SelectPicCell.h"
#import "ProductReasonSelectCell.h"
@interface ComplaintViewController (){

	WSFeedBackItem *remarkItem;

	SelectPicItem *picItem;

	
	UIButton *bottomBtn;

	int goodIndex;
	int imageIndex;
}
@property (nonatomic,strong)RETableViewSection *section;
@property (nonatomic,strong)NSMutableArray *picIds;
@end

@implementation ComplaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	_section = [RETableViewSection section];
	self.navBar.title = @"售后服务";
	self.formManager[@"WSFeedBackItem"] = @"WSFeedBackCell";
	self.formManager[@"SelectPicItem"] = @"SelectPicCell";
	self.formManager[@"ProductReasonSelectItem"] = @"ProductReasonSelectCell";
	self.formTable.frame = CGRectMake(0, NavigationBarH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarH - 40);
	goodIndex = -1;
	imageIndex = 0;
	_picIds = [NSMutableArray array];
	[self initForm];
	[self addBottomBtn];
}

-(void)initForm{
	WS(bself);
	RETableViewSection *section0 = [RETableViewSection section];
	
	[self sectionAddItems];
	
	[section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
	
	
	remarkItem = [[WSFeedBackItem alloc]init];
	remarkItem.placeH = @"请输入投诉内容";
	[section0 addItem:remarkItem];
	
	picItem = [[SelectPicItem alloc]init];
	[section0 addItem:picItem];
	
	[section0 addItem:[[FMEmptyItem alloc]initWithHeight:10]];
	
	[self.formManager replaceSectionsWithSectionsFromArray:@[_section,section0]];
	[self.formTable reloadData];
	
}

-(void)addBottomBtn{
	if (bottomBtn) {
		[bottomBtn removeFromSuperview];
		bottomBtn = nil;
	}
	bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[bottomBtn setTitle:@"提交投诉" forState:UIControlStateNormal];
	[bottomBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[bottomBtn.titleLabel setFont:Font_Size_14];
	bottomBtn.tag = 100;
	bottomBtn.frame = CGRectMake(0, SCREEN_HEIGHT - 40, SCREEN_WIDTH, 40);
	bottomBtn.backgroundColor = COLOR_RED_;
	[bottomBtn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:bottomBtn];
}

-(void)saveImage{
	WS(bself);
	if (picItem.arrayPics.count == 0) {
		[self upLoad];
	}else{
		UIImage *image = [UIImage imageWithContentsOfFile:picItem.arrayPics[imageIndex]];
		NSData *imagdata = UIImageJPEGRepresentation(image, 0.6);
		NSString *dataStr = [imagdata base64EncodedStringWithOptions:0];
		NSMutableDictionary *param = [AppUtil getPublicParam];
		[param setObject:dataStr forKey:@"baseStr"];
		[param setObject:@"1" forKey:@"type"];
		[NSObject postDataWithHost:Server_Host Path:Api_img_save Param:param isCache:NO success:^(id json) {
			if (IntRelay(json[@"state"]) == 1) {
				imageIndex++;
				[_picIds addObject:StrRelay(json[@"obj"])];
				if (imageIndex < picItem.arrayPics.count) {
					[bself saveImage];
				}else{
					[bself upLoad];
				}
			}
		} fail:^(id json) {
			Toast(@"网络错误");
		}];
	}
}
-(void)btnClick:(UIButton *)btn{
	
	if(ISEmptyStr(remarkItem.remarks)){
		Toast(@"请输入投诉内容");
		return;
	}
	if (goodIndex == -1) {
		Toast(@"请选择投诉项目");
		return;
	}
	[self saveImage];
}
-(void)upLoad{
	WS(bself);
	[self showLoading];
	NSMutableDictionary *param = [AppUtil getPublicParam];
	[param setObject:self.userinfo[@"id"] forKey:@"id"];
	[param setObject:StrRelay(remarkItem.remarks) forKey:@"content"];
	[param setObject:[NSString stringWithFormat:@"%d",goodIndex+1] forKey:@"subject"];

	[param setObject:_picIds forKey:@"idList"];
	
	NSString *param1 = [NSString jsonStringWithObject:param];
	[NSObject postDataWithHost:Server_Host Path:Api_buyer_complaint_add Param:param1 success:^(id json) {
		[bself hiddenLoading];
		if (IntRelay(json[@"state"]) == 1) {
			if (bself.saveSuccess) {
				bself.saveSuccess();
			}
			RootNavPop(YES);
		}
		Toast(json[@"msg"]);
	} fail:^(id json) {
		[bself hiddenLoading];
		Toast(@"网络错误");
	}];
}

-(void)sectionAddItems{
	WS(bself);
	[_section removeAllItems];
	NSArray *arr = @[@"商品已过期",@"商品有破损",@"协商一致退款",@"服务态度差",@"商品漏发、错发"];
	for (int i = 0; i < arr.count; i++) {
		ProductReasonSelectItem *item1 = [[ProductReasonSelectItem alloc]init];
		item1.t1 = arr[i];
		if (i == goodIndex) {
			item1.isdeSelect = YES;
		}
		item1.tag = i;
		item1.selectionHandler = ^(ProductReasonSelectItem * item) {
			goodIndex = item.tag;
			[bself sectionAddItems];
			[bself.section reloadSectionWithAnimation:UITableViewRowAnimationNone];
		};
		[_section addItem:item1];
	}
}
@end
