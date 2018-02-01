//
//  MainViewController.m
//  HuiShopProject
//
//  Created by 付新明 on 2017/11/2.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "MainViewController.h"
#import <BaiduMapAPI_Map/BMKMapView.h>
#import "WSBannerCell.h"
#import "MainMenuCell.h"
#import "LeftTitleLabCell.h"
#import "RecommandYouCell.h"
#import "JinKouCell.h"
#import "HotProductCell.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
#import "ProductSearchViewController.h"
#import "NearbyShopViewController.h"
#import "CumShopViewController.h"
#import "ImportProductViewController.h"
#import "MyCollectionViewController.h"
#import "DaySignViewController.h"
#import "SelectCityViewController.h"
#import "ProductDetailViewController.h"
#import "LoginViewController.h"
@interface MainViewController ()<BMKMapViewDelegate>{
    UIView *headView;//导航栏
    float contOff;
    
    UIImageView *loactionImae;
    BOOL isSetLocation;
    UIView  *noShopView;
}
@property (nonatomic,strong)NSArray *bannarArray;
@property (nonatomic,strong)NSArray *likeArray;
@property (nonatomic,strong)NSArray *jinkouArray;
@property (nonatomic,strong)NSArray *poiArray;
@property (nonatomic,strong)UILabel *titleLab;

@end

@implementation MainViewController
@synthesize titleLab;
- (void)viewDidLoad {
    self.navHidden = YES;
    [super viewDidLoad];
    WS(bself);
    self.navigationController.navigationBarHidden = YES;
    self.fd_prefersNavigationBarHidden = YES;
    self.formTable.frame = CGRectMake(0, NavigationBarH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarH - TabBarH);
    self.formManager[@"WSBannerItem"] = @"WSBannerCell";
    self.formManager[@"MainMenuItem"] = @"MainMenuCell";
    self.formManager[@"LeftTitleLabItem"] = @"LeftTitleLabCell";
    self.formManager[@"RecommandYouItem"] = @"RecommandYouCell";
    self.formManager[@"JinKouItem"] = @"JinKouCell";
    self.formManager[@"HotProductItem"] = @"HotProductCell";
    [self initNavBarView];
    [[BaiduMapService sharedInstance]starLocationComplete:^(NSArray *poiInfoArray) {
		bself.poiArray = [NSMutableArray arrayWithArray:poiInfoArray];
        if (poiInfoArray.count > 0) {
            BMKPoiInfo *info =poiInfoArray[0];
            
            bself.titleLab.text = info.name;
			[BaiduMapService sharedInstance].currentAddress = [NSString stringWithFormat:@"%@%@%@",info.city,info.address,info.name];
            [bself resetImageFrame];
            [[BaiduMapService sharedInstance] stopLocation];
            
			[bself setBuyerLocate:[BaiduMapService sharedInstance].lat and:[BaiduMapService sharedInstance].lon];
            isSetLocation = YES;
        }
    } ];

}

-(void)setBuyerLocate:(double)lat and:(double)lon{
    WS(bself);
    if (isSetLocation) {
        return;
    }
    NSMutableDictionary *param = [AppUtil getPublicParam];
    [param setObject:[NSNumber numberWithDouble:lat] forKey:@"lat"];
    [param setObject:[NSNumber numberWithDouble:lon] forKey:@"lng"];
    [NSObject postDataWithHost:Server_Host Path:Api_BuyerLocate Param:param isCache:NO success:^(id json) {
        if (IntRelay(json[@"state"]) == 1) {
			if (noShopView) {
				[noShopView removeFromSuperview];
			}
            [bself doManyNetWork];
        }else{
            [bself initNoShopView];
        }
    } fail:^(id json) {
		[bself initNoShopView];
    }];
}



