//
//  MapViewController.m
//  HuiShopProject
//
//  Created by 付新明 on 2017/12/31.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "MapViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>//引入云检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>//引入周边雷达功能所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "MyPointAnnotation.h"
#import "AddressContentView.h"
#import "AddressDetailInfoCell.h"

@interface MapViewController ()<UITextFieldDelegate,BMKMapViewDelegate,RETableViewManagerDelegate>{
    UIView *headView;//导航栏
    BMKMapView* _mapView;
    UITextField *seachTF;
	NSArray *actArray;
}
@property (nonatomic,assign)CLLocationCoordinate2D pt;
@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    WS(bself);
    self.navBar.hidden = YES;
	self.pt = [BaiduMapService sharedInstance].pt;
    self.fd_interactivePopDisabled = YES;
    [self initNavBarView];
    [self setMapView];
	
	actArray = [[NSArray alloc] initWithObjects:@"写字楼",@"小区",@"学校",nil];
	[self tabActSetting];
	[self CreateContentScrollView];
	[self initView];
}
- (void)initView
{
	_formTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationBarH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarH) style:UITableViewStylePlain];
	_formTable.showsVerticalScrollIndicator = NO;
	_formTable.separatorStyle = UITableViewCellSeparatorStyleNone;
	_formTable.backgroundColor = [UIColor clearColor];
	_formTable.bounces = NO;
	_formTable.estimatedRowHeight = 0;
	_formTable.estimatedSectionHeaderHeight = 0;
	_formTable.estimatedSectionFooterHeight = 0;
	_formTable.hidden = YES;
#ifdef __IPHONE_11_0
	if ([_formTable respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
		_formTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
	}
#endif
	[self.view addSubview:_formTable];
	
	_formManager = [[RETableViewManager alloc] initWithTableView:_formTable];
	_formManager.delegate = self;
	_formManager[@"AddressDetailInfoItem"] = @"AddressDetailInfoCell";
}
#pragma mark - RETableViewManagerDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex{
	return 0;
}


-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
}
-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

-(void)initNavBarView{
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, NavigationBarH)];
    headView.backgroundColor = COLOR_RED_;
    [self.view addSubview:headView];
    [headView removeAllSubviews];
    
    
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    leftBtn.frame = CGRectMake(0, StatusBarH, 50, 44);
    leftBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 15, 12, 15);
    leftBtn.tag= 100;
    [leftBtn addTarget:self action:@selector(btnPress:) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [rightBtn setTitle:@"搜索" forState:UIControlStateNormal];
    [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    rightBtn.frame = CGRectMake(SCREEN_WIDTH-50, StatusBarH, 50, 44);
    rightBtn.tag= 101;
    [rightBtn addTarget:self action:@selector(serchClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:rightBtn];
    
    UIView *searchBg = [[UIView alloc]initWithFrame:CGRectMake(60, StatusBarH + 6, SCREEN_WIDTH - 120, 32 )];
    searchBg.backgroundColor = [UIColor whiteColor];
    searchBg.layer.cornerRadius = 4;
    [headView addSubview:searchBg];
    
    UIImageView *searchImage = [[UIImageView alloc]initWithFrame:CGRectMake(10, 4.5, 23, 23)];
    searchImage.image = [UIImage imageNamed:@"search"];
    [searchBg addSubview:searchImage];
    
    seachTF = [[UITextField alloc]initWithFrame:CGRectMake(43, 1,searchBg.width -33 - 20, 30)];
    seachTF.placeholder = @"请输入地址进行搜索";
    seachTF.font = Font_Size_14;
    seachTF.delegate = self;
    seachTF.clearButtonMode =UITextFieldViewModeAlways;
    seachTF.returnKeyType = UIReturnKeySearch;
    [seachTF addTarget:self action:@selector(textFieldDidChanged:) forControlEvents:UIControlEventEditingChanged];
    [searchBg addSubview:seachTF];
    
    
    UIView *actionBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
    actionBar.backgroundColor = [UIColor whiteColor];
    UIButton *doneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    doneBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [doneBtn setTitle:@"完成" forState:UIControlStateNormal];
    [doneBtn setTitleColor:COLOR_RED_ forState:UIControlStateNormal];
    doneBtn.frame = CGRectMake(SCREEN_WIDTH - 60, 0, 60, 30);
    [doneBtn addTarget:self action:@selector(doneBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [actionBar addSubview:doneBtn];
    
    UIView *line1 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.5)];
    line1.backgroundColor = COLOR_ddd;
    [actionBar addSubview:line1];
    
    seachTF.inputAccessoryView = actionBar;
}


-(void)setMapView{
    _mapView = [[BMKMapView alloc]initWithFrame:CGRectMake(0, NavigationBarH, SCREEN_WIDTH, SCREEN_HEIGHT - 300 - NavigationBarH)];
    [_mapView setZoomLevel:15];
    _mapView.showsUserLocation = YES;
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    [_mapView removeOverlays:_mapView.overlays];
    _mapView.centerCoordinate = CLLocationCoordinate2DMake([BaiduMapService sharedInstance].lat, [BaiduMapService sharedInstance].lon);
    [self.view addSubview:_mapView];
    
    [self setPoint:CLLocationCoordinate2DMake([BaiduMapService sharedInstance].lat, [BaiduMapService sharedInstance].lon)];
}
//设置大头标到指定位置
- (void)setPoint:(CLLocationCoordinate2D)pt{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
    [_mapView removeAnnotations:array];
    array = [NSArray arrayWithArray:_mapView.overlays];
    [_mapView removeOverlays:array];
    
    BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
    item.coordinate = pt;
    [_mapView addAnnotation:item];
}

// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    WS(bself);
    
    //普通annotation
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        NSString *AnnotationViewID = @"renameMark";
        BMKPinAnnotationView *annotationView = (BMKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            annotationView.draggable = YES;
            // 从天上掉下效果
            annotationView.animatesDrop = YES;
        }
        return annotationView;
    }
    return nil;
}

