//
//  NearbyShopViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/11/23.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "NearbyShopViewController.h"
#import "ConditionSiftBar3.h"
#import "NearByMarketInfoCell.h"
#import "ShopDetailViewController.h"
@interface NearbyShopViewController (){
    NSString *sortName;
}

@end

@implementation NearbyShopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navBar.title = @"附近商店";
    WS(bself);
    self.formManager[@"NearByMarketInfoItem"] = @"NearByMarketInfoCell";
    self.formTable.frame = CGRectMake(0, NavigationBarH + 42, SCREEN_WIDTH,SCREEN_HEIGHT - NavigationBarH - 42);
    
    
    ConditionSiftBar3 *siftBar = [[ConditionSiftBar3 alloc]initWithFrame:CGRectMake(0, NavigationBarH, SCREEN_WIDTH, 42)];
    siftBar.rightBtnClick = ^(NSString *str) {
        sortName = str;
        [bself requestFirstPage];
    };
    [self.view addSubview:siftBar];
    sortName = @"qty";
    [self beginRefrash];
}

- (void)requestWithPage:(int)pageIndex {
    WS(bself);
    NSMutableDictionary *dict = [AppUtil getPublicParam];
    [dict setObject:@"10" forKey:@"rp"];
    [dict setObject:[NSNumber numberWithInt:pageIndex] forKey:@"curpage"];
    [dict setObject:@"asc" forKey:@"sortorder"];
    [dict setObject:sortName forKey:@"sortname"];

    [NSObject postDataWithHost:Server_Host Path:Api_buyer_market_list Param:dict isCache:NO success:^(id json) {
        NSMutableArray *resultArr = [bself getDataArray:json];
        if (resultArr.count == 10) {
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
    for (int i = 0; i < array.count; i++) {
        NSDictionary *dict=[array objectAtIndex:i];
        NearByMarketInfoItem *item1 = [[NearByMarketInfoItem alloc]init];
        item1.userinfo = dict;
        item1.selectionHandler = ^(NearByMarketInfoItem * item) {
            ShopDetailViewController *vc= [[ShopDetailViewController alloc]init];
            vc.userinfo = item.userinfo;
            RootNavPush(vc);
        };
        [arrayItems addObject:item1];
    }
    
    
    return arrayItems;
}

@end