-(void)initNavBarView{
    headView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,SCREEN_WIDTH, NavigationBarH)];
    headView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:headView];
    [headView removeAllSubviews];
    loactionImae = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loacationSuccess"]];
    [headView addSubview:loactionImae];

    titleLab = [[UILabel alloc] initWithFrame:CGRectMake(31, 52, 50, 22)];
    titleLab.font = Font_Size_16;
    titleLab.textAlignment = 0;
    titleLab.text = @"定位中...";
    titleLab.textColor = COLOR_333;
    [headView addSubview:titleLab];
    
    [self resetImageFrame];
    
    UIButton* rightBtn = [[UIButton alloc] initWithFrame:CGRectMake(SCREEN_WIDTH - 45, NavigationBarH - 46, 40, 40)];
    [rightBtn setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:rightBtn];
    
    
    UIButton* midBtn = [[UIButton alloc] initWithFrame:CGRectMake((SCREEN_WIDTH - 100)/2, 0,100, NavigationBarH)];
    [midBtn addTarget:self action:@selector(midBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [headView addSubview:midBtn];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, headView.height - 0.5,SCREEN_WIDTH, 0.5)];
    lineView.backgroundColor = COLOR_ddd;
    [headView addSubview:lineView];
}


-(void)resetImageFrame{
    [titleLab sizeToFit];
    
    float left = (SCREEN_WIDTH - titleLab.width - 20 - 10)/2;
    
    loactionImae.frame = CGRectMake(left, NavigationBarH - 36, 20, 20);
    
    titleLab.frame = CGRectMake(loactionImae.right + 10, NavigationBarH - 36, titleLab.width, 20);
}

-(void)doManyNetWork{
    WS(bself);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    //创建全局并行
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //任务一
    dispatch_group_async(group, queue, ^{
        [bself getBannerList:^{
            dispatch_semaphore_signal(semaphore);
        }];
    });
    //任务二
    dispatch_group_async(group, queue, ^{
        [bself getLikeList:^{
            dispatch_semaphore_signal(semaphore);
        }];
    });
    //任务三
    dispatch_group_async(group, queue, ^{
        [bself getJinKouList:^{
            dispatch_semaphore_signal(semaphore);
        }];
        
    });
   
    
    dispatch_group_notify(group, queue, ^{
        //3个任务,3个信号等待.
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);

        
        //这里就是所有异步任务请求结束后执行的代码
        [bself performSelectorOnMainThread:@selector(reloadSection1) withObject:nil waitUntilDone:YES];
        [bself performSelectorOnMainThread:@selector(beginRefrash) withObject:nil waitUntilDone:YES];
        [bself performSelectorOnMainThread:@selector(hiddenLoading) withObject:nil waitUntilDone:YES];
    });
  
}

