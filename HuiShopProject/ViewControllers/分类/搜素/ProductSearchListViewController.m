//
//  ProductSearchListViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/11/20.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "ProductSearchListViewController.h"
#import "CXSeachView.h"
#import "ConditionSiftBar.h"
#import "SearchProductCell.h"
@interface ProductSearchListViewController (){
    NSString *sortName;
}

@end

@implementation ProductSearchListViewController

- (void)viewDidLoad {
    self.navHidden = YES;
    [super viewDidLoad];
    WS(bself);
    self.formManager[@"SearchProductItem"] = @"SearchProductCell";
    self.formTable.frame = CGRectMake(0, NavigationBarH + 42, SCREEN_WIDTH,SCREEN_HEIGHT - NavigationBarH - 42);
    CXSeachView *serchBar = [[CXSeachView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarH)];
    serchBar.searchBtnPress = ^(NSString *keyWords) {
        bself.keyWord = keyWords;
        [bself requestFirstPage];
//        [bself searchKeyWord:keyWords];
    };
    if (!ISEmptyStr(self.keyWord)) {
       serchBar.keyWord = self.keyWord;
    }
    
    serchBar.btnClick = ^(NSInteger tag) {
        if (tag == 100) {
            RootNavPop(YES);
        }
    };
    [self.view addSubview:serchBar];
    
    ConditionSiftBar *siftBar = [[ConditionSiftBar alloc]initWithFrame:CGRectMake(0, NavigationBarH, SCREEN_WIDTH, 42)];
    siftBar.rightBtnClick = ^(NSString *str) {
        sortName = str;
        [bself requestFirstPage];
    };
    [self.view addSubview:siftBar];
    sortName = @"qty";
    [self reloadSection1];
}

-(void)reloadSection1{
    [self.section1 removeAllItems];
    SearchProductItem *item1 = [[SearchProductItem alloc]init];
    item1.eventArr = self.myArr;
    [self.section1 addItem:item1];
    
    [self.section1 reloadSectionWithAnimation:UITableViewRowAnimationNone];
    if (self.myArr.count == 10) {
        self.hasNextPage = 1;
        self.formTable.mj_header.tag = List_DefaultPage_First+1;
        self.formTable.mj_footer.hidden = NO;
    }else{
        self.hasNextPage = -1;
    }
    [self.formTable reloadData];
    
}

- (void)requestFirstPage
{
    [self.section1 removeAllItems];
    [self.section1 reloadSectionWithAnimation:UITableViewRowAnimationNone];
    self.formTable.mj_header.tag = List_DefaultPage_First;//设置tag为0表示第0页开始加载
    [self requestWithPage:(int)self.formTable.mj_header.tag];
}
- (void)requestWithPage:(int)pageIndex {
    WS(bself);
    NSMutableDictionary *dict = [AppUtil getPublicParam];
    [dict setObject:@"10" forKey:@"rp"];
    [dict setObject:[NSNumber numberWithInt:pageIndex] forKey:@"curpage"];
    [dict setObject:self.keyWord forKey:@"name"];
    [dict setObject:@"asc" forKey:@"sortorder"];
    [dict setObject:sortName forKey:@"sortname"];
	if (!ISEmptyStr(self.marketId)) {
		[dict setObject:self.marketId forKey:@"marketId"];
	}
	
    [NSObject postDataWithHost:Server_Host Path:Api_BuyerGoodSearch Param:dict isCache:NO success:^(id json) {
        NSMutableArray *resultArr = [bself getDataArray:json];
        if (resultArr.count == 10) {
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
    
    
    SearchProductItem *item1 = [[SearchProductItem alloc]init];
    item1.eventArr = array;
    [arrayItems addObject:item1];
    
    return arrayItems;
}
@end
