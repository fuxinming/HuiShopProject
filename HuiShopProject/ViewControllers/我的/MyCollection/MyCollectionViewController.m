//
//  PersonalInfoViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/11/9.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "MyCollectionViewController.h"

#import "CollectionCell.h"
#import "ProductDetailViewController.h"
@interface MyCollectionViewController ()

@end

@implementation MyCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	if(self.saveSuccess){
		self.saveSuccess();
	}
	if (self.type == 1) {
		self.navBar.title = @"收藏";
		self.myArr = UserDefaultObjectForKey(MyCollectionProduct);
	}
	if (self.type == 2) {
		self.navBar.title = @"浏览记录";
		self.myArr = UserDefaultObjectForKey(MyLookedProduct);
	}
	[self setRightBtn];
    self.formManager[@"CollectionItem"] = @"CollectionCell";
    [self initForm];
}

-(void)initForm{
    WS(bself);
	[self setRightBtn];
	
	if (self.myArr.count == 0) {
		[self initEmptyForm:self.formTable.height andType:1];
		return;
	}
    NSMutableArray *sectionArray = [NSMutableArray array];
    RETableViewSection *section0 = [RETableViewSection section];
	
	for (int i = 0; i < self.myArr.count; i++ ) {
		NSDictionary *dict = [self.myArr objectAtIndex:i];
		CollectionItem *item0 = [[CollectionItem alloc]init];
		item0.userinfo = dict;
		item0.selectionHandler = ^(CollectionItem * item) {
			ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
			vc.userinfo = item.userinfo;
			RootNavPush(vc);
		};
		[section0 addItem:item0];
	}
	
    [sectionArray addObject:section0];
    [self.formManager replaceSectionsWithSectionsFromArray:sectionArray];
    [self.formTable reloadData];
    
}

-(void)setRightBtn{
	WS(bself);
	if (self.myArr.count > 0) {
		self.navBar.rightItemList = [NSArray arrayWithObject:[FMBarItem itemWith:@"清空" withClick:^(id it) {
			if(bself.type == 1){
				[AppUtil showAlert:@"提示" msg:@"确定清除所有收藏吗？" handle:^(BOOL cancelled, NSInteger buttonIndex) {
					if(buttonIndex == 1){
						
						UserDefaultRemoveObjectForKey(MyCollectionProduct);
						self.myArr = nil;
						[bself initForm];
						if(bself.saveSuccess){
							bself.saveSuccess();
						}
					}
				}];
			}
			if(bself.type == 2){
				[AppUtil showAlert:@"提示" msg:@"确定清除所有浏览记录吗？" handle:^(BOOL cancelled, NSInteger buttonIndex) {
					if(buttonIndex == 1){
						
						UserDefaultRemoveObjectForKey(MyLookedProduct);
						self.myArr = nil;
						[bself initForm];
						if(bself.saveSuccess){
							bself.saveSuccess();
						}
					}
				}];
			}
		}]];
	}else{
		self.navBar.rightItemList = nil;
	}
}

@end