-(void)reloadSection1{
    [self.section1 removeAllItems];
    WSBannerItem *bannar = [[WSBannerItem alloc]init];
    bannar.bannerArray = self.bannarArray;
    [self.section1 addItem:bannar];
    
    MainMenuItem *menuItem = [[MainMenuItem alloc]init];
    menuItem.btnClick = ^(NSInteger tag) {
        switch (tag) {
            case 100:{
                NearbyShopViewController *vc = [[NearbyShopViewController alloc]init];
                RootNavPush(vc);
            }
                break;
            case 101:{
				if (IsLogin) {
					DaySignViewController *vc = [[DaySignViewController alloc]init];
					RootNavPush(vc);
				}else{
					LoginViewController *vc = [[LoginViewController alloc]init];
					RootNavPush(vc);
				}
				
            }
                break;
            case 102:{
                ImportProductViewController *vc = [[ImportProductViewController alloc]init];
                RootNavPush(vc);
            }
                break;
            case 103:{
                CumShopViewController *vc = [[CumShopViewController alloc]init];
                RootNavPush(vc);
            }
                break;
            case 104:{
				MyCollectionViewController *vc = [[MyCollectionViewController alloc]init];
				vc.type = 2;
				RootNavPush(vc);
            }
                break;
            default:
                break;
        }
    };
    [self.section1 addItem:menuItem];
    
    if (self.likeArray.count>0) {
        LeftTitleLabItem *itemT1 = [[LeftTitleLabItem alloc]init];
        itemT1.titleText = @"————   猜你喜欢   ————";
        itemT1.textColor = COLOR_STATE_BLUE;
        itemT1.textAlignment = NSTextAlignmentCenter;
        [self.section1 addItem:itemT1];
        
        RecommandYouItem *recomItem = [[RecommandYouItem alloc]init];
        recomItem.eventArr = self.likeArray;
		recomItem.selectProduct = ^(id info) {
			ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
			vc.userinfo = info;
			RootNavPush(vc);
		};
        [self.section1 addItem:recomItem];
    }
    
    if (self.likeArray.count>0) {
        LeftTitleLabItem *itemT2 = [[LeftTitleLabItem alloc]init];
        itemT2.titleText = @"————  进口零食   ————";
        itemT2.textColor = COLOR_STATE_BLUE;
        itemT2.textAlignment = NSTextAlignmentCenter;
        [self.section1 addItem:itemT2];
        
        JinKouItem *jinItem = [[JinKouItem alloc]init];
        jinItem.eventArr = self.jinkouArray;
		jinItem.selectProduct = ^(id info) {
			ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
			vc.userinfo = info;
			RootNavPush(vc);
		};
        [self.section1 addItem:jinItem];
    }
    
    
    LeftTitleLabItem *itemT3 = [[LeftTitleLabItem alloc]init];
    itemT3.titleText = @"————   销量爆款   ————";
    itemT3.textColor = COLOR_STATE_BLUE;
    itemT3.textAlignment = NSTextAlignmentCenter;
    [self.section1 addItem:itemT3];
    [self.section1 reloadSectionWithAnimation:UITableViewRowAnimationNone];
}
-(void)getBannerList:(void(^)(void))finish{
    WS(bself);
    
    [NSObject postDataWithHost:Server_Host Path:Api_BuyerCarousel Param:nil isCache:NO success:^(id json) {
        if(IntRelay(json[@"state"]) == 1) {
            if (!ISNULL(json[@"obj"]) && [json[@"obj"] isKindOfClass:[NSArray class]]) {
                bself.bannarArray = json[@"obj"];
            }
        }
        
        FMBlock(finish);
    } fail:^(id json) {
        FMBlock(finish);
    }];
}

-(void)getLikeList:(void(^)(void))finish{
    WS(bself);
    NSMutableDictionary *dict = [AppUtil getPublicParam];
    [dict setObject:@"5" forKey:@"rp"];
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"curpage"];
    [dict setObject:@"desc" forKey:@"sortorder"];
    [dict setObject:@"qty" forKey:@"sortname"];
    [NSObject postDataWithHost:Server_Host Path:Api_BuyerGoodRecommend Param:dict isCache:NO success:^(id json) {
        if(IntRelay(json[@"state"]) == 1) {
            if (!ISNULL(json[@"obj"]) && [json[@"obj"] isKindOfClass:[NSArray class]]) {
                bself.likeArray = json[@"obj"];
            }
        }
        
        FMBlock(finish);
    } fail:^(id json) {
        FMBlock(finish);
    }];
}

-(void)getJinKouList:(void(^)(void))finish{
    WS(bself);
    NSMutableDictionary *dict = [AppUtil getPublicParam];
    [dict setObject:@"20" forKey:@"rp"];
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"curpage"];
    [dict setObject:@"desc" forKey:@"sortorder"];
    [dict setObject:@"qty" forKey:@"sortname"];
    [NSObject postDataWithHost:Server_Host Path:Api_BuyerGoodImport Param:dict isCache:NO success:^(id json) {
        if(IntRelay(json[@"state"]) == 1) {
            if (!ISNULL(json[@"obj"]) && [json[@"obj"] isKindOfClass:[NSArray class]]) {
                bself.jinkouArray = json[@"obj"];
            }
        }
        
        FMBlock(finish);
    } fail:^(id json) {
        FMBlock(finish);
    }];
}

- (void)requestWithPage:(int)pageIndex {
    WS(bself);
    NSMutableDictionary *dict = [AppUtil getPublicParam];
    [dict setObject:@"20" forKey:@"rp"];
    [dict setObject:[NSNumber numberWithInt:pageIndex] forKey:@"curpage"];
    [dict setObject:@"desc" forKey:@"sortorder"];
    [dict setObject:@"qty" forKey:@"sortname"];
    [NSObject postDataWithHost:Server_Host Path:Api_BuyerGoodHot Param:dict isCache:NO success:^(id json) {
        NSMutableArray *resultArr = [bself getDataArray:json];
        if (resultArr.count == 20) {
            self.hasNextPage = 1;
        }else{
            self.hasNextPage = -1;
        }
        [bself requestFinish:resultArr];
        [bself requestComplete];
    } fail:^(id json) {
        [bself requestComplete];
    }];
}

