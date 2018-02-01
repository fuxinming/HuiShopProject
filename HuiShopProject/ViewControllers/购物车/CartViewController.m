//
//  CartViewController.m
//  HuiShopProject
//
//  Created by 付新明 on 2017/11/2.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "CartViewController.h"
#import "EmptyCartCell.h"
#import "PopBottomView.h"
#import "RestoreMenuView.h"
#import "CartProductCell.h"
#import "PayTypeViewController.h"
#import "NowMaiViewController.h"
@interface CartViewController (){
	UIView *headView;
	UILabel *titleLab;
	UIImageView *image;
	PopBottomView *popView;
	NSDictionary *oneMarcket;
	UIButton* rightBtn;
	BOOL isEdit;
	
	UIView *bottomView;
	UIButton *selbtn;
	UILabel *label;
	UILabel *label2;
	UIButton *btn4;
	RETableViewSection *section0;
}
@property (nonatomic, strong) NSMutableArray *gouwucheArr;
@end

@implementation CartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.title = @"";
	[self initNavBarView];
	self.formTable.frame = CGRectMake(0, NavigationBarH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarH - TabBarH - 49);
    self.formManager[@"EmptyCartItem"] = @"EmptyCartCell";
	self.formManager[@"CartProductItem"] = @"CartProductCell";
	[self addHeader];
	
}
-(void)viewDidAppear:(BOOL)animated{
	[super viewDidAppear:animated];
	[self getData];
}
-(void)initNavBarView{
	headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, NavigationBarH-0.5)];
	headView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:headView];
	[headView removeAllSubviews];
	
	titleLab = [[UILabel alloc] initWithFrame:CGRectMake(31, 52, 50, 22)];
	titleLab.font = Font_Size_16;
	titleLab.textAlignment = 0;
	titleLab.text = @"购物车";
	titleLab.textColor = COLOR_333;
	[headView addSubview:titleLab];
	
	image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
	image.image = [UIImage imageNamed:@"img_find_default_down"];
	[headView addSubview:image];
	
	[self resetImageFrame];
	UIButton* midBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, 0,100, NavigationBarH)];
	[midBtn addTarget:self action:@selector(midBtnClick) forControlEvents:UIControlEventTouchUpInside];
	[headView addSubview:midBtn];
	
	rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 60, StatusBarH,55, NavigationBarH - StatusBarH)];
	[rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
	[rightBtn setTitleColor:COLOR_333 forState:UIControlStateNormal];
	[rightBtn.titleLabel setFont:Font_Size_14];
	[rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
	[headView addSubview:rightBtn];
}

-(void)resetImageFrame{
	[titleLab sizeToFit];
	float x = 20;
	image.hidden = NO;
	if (self.gouwucheArr.count == 0) {
		image.hidden = YES;
		x = 0;
	}
	float left = (SCREEN_WIDTH - titleLab.width - x)/2;
	titleLab.frame = CGRectMake(left, NavigationBarH - 36, titleLab.width, 20);
	image.frame = CGRectMake(titleLab.right + 10, NavigationBarH - 31, 10, 10);
}
-(void)getData{
	WS(bself);
	NSMutableDictionary *dict = [AppUtil getPublicParam];

	[NSObject postDataWithHost:Server_Host Path:Api_buyer_cart_list Param:dict isCache:NO success:^(id json) {
		[bself endRefrash];
		if (json[@"obj"] && [json[@"obj"] isKindOfClass:[NSArray class]]) {
			bself.gouwucheArr = [NSMutableArray arrayWithArray:json[@"obj"]];
			if (bself.gouwucheArr.count > 0) {
				oneMarcket = bself.gouwucheArr[0];
				titleLab.text = oneMarcket[@"marketName"];
				[bself initBottomView];
				rightBtn.hidden = NO;
			}else{
				bottomView.hidden = YES;
				isEdit = NO;
				rightBtn.hidden = YES;
			}
			[bself resetImageFrame];
		}
		[bself initForm];
	} fail:^(id json) {
		[bself endRefrash];
		[bself initForm];
	}];
}
-(void)initForm{
	WS(bself);
   	section0 = [RETableViewSection section];
	if (self.gouwucheArr.count >0) {
		NSArray *goodArr = oneMarcket[@"goodsList"];
		for (int i = 0; i < goodArr.count; i++) {
			NSDictionary *dict = [goodArr objectAtIndex:i];
			CartProductItem *item1 = [[CartProductItem alloc]init];
			item1.userinfo = dict;
			item1.isEdict = isEdit;
			item1.btnClick = ^(NSInteger tag) {
				if (tag == 100) {
					[bself resetForm];
				}
			};
			[section0 addItem:item1];
		}
	}else{
		EmptyCartItem *item01 = [[EmptyCartItem alloc]init];
		item01.btnClick = ^(NSInteger tag) {
			if (tag == 100) {
				AppDelegate *del = [CommonUtil appDelegate];
				[del.tab setTabIndex:1];
			}
		};
		[section0 addItem:item01];
	}
    [self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
    [self.formTable reloadData];
}

-(void)midBtnClick{
	WS(bself);
	if (self.gouwucheArr.count > 0) {
		WS(bself);
		NSMutableArray *tArr = [NSMutableArray arrayWithCapacity:0];
		for (int i = 0; i < self.gouwucheArr.count ; i++) {
			NSDictionary *dict = [self.gouwucheArr objectAtIndex:i];
			[tArr addObject:StrRelay(dict[@"marketName"])];
		}
		RestoreMenuView *aview = [[RestoreMenuView alloc]initWithFrame:CGRectMake(20, SCREEN_HEIGHT, SCREEN_WIDTH - 40, 60*self.gouwucheArr.count) withArr:tArr];
		aview.backgroundColor = [UIColor whiteColor];
		aview.selectItem = ^(int type, int index, NSString *t) {
			oneMarcket = [bself.gouwucheArr objectAtIndex:index];
			titleLab.text = oneMarcket[@"marketName"];
			[bself resetImageFrame];
			[bself initForm];
			[popView remove];
		};
		popView = [[PopBottomView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
		[popView showContentView:aview];
	}
}

-(void)rightBtnClick{
	isEdit = !isEdit;
	if (isEdit) {
		[rightBtn setTitle:@"完成" forState:UIControlStateNormal];
	}else{
		[rightBtn setTitle:@"编辑" forState:UIControlStateNormal];
		[self editProductNumber];
	}
	
	[self setEditState];
}

-(void)initBottomView{
	if (bottomView) {
		[bottomView removeAllSubviews];
		[bottomView removeFromSuperview];
		bottomView = nil;
	}
	bottomView = [[UIView alloc]initWithFrame:CGRectMake(0,SCREEN_HEIGHT - TabBarH - 49, SCREEN_WIDTH, 49)];
	bottomView.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:bottomView];
	
	UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0,0, SCREEN_WIDTH, 0.5)];
	lineView.backgroundColor = COLOR_ddd;
	[bottomView addSubview:lineView];
	
	selbtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[selbtn setImage:[UIImage imageNamed:@"unselectCicle"] forState:UIControlStateNormal];
	[selbtn setImage:[UIImage imageNamed:@"selectCircle"] forState:UIControlStateSelected];
	selbtn.frame = CGRectMake(0, 0, 49, 49);
	selbtn.imageEdgeInsets = UIEdgeInsetsMake(17, 17, 17, 17);
	[selbtn addTarget:self action:@selector(quanxuan:) forControlEvents:UIControlEventTouchUpInside];
	selbtn.tag = 100;
	[bottomView addSubview:selbtn];
	
	UILabel *label0 = [[UILabel alloc] init];
	label0.text = @"全部";
	label0.font = Font_Size_14;
	label0.textColor = COLOR_333;
	label0.frame = CGRectMake(selbtn.right - 10, 14, 40, 21);
	[bottomView addSubview:label0];
	
	NSMutableAttributedString *str1 = [CommonUtil mutableStringAppendString:@"合计：".color(COLOR_333).font(Font_Size_13)];
	str1.append([NSString stringWithFormat:@"￥%.2f",0.0f].color(COLOR_RED_).font(Font_Size_13));
	label = [[UILabel alloc] init];
	label.textAlignment = NSTextAlignmentRight;
	label.attributedText = str1;
	label.font = Font_Size_14;
	label.frame = CGRectMake(50, 8, SCREEN_WIDTH - 170, 15);
	[bottomView addSubview:label];
	
	label2 = [[UILabel alloc] init];
	label2.textAlignment = NSTextAlignmentRight;
	label2.text = @"不含配送费";
	label2.font = Font_Size_12;
	label2.textColor = COLOR_999;
	label2.frame = CGRectMake(50, 26, SCREEN_WIDTH - 170, 15);
	[bottomView addSubview:label2];

	btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn4 setTitle:@"去结算" forState:UIControlStateNormal];
	[btn4 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	[btn4.titleLabel setFont:Font_Size_13];
	btn4.backgroundColor = COLOR_RED_;
	btn4.tag = 103;
	btn4.frame = CGRectMake(SCREEN_WIDTH - 110, 0, 110, TabBarH);
	[btn4 addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	[bottomView addSubview:btn4];
}

-(void)btnClick:(UIButton *)btn{
	WS(bself);
	if (isEdit) {
		int selectCout = 0;
		for (int i = 0; i < section0.items.count; i ++) {
			CartProductItem *item1 = [section0.items objectAtIndex:i];
			if (item1.isBtnSelect) {
				selectCout ++;
			}
		}
		if (selectCout == 0) {
			Toast(@"请选择商品进行删除");
			return;
		}
		NSMutableArray *ids = [NSMutableArray array];
		for (int i = 0; i < section0.items.count; i ++) {
			CartProductItem *item1 = [section0.items objectAtIndex:i];
			if (item1.isBtnSelect) {
				[ids addObject:StrRelay(item1.userinfo[@"id"]) ];
			}
		}
		[self showLoading];

		NSString *param = [ids toJSONString];
		[NSObject postDataWithHost:Server_Host Path:Api_buyer_cart_del Param:param success:^(id json) {
			[bself getData];
			[bself hiddenLoading];
		} fail:^(id json) {
			[bself hiddenLoading];
			Toast(@"网络错误");
		}];
		
	}else{
		int selectCout = 0;
		for (int i = 0; i < section0.items.count; i ++) {
			CartProductItem *item1 = [section0.items objectAtIndex:i];
			if (item1.isBtnSelect) {
				selectCout ++;
			}
		}
		if (selectCout == 0) {
			Toast(@"请选择商品进行结算");
			return;
		}
		
		NSMutableArray *ids = [NSMutableArray array];
		for (int i = 0; i < section0.items.count; i ++) {
			CartProductItem *item1 = [section0.items objectAtIndex:i];
			if (item1.isBtnSelect) {
				[ids addObject:item1.userinfo[@"id"]];
			}
		}
		[self showLoading];
		NSString *param = [ids toJSONString];
		[NSObject postDataWithHost:Server_Host Path:Api_buyer_cart_estimate Param:param  success:^(id json) {
			[bself hiddenLoading];
			if (IntRelay(json[@"state"]) == 1) {
				if(json[@"obj"]&&[json[@"obj"] isKindOfClass:[NSDictionary class]]){
					NSDictionary *dict = json[@"obj"];
					NowMaiViewController *vc = [[NowMaiViewController alloc]init];
					vc.isFormCart = YES;
					vc.orderInfoDict = [NSMutableDictionary dictionaryWithDictionary:dict] ;
					RootNavPush(vc);
					
				}
			}else{
				Toast(@"结算失败");
			}
		} fail:^(id json) {
			[bself hiddenLoading];
			Toast(@"网络错误");
		}];
	}
	
}

-(void)resetForm{
	int selectCout = 0;
	double mon = 0.0f;
	for (int i = 0; i < section0.items.count; i ++) {
		CartProductItem *item1 = [section0.items objectAtIndex:i];
		if (item1.isBtnSelect) {
			selectCout ++;
			mon += DoubleRelay(item1.userinfo[@"retailPrice"])*item1.qty;
		}
		
	}
	
	NSMutableAttributedString *str1 = [CommonUtil mutableStringAppendString:@"合计：".color(COLOR_333).font(Font_Size_13)];
	str1.append([NSString stringWithFormat:@"￥%.2f",mon].color(COLOR_RED_).font(Font_Size_13));
	label.attributedText = str1;
	
	if (selectCout == section0.items.count) {
		selbtn.selected = YES;
	}else{
		selbtn.selected = NO;
	}
}

-(void)quanxuan:(UIButton *)btn{
	btn.selected = !btn.selected;
	double mon = 0.0f;
	for (int i = 0; i < section0.items.count; i ++) {
		CartProductItem *item1 = [section0.items objectAtIndex:i];
		item1.isBtnSelect = btn.selected;
		[item1 reloadRowWithAnimation:UITableViewRowAnimationNone];
		mon += DoubleRelay(item1.userinfo[@"retailPrice"])*item1.qty;
	}
	
	NSMutableAttributedString *str1 = [CommonUtil mutableStringAppendString:@"合计：".color(COLOR_333).font(Font_Size_13)];
	str1.append([NSString stringWithFormat:@"￥%.2f",mon].color(COLOR_RED_).font(Font_Size_13));
	label.attributedText = str1;
}

-(void)setEditState{
	if (isEdit) {
		label.hidden = YES;
		label2.hidden = YES;
		[btn4 setTitle:@"删除" forState:UIControlStateNormal];
	}else{
		label.hidden = NO;
		label2.hidden = NO;
		[btn4 setTitle:@"去结算" forState:UIControlStateNormal];
	}
	
	for (int i = 0; i < section0.items.count; i ++) {
		CartProductItem *item1 = [section0.items objectAtIndex:i];
		item1.isEdict = isEdit;
		[item1 reloadRowWithAnimation:UITableViewRowAnimationNone];
	}
}

-(void)editProductNumber{
	WS(bself);
	NSMutableArray *arr = [NSMutableArray arrayWithCapacity:0];
	for (int i = 0; i < section0.items.count; i ++) {
		NSMutableDictionary *dict = [NSMutableDictionary dictionary];
		CartProductItem *item1 = [section0.items objectAtIndex:i];
		[dict setObject:StrRelay(item1.userinfo[@"id"]) forKey:@"id"];
		[dict setObject:[NSString stringWithFormat:@"%d",item1.qty] forKey:@"goodsQty"];
		[arr addObject:dict];
	}
	
	[self showLoading];
	NSString *param = [NSString jsonStringWithObject:arr];
	[NSObject postDataWithHost:Server_Host Path:Api_buyer_cart_alterqty Param:param success:^(id json) {
		[bself getData];
		[bself hiddenLoading];
	} fail:^(id json) {
		[bself hiddenLoading];
		Toast(@"网络错误");
	}];
}
@end
