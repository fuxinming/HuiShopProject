//
//  ImportProductViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/11/23.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "SelectCityViewController.h"
#import "TitleTipCell.h"
#import "BaiduMapService.h"

#import "GYZChooseCityController.h"
#import "MapViewController.h"
@interface SelectCityViewController ()<UITextFieldDelegate,GYZChooseCityDelegate>{
    UIImageView *loactionImae;
    UILabel *titleLab;
}
@property (nonatomic,strong) UITextField *seachTF;
@end

@implementation SelectCityViewController
@synthesize seachTF;
- (void)viewDidLoad {
    self.navHidden = YES;
    [super viewDidLoad];
	WS(bself);
	self.formManager[@"TitleTipItem"] = @"TitleTipCell";
	
    [self initNavBarView];
	
	self.formTable.frame = CGRectMake(0, NavigationBarH + 40, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarH - 40);
	
	
	if (self.poiArray.count > 0) {
		BMKPoiInfo *info =self.poiArray[0];
		titleLab.text = info.city;
		[bself resetImageFrame];
		[bself initForm];
	}else{
		[[BaiduMapService sharedInstance]starLocationComplete:^(NSArray *poiInfoArray) {
			bself.poiArray = [NSMutableArray arrayWithArray:poiInfoArray];
			if (poiInfoArray.count > 0) {
				BMKPoiInfo *info =poiInfoArray[0];
				titleLab.text = info.city;
				[bself resetImageFrame];
				[[BaiduMapService sharedInstance] stopLocation];
			}
			
			[bself initForm];
		} ];
	}
}

-(void)initForm{
	WS(bself);
	RETableViewSection *section0 = [RETableViewSection section];
	
	TitleTipItem *item01 = [[TitleTipItem alloc]init];
	item01.t1 = @"当前地址";
	item01.tFont = Font_Size_15;
	item01.tColor = COLOR_999;
//	item01.rightImage = @"reloaction";
	item01.haveLine = NO;
	item01.haveArrow = NO;
	item01.backColor = Color_Clear;
	[section0 addItem:item01];
	if (self.poiArray.count > 0) {
		BMKPoiInfo *info =self.poiArray[0];
		TitleTipItem *item02 = [[TitleTipItem alloc]init];
		item02.t1 = [NSString stringWithFormat:@"%@%@",info.address,info.name];
		item02.info = info;
		item02.tFont = Font_Size_13;
		item02.rightImage = @"reloaction";
		item02.haveLine = NO;
		item02.selectionHandler = ^(TitleTipItem * item) {
			if (bself.selectAddress) {
				bself.selectAddress(item.info);
			}
			RootNavPop(YES);
		};
		[section0 addItem:item02];
		
		TitleTipItem *item03 = [[TitleTipItem alloc]init];
		item03.t1 = @"附近地址";
		item03.tFont = Font_Size_15;
		item03.tColor = COLOR_999;
		//	item01.rightImage = @"reloaction";
		item03.haveLine = NO;
		item03.haveArrow = NO;
		item03.backColor = Color_Clear;
		[section0 addItem:item03];
		
		for (int i = 1; i < self.poiArray.count; i ++) {
			BMKPoiInfo *info1 =self.poiArray[i];
			TitleTipItem *item04 = [[TitleTipItem alloc]init];
			item04.t1 = [NSString stringWithFormat:@"%@%@",info1.address,info1.name];
			item04.info = info1;
			item04.tFont = Font_Size_13;
			item04.haveArrow = NO;
			item04.selectionHandler = ^(TitleTipItem * item) {
				if (bself.selectAddress) {
					bself.selectAddress(item.info);
				}
				RootNavPop(YES);
			};
			[section0 addItem:item04];
		}
		
		TitleTipItem *item05 = [[TitleTipItem alloc]init];
		item05.t1 = @"更多地址";
		item05.tFont = Font_Size_13;
        item05.selectionHandler = ^(id item) {
            MapViewController *map = [[MapViewController alloc]init];
			map.city = titleLab.text;
			map.selectAddress = ^(BMKPoiInfo *info) {
				if (bself.selectAddress) {
					bself.selectAddress(info);
				}
				RootNavPop(NO);
			};
            RootNavPush(map);
            
        };
		[section0 addItem:item05];
	}
	[self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
	[self.formTable reloadData];
}


-(void)initNavBarView{
    UIView *headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, NavigationBarH + 40)];
    headView.backgroundColor = COLOR_RED_;
    [self.view addSubview:headView];
    [headView removeAllSubviews];
	
	UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
	[leftBtn setImage:[UIImage imageNamed:@"leftArrow"] forState:UIControlStateNormal];
	leftBtn.frame = CGRectMake(0, StatusBarH, 50, 44);
	leftBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 15, 12, 15);
	leftBtn.tag= 100;
	[leftBtn addTarget:self action:@selector(leftbtnPress:) forControlEvents:UIControlEventTouchUpInside];
	[headView addSubview:leftBtn];
    
    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(31, 52, 50, 22)];
    titleLab.font = Font_Size_16;
    titleLab.textAlignment = 0;
    titleLab.text = @"定位中...";
    titleLab.textColor = [UIColor whiteColor];
    [headView addSubview:titleLab];
	
	loactionImae = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"whitedownArrow"]];
	[headView addSubview:loactionImae];
	
	UIButton* midBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, 0, 100, NavigationBarH)];
	[midBtn addTarget:self action:@selector(midBtnClick) forControlEvents:UIControlEventTouchUpInside];
	[headView addSubview:midBtn];
	
    [self resetImageFrame];
    
    seachTF = [[UITextField alloc]initWithFrame:CGRectMake(60, NavigationBarH,SCREEN_WIDTH - 120, 30)];
    seachTF.placeholder = @"请输入地址";
    seachTF.font = Font_Size_14;
	seachTF.textAlignment = NSTextAlignmentCenter;
    seachTF.delegate = self;
    seachTF.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 12, 30)];
    seachTF.backgroundColor = [UIColor whiteColor];
    [seachTF becomeFirstResponder];
    seachTF.clearButtonMode = UITextFieldViewModeAlways;
    seachTF.returnKeyType = UIReturnKeySearch;
	[seachTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
	View_Border_Radius(seachTF, 4, 0, Color_Clear);
    [headView addSubview:seachTF];
    
    
    UIView *actionBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    actionBar.backgroundColor = COLOR_ddd;
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:COLOR_RED_ forState:UIControlStateNormal];
    doneBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 0, 60, 30);
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [actionBar addSubview:doneBtn];
	seachTF.inputAccessoryView = actionBar;
	
    UIButton* rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 55, NavigationBarH, 50, 30)];
    [rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.titleLabel.font = Font_Size_14;
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:rightBtn];
	
}

