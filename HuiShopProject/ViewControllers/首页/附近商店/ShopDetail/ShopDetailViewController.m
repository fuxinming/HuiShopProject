//
//  ImportProductViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/11/23.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "ShopDetailViewController.h"
#import "ProductSearchListViewController.h"
#import "SearchProductCell.h"
#import "TitleTip2Cell.h"
#import "CXSeachView.h"

@interface ShopDetailViewController (){
}
@property (nonatomic, strong) NSMutableArray *myArr;
@property (nonatomic,strong)NSArray *remaiArray;
@property (nonatomic,strong)NSArray *shangxinArray;
@end

@implementation ShopDetailViewController

- (void)viewDidLoad {
    self.navHidden =  YES;
    [super viewDidLoad];
	WS(bself);

	self.formManager[@"SearchProductItem"] = @"SearchProductCell";
    self.formManager[@"TitleTip2Item"] = @"TitleTip2Cell";
	self.formTable.frame = CGRectMake(0, NavigationBarH + 100, SCREEN_WIDTH,SCREEN_HEIGHT - NavigationBarH - 100);
	[self addHeadView];
	
    CXSeachView *serchBar = [[CXSeachView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarH)];
    serchBar.searchBtnPress = ^(NSString *keyWords) {
        [bself searchKeyWord:keyWords];
    };
    serchBar.btnClick = ^(NSInteger tag) {
        if (tag == 100) {
            RootNavPop(YES);
        }
    };
    [self.view addSubview:serchBar];
    
    
    [self doManyNetWork];

}

-(void)doManyNetWork{
    WS(bself);
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_group_async(group, queue, ^{
        [bself getRemaiList:^{
            dispatch_semaphore_signal(semaphore);
        }];
    });
    dispatch_group_async(group, queue, ^{
        [bself getShangxinList:^{
            dispatch_semaphore_signal(semaphore);
        }];
    });

    
    dispatch_group_notify(group, queue, ^{
        //3个任务,3个信号等待.
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        
        [bself performSelectorOnMainThread:@selector(requestMyFirstPage) withObject:nil waitUntilDone:YES];
        [bself performSelectorOnMainThread:@selector(hiddenLoading) withObject:nil waitUntilDone:YES];
    });
    
}


-(void)getRemaiList:(void(^)(void))finish{
    WS(bself);
    NSMutableDictionary *dict = [AppUtil getPublicParam];
    [dict setObject:@"20" forKey:@"rp"];
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"curpage"];
    [dict setObject:@"desc" forKey:@"sortorder"];
    [dict setObject:@"qty" forKey:@"sortname"];
    [dict setObject:StrRelay(self.userinfo[@"id"]) forKey:@"marketId"];
    [NSObject postDataWithHost:Server_Host Path:Api_BuyerGoodHot Param:dict isCache:NO success:^(id json) {
        if(IntRelay(json[@"state"]) == 1) {
            if (!ISNULL(json[@"obj"]) && [json[@"obj"] isKindOfClass:[NSArray class]]) {
                bself.remaiArray = json[@"obj"];
            }
        }
        
        FMBlock(finish);
    } fail:^(id json) {
        FMBlock(finish);
    }];
}

-(void)getShangxinList:(void(^)(void))finish{
    WS(bself);
    NSMutableDictionary *dict = [AppUtil getPublicParam];
    [dict setObject:@"20" forKey:@"rp"];
    [dict setObject:[NSNumber numberWithInt:1] forKey:@"curpage"];
    [dict setObject:@"desc" forKey:@"sortorder"];
    [dict setObject:@"qty" forKey:@"sortname"];
    [dict setObject:StrRelay(self.userinfo[@"id"]) forKey:@"marketId"];
    [NSObject postDataWithHost:Server_Host Path:Api_buyer_good_latest Param:dict isCache:NO success:^(id json) {
        if(IntRelay(json[@"state"]) == 1) {
            if (!ISNULL(json[@"obj"]) && [json[@"obj"] isKindOfClass:[NSArray class]]) {
                bself.shangxinArray = json[@"obj"];
            }
        }
        
        FMBlock(finish);
    } fail:^(id json) {
        FMBlock(finish);
    }];
}

