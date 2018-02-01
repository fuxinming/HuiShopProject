//
//  ProductSearchViewController.m
//  HuiShopProject
//
//  Created by cx-fu on 2017/11/18.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "ProductSearchViewController.h"
#import "CXSeachView.h"
#import "RecentSearchCell.h"
#import "SearchTagListCell.h"
#import "ProductSearchListViewController.h"
@interface ProductSearchViewController (){
    
}
@property (nonatomic, strong) NSMutableArray *myArr;
@end

@implementation ProductSearchViewController

- (void)viewDidLoad {
    self.navHidden = YES;
    [super viewDidLoad];
    WS(bself);
    self.view.backgroundColor = [UIColor whiteColor];
    self.formManager[@"RecentSearchItem"] = @"RecentSearchCell";
    self.formManager[@"SearchTagListItem"] = @"SearchTagListCell";
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
    
    [self initForm];
    
}

-(void)initForm{
    WS(bself);
    NSArray *hisArr = UserDefaultObjectForKey(HitorySearch);
    RETableViewSection *section0 = [RETableViewSection section];
    if (hisArr.count > 0) {
        RecentSearchItem *item1 = [[RecentSearchItem alloc]init];
        item1.btnPress = ^{
            [AppUtil showAlert:@"提示" msg:@"确定清除搜索记录吗？" handle:^(BOOL cancelled, NSInteger buttonIndex) {
                if(buttonIndex == 1){
                    UserDefaultRemoveObjectForKey(HitorySearch);
                    [bself initForm];
                    
                }
            }];
        };
        [section0 addItem:item1];
        
        SearchTagListItem *item2 = [[SearchTagListItem alloc]init];
        item2.tagListArray = hisArr;
        item2.tagBtnClick = ^(NSString *str) {
            [bself searchKeyWord:str];
        };
        [section0 addItem:item2];
    }
    [self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
    [self.formTable reloadData];
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
    [self showLoading];
    [NSObject postDataWithHost:Server_Host Path:Api_BuyerGoodSearch Param:dict isCache:NO success:^(id json) {
        if(IntRelay(json[@"state"]) == 1) {
            if (!ISNULL(json[@"obj"]) && [json[@"obj"] isKindOfClass:[NSArray class]]) {
                NSArray *hisArr = UserDefaultObjectForKey(HitorySearch);
                if (![CommonUtil isContainStr:keyStr inArr:hisArr]) {
                    NSMutableArray *tempArr = [NSMutableArray arrayWithArray:hisArr];
                    [tempArr addObject:keyStr];
                    UserDefaultSetObjectForKey(tempArr, HitorySearch);
                    [bself initForm];
                }
                
                bself.myArr = [NSMutableArray arrayWithArray:json[@"obj"]];
                if (bself.myArr.count > 0) {
                    ProductSearchListViewController *vc = [[ProductSearchListViewController alloc]init];
                    vc.keyWord = keyStr;
                    vc.myArr = bself.myArr;
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