-(void)rightBtnClick{
	[self SerchClick];
}

-(void)resetImageFrame{
    [titleLab sizeToFit];
    
    float left = (SCREEN_WIDTH - titleLab.width - 20 - 10)/2;
     titleLab.frame = CGRectMake(left, NavigationBarH - 36, titleLab.width, 20);
    loactionImae.frame = CGRectMake(titleLab.right + 10, NavigationBarH - 36, 20, 20);
	
}
-(void)leftbtnPress:(UIButton *)btn{
    RootNavPop(YES);
}
- (void)SerchClick{
	WS(bself);
    if ([seachTF.text trim].length > 0) {
     
        [seachTF resignFirstResponder];
		[[BaiduMapService sharedInstance]poiSearch:titleLab.text detail:seachTF.text complete:^(NSArray *poiInfoArray) {
			[bself initForm:poiInfoArray];
		}];
		
    }else{
        Toast(@"搜索内容为空");
    }
}
-(void)textFieldDidChanged:(UITextField *)textField{
    [CommonUtil checkTextField:textField maxLen:100];
	if (textField.text.length == 0) {
		[self initForm];
	}
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
 
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField.text trim].length > 0) {
		[self SerchClick];
        [textField resignFirstResponder];
    }
    return YES;
}



-(void)doneBtnClick{
    [seachTF resignFirstResponder];
}

-(void)midBtnClick{
	GYZChooseCityController *cityPickerVC = [[GYZChooseCityController alloc] init];
	[cityPickerVC setDelegate:self];
	
	//    cityPickerVC.locationCityID = @"1400010000";
	//    cityPickerVC.commonCitys = [[NSMutableArray alloc] initWithArray: @[@"1400010000", @"100010000"]];        // 最近访问城市，如果不设置，将自动管理
	    cityPickerVC.hotCitys = @[@"100010000", @"200010000", @"300210000", @"600010000", @"300110000"];
	
	[self presentViewController:[[UINavigationController alloc] initWithRootViewController:cityPickerVC] animated:YES completion:^{
		
	}];
	
}

-(void)initForm:(NSArray *)pArr{
	WS(bself);
	RETableViewSection *section0 = [RETableViewSection section];
	for (int i = 1; i < pArr.count; i ++) {
		BMKPoiInfo *info1 =pArr[i];
		TitleTipItem *item04 = [[TitleTipItem alloc]init];
		item04.t1 = [NSString stringWithFormat:@"%@%@",info1.address,info1.name];
		item04.tFont = Font_Size_13;
		item04.info = info1;
		item04.haveArrow = NO;
		item04.selectionHandler = ^(TitleTipItem * item) {
			if (bself.selectAddress) {
				bself.selectAddress(item.info);
			}
			RootNavPop(YES);
		};
		[section0 addItem:item04];
	}
	
	[self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
	[self.formTable reloadData];
}

#pragma mark - GYZCityPickerDelegate
- (void) cityPickerController:(GYZChooseCityController *)chooseCityController didSelectCity:(GYZCity *)city
{
	[titleLab setText:city.cityName];
	[self resetImageFrame];
	[chooseCityController dismissViewControllerAnimated:YES completion:^{
		
	}];
}

- (void) cityPickerControllerDidCancel:(GYZChooseCityController *)chooseCityController
{
	[chooseCityController dismissViewControllerAnimated:YES completion:^{
		
	}];
}
@end