- (NSMutableArray *)getDataArray:(id)json {
    NSMutableArray *ar = [[NSMutableArray alloc] init];
    if ([json[@"obj"] isKindOfClass:[NSArray class]]) {
        [ar addObjectsFromArray:json[@"obj"]];
    }
    return ar;
}

- (NSMutableArray *)createItems:(NSArray *)array
{
    
    NSMutableArray *arrayItems = [[NSMutableArray alloc] init];
    
    
    HotProductItem *arrItem = [[HotProductItem alloc]init];
    arrItem.eventArr = array;
	arrItem.selectProduct = ^(id info) {
		ProductDetailViewController *vc = [[ProductDetailViewController alloc]init];
		vc.userinfo = info;
		RootNavPush(vc);
	};
    [arrayItems addObject:arrItem];
    
    return arrayItems;
}



-(void)rightBtnClick{
    ProductSearchViewController *vc = [[ProductSearchViewController alloc]init];
    RootNavPush(vc);
}
-(void)midBtnClick{
	WS(bself);
    SelectCityViewController *vc = [[SelectCityViewController alloc]init];
	vc.poiArray = [NSMutableArray arrayWithArray:self.poiArray];
	vc.selectAddress = ^(BMKPoiInfo *info1) {
		isSetLocation = NO;
        NSString *str2 = StrRelay(info1.name);
		bself.titleLab.text = str2;
		[bself resetImageFrame];
		[bself setBuyerLocate:info1.pt.latitude and:info1.pt.longitude];
	};
	RootNavPush(vc);
}

-(void)initNoShopView{
    if (noShopView) {
        [noShopView removeAllSubviews];
        [noShopView removeFromSuperview];
        noShopView = nil;
    }
    
    noShopView = [[UIView alloc]initWithFrame:CGRectMake(0, NavigationBarH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarH - TabBarH)];
    [self.view addSubview:noShopView];
    
    UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, noShopView.width, noShopView.height)];
    img1.image = [UIImage imageNamed:@"bg_map"];
    [noShopView addSubview:img1];
    
    UIView *conTView = [[UIView alloc]initWithFrame:CGRectMake(20, 100, SCREEN_WIDTH - 40, noShopView.height - 220)];
    conTView.backgroundColor = [UIColor whiteColor];
    [noShopView addSubview:conTView];
    
	UILabel *label1 = [[UILabel alloc] init];
	label1.text = @"便利店是为了小区住户提供快捷生活服务在线超市，您只需要具有一个小仓库或者店面，即可申请开通一家线上超市。";
	label1.textColor = COLOR_333;
	label1.font = Font_Size_14;
	label1.frame = CGRectMake(20, 20, conTView.width - 40, 200);
	label1.numberOfLines = 0;
	[label1 sizeToFit];
	[conTView addSubview:label1];
	
	UILabel *label2 = [[UILabel alloc] init];
	label2.text = @"您附近还没有便利店，您可以申请开店自己做老板，提供服务，创造商机";
	label2.textColor = COLOR_333;
	label2.font = Font_Size_14;
	label2.frame = CGRectMake(20,label1.bottom + 20, conTView.width - 40, 200);
	label2.numberOfLines = 0;
	[label2 sizeToFit];
	[conTView addSubview:label2];
	
	UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
	[btn setTitle:@"我要申请开店" forState:UIControlStateNormal];
	[btn setTitleColor:COLOR_RED_ forState:UIControlStateNormal];
	[btn.titleLabel setFont:Font_Size_16];
	btn.tag = 100;
	btn.frame = CGRectMake((conTView.width - 140)/2, conTView.height - 70, 140, 36);
	View_Border_Radius(btn, 4, 1, COLOR_RED_);
	[btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
	[conTView addSubview:btn];
}

-(void)btnClick:(UIButton *)btn{
	[AppUtil callPhoneNum:@"4006433369"];
}
@end