-(void)requestMyFirstPage{
    [self requestWithPage:1];
}
- (void)requestWithPage:(int)pageIndex {
	WS(bself);
	NSMutableDictionary *dict = [AppUtil getPublicParam];
	[dict setObject:@"20" forKey:@"rp"];
	[dict setObject:[NSNumber numberWithInt:pageIndex] forKey:@"curpage"];
	[dict setObject:@"asc" forKey:@"sortorder"];
    [dict setObject:@"qty" forKey:@"sortname"];
	[dict setObject:StrRelay(self.userinfo[@"id"]) forKey:@"marketId"];
	[NSObject postDataWithHost:Server_Host Path:Api_BuyerGoodRecommend Param:dict isCache:NO success:^(id json) {
		NSMutableArray *resultArr = [bself getDataArray:json];
		if (resultArr.count == 20) {
			self.hasNextPage = 1;
		}else{
			self.hasNextPage = -1;
		}
		[bself requestFinish:resultArr];
        if (resultArr.count==0 && pageIndex == 1) {
            [bself initEmptyForm:bself.formTable.height andType:1];
        }

		[bself requestComplete];
	} fail:^(id json) {
        [bself initEmptyForm:bself.formTable.height andType:2];
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
    
    if (self.remaiArray.count > 0) {
        TitleTip2Item *t11 = [[TitleTip2Item alloc]init];
        t11.cellHeight = 40;
        t11.t1 = @"热卖商品";
        t11.t1Color = COLOR_333;
        t11.t1Font = Font_Size_16;
        [arrayItems addObject:t11];
        
        SearchProductItem *item01 = [[SearchProductItem alloc]init];
        item01.eventArr = self.remaiArray;
        [arrayItems addObject:item01];
    }
    
    if (self.shangxinArray.count > 0) {
        TitleTip2Item *t12 = [[TitleTip2Item alloc]init];
        t12.cellHeight = 40;
        t12.t1 = @"今日上新";
        t12.t1Color = COLOR_333;
        t12.t1Font = Font_Size_16;
        [arrayItems addObject:t12];
        
        SearchProductItem *item02 = [[SearchProductItem alloc]init];
        item02.eventArr = self.shangxinArray;
        [arrayItems addObject:item02];
    }
    
	SearchProductItem *item1 = [[SearchProductItem alloc]init];
	item1.eventArr = array;
	[arrayItems addObject:item1];
	
	return arrayItems;
}

-(void)addHeadView{
	UIView *headview = [[UIView alloc]initWithFrame:CGRectMake(0, NavigationBarH, SCREEN_WIDTH, 100)];
	[self.view addSubview:headview];
	
	UIImageView *img1 = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
	img1.image = [UIImage imageNamed:@"bkg_shop_goods_title"];
	[headview addSubview:img1];
	
	UIImageView *icon = [[UIImageView alloc]init];
	[icon setWebImageWithUrl:StrRelay(self.userinfo[@"picUrl"]) placeHolder:nil];
	icon.frame = CGRectMake(15, 25, 50, 50);
	[headview addSubview:icon];
	
	UILabel *label11 = [[UILabel alloc] init];
	label11.text = StrRelay(self.userinfo[@"name"]);
	label11.textColor = [UIColor whiteColor];
	label11.font = Font_Size_16;
	label11.frame = CGRectMake(icon.right + 10, icon.top + 5, SCREEN_WIDTH - 80, 22);
	[headview addSubview:label11];
	
	UILabel *label2 = [[UILabel alloc] init];
	label2.text = [NSString stringWithFormat:@"%.2f千米/配送费￥%.2f",DoubleRelay(self.userinfo[@"distance"]),DoubleRelay(self.userinfo[@"dispatchFee"])];
	label2.textColor = [UIColor whiteColor];
	label2.font = Font_Size_13;
	label2.frame = CGRectMake(icon.right + 10, label11.bottom , SCREEN_WIDTH - 80, 22);
	[headview addSubview:label2];
}

-(void)searchKeyWord:(NSString *)keyStr{
	if(ISEmptyStr(keyStr)){
		Toast(@"搜索内容为空");
		return;
	}
	
	WS(bself);
	NSMutableDictionary *dict = [AppUtil getPublicParam];
	[dict setObject:@"10" forKey:@"rp"];
	[dict setObject:keyStr forKey:@"name"];
	[dict setObject:[NSNumber numberWithInt:1] forKey:@"curpage"];
	[dict setObject:@"desc" forKey:@"sortorder"];
	[dict setObject:@"qty" forKey:@"sortname"];
	[dict setObject:StrRelay(self.userinfo[@"id"]) forKey:@"marketId"];
	[self showLoading];
	[NSObject postDataWithHost:Server_Host Path:Api_BuyerGoodSearch Param:dict isCache:NO success:^(id json) {
		if(IntRelay(json[@"state"]) == 1) {
			if (!ISNULL(json[@"obj"]) && [json[@"obj"] isKindOfClass:[NSArray class]]) {
				
				bself.myArr = [NSMutableArray arrayWithArray:json[@"obj"]];
				if (bself.myArr.count > 0) {
					ProductSearchListViewController *vc = [[ProductSearchListViewController alloc]init];
					vc.keyWord = keyStr;
					vc.myArr = bself.myArr;
					vc.marketId = StrRelay(bself.userinfo[@"id"]);
					RootNavPush(vc);
				}else{
					Toast(json[@"msg"]);
				}
			}
		}else{
			Toast(json[@"msg"]);
		}
		
		[bself hiddenLoading];
	} fail:^(id json) {
		Toast(json[@"msg"]);
		[bself hiddenLoading];
	}];
}
@end