-(void)textFieldDidChanged:(UITextField *)textField{
    [CommonUtil checkTextField:textField maxLen:100];
	if (textField.text.length == 0) {
		self.formTable.hidden = YES;
	}
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    if ([textField.text trim].length > 0) {
		[self serchClick];
        [textField resignFirstResponder];
    }
    return YES;
}


-(void)btnPress:(UIButton *)btn{
    if (btn.tag == 100) {
        RootNavPop(YES);
    }
}

-(void)doneBtnClick{
    [seachTF resignFirstResponder];
}

-(void)initForm:(NSArray *)pArr{
	WS(bself);
	self.formTable.hidden = NO;
	RETableViewSection *section0 = [RETableViewSection section];
	for (int i = 1; i < pArr.count; i ++) {
		BMKPoiInfo *info1 =pArr[i];
		AddressDetailInfoItem *item04 = [[AddressDetailInfoItem alloc]init];
		item04.str1 = info1.name;
		item04.str2 = info1.address;
		item04.info = info1;
		item04.selectionHandler = ^(AddressDetailInfoItem * item) {
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
- (void)serchClick{
	WS(bself);
	if ([seachTF.text trim].length > 0) {
		
		[seachTF resignFirstResponder];
		[[BaiduMapService sharedInstance]poiSearch:self.city detail:seachTF.text complete:^(NSArray *poiInfoArray) {
			[bself initForm:poiInfoArray];
		}];
		
	}else{
		Toast(@"搜索内容为空");
	}
}

- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
	self.pt = mapView.centerCoordinate;
	[self setPoint:self.pt];
	[self performSelector:@selector(viewReload) withObject:nil afterDelay:0.01];
}


- (void)tabActSetting
{
	WS(bself);
	NSMutableArray *itemsArray = [NSMutableArray array];
	for (int i = 0; i < [actArray count]; i++) {
		float w = 80;
		if (actArray.count<6) {
			w = SCREEN_WIDTH/[actArray count];
		}
		NSDictionary *dic = @{TITLEKEY:actArray[i],
							  TITLEWIDTH:[NSNumber numberWithFloat:w]
							  };
		[itemsArray addObject:dic];
	}
	if (_mMenuHriZontal == nil) {
		_mMenuHriZontal = [[FMActMenu alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT - 300, SCREEN_WIDTH, 40) ButtonItems:itemsArray titleColor:UIColorFromRGB(0xff584d) defaultIndex:self.curIndex];
		_mMenuHriZontal.onClick = ^(id item,int index){
			[bself.mScrollPageView moveScrollowViewAthIndex:index];
		};
		[self.view addSubview:_mMenuHriZontal];
	}
}

- (void)CreateContentScrollView
{
	WS(bself);
	//初始化滑动列表
	float height = 300 - 40  - 0.5;
	if (_mScrollPageView == nil) {
		_mScrollPageView = [[FMScrollContentView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT-300 + 40 + 0.5, SCREEN_WIDTH, height)];
	}
	_mScrollPageView.createViewAtIndex = ^(int i){
		AddressContentView *dView1 = [[AddressContentView alloc]initWithFrame:CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, height) andKey:actArray[i] andPt:self.pt];
		dView1.tag = 100+i;
		dView1.selectAddress = ^(BMKPoiInfo *info) {
			if (bself.selectAddress) {
				bself.selectAddress(info);
			}
			RootNavPop(YES);
		};
		return dView1;
	};
	_mScrollPageView.scrollPageView = ^(int page){
		AddressContentView *dView1 = [bself.mScrollPageView viewWithTag:100+page];
		[dView1 beginRefrash];
		
		[bself.mMenuHriZontal changeButtonStateAtIndex:page];
	};
	[_mScrollPageView setContentOfTables:actArray.count];
	[self.view addSubview:_mScrollPageView];
	
	[bself.mScrollPageView setScrollowViewAthIndex:self.curIndex];
}

-(void)viewReload{
	for (int i = 0; i < actArray.count; i ++) {
		AddressContentView *dView1 = [_mScrollPageView viewWithTag:100+i];
		dView1.key = actArray[i];
		dView1.pt = self.pt;
		[dView1 beginRefrash];
	}
}
@end
