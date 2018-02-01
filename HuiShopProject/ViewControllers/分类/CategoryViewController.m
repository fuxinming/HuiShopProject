//
//  CategoryViewController.m
//  HuiShopProject
//
//  Created by 付新明 on 2017/11/2.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "CategoryViewController.h"
#import "LeftCatagoryTitleCell.h"
#import "RightCatagoryCell.h"
#import "ProductSearchViewController.h"
#import "CatListViewController.h"
@interface CategoryViewController (){
    UIView *navBarView;
}
@property (nonatomic,strong)NSMutableArray *catogryArr;
@end

@implementation CategoryViewController

- (void)viewDidLoad {
    self.navHidden = YES;
    [super viewDidLoad];
    self.formTable.frame = CGRectMake(0, NavigationBarH,  SCREEN_WIDTH/4, SCREEN_HEIGHT - NavigationBarH);
    self.formTable.backgroundColor = [UIColor whiteColor];
    _formTable1 = [[UITableView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/4, NavigationBarH, SCREEN_WIDTH - SCREEN_WIDTH/4, SCREEN_HEIGHT - NavigationBarH) style:UITableViewStylePlain];
    _formTable1.showsVerticalScrollIndicator = NO;
    _formTable1.separatorStyle = UITableViewCellSeparatorStyleNone;
    _formTable1.backgroundColor = [UIColor clearColor];
    _formTable1.estimatedRowHeight = 0;
    _formTable1.estimatedSectionHeaderHeight = 0;
    _formTable1.estimatedSectionFooterHeight = 0;
#ifdef __IPHONE_11_0
    if ([_formTable1 respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        _formTable1.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    [self.view addSubview:_formTable1];
    
    _formManager1 = [[RETableViewManager alloc] initWithTableView:_formTable1];
    _formManager1.delegate = self;
    _formManager1[@"FMEmptyItem"] = @"FMEmptyCell";
    _formManager1[@"RightCatagoryItem"] = @"RightCatagoryCell";
    self.formManager[@"LeftCatagoryTitleItem"] = @"LeftCatagoryTitleCell";
    [self initNavBarView];
    
    [self getData];
}

-(void)initNavBarView{
    navBarView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, NavigationBarH)];
    navBarView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:navBarView];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"搜索" forState:UIControlStateNormal];
    [btn setTitleColor:COLOR_999 forState:UIControlStateNormal];
    [btn.titleLabel setFont:Font_Size_14];
    [btn addTarget:self action:@selector(sbtnClick) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(18, navBarView.height - 40, SCREEN_WIDTH - 36, 30);
    btn.backgroundColor = COLOR_ddd;
    View_Border_Radius(btn, 3, 0, Color_Clear);
    [navBarView addSubview:btn];
    
    
    UIImageView *serchImg = [[UIImageView alloc]initWithFrame:CGRectMake(10, 6, 18, 18)];
    serchImg.image = [UIImage imageNamed:@"search"];
    [btn addSubview:serchImg];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, navBarView.height - 0.5, SCREEN_WIDTH, 0.5)];
    line.backgroundColor = COLOR_ddd;
    [navBarView addSubview:line];

}

-(void)getData{
    WS(bself);

    [self showLoading];
    [NSObject postDataWithHost:Server_Host Path:Api_CategoryList Param:nil isCache:NO success:^(id json) {
        if(IntRelay(json[@"state"]) == 1) {
            if (!ISNULL(json[@"obj"]) && [json[@"obj"] isKindOfClass:[NSArray class]]) {
                bself.catogryArr = [NSMutableArray arrayWithArray:json[@"obj"]];
                [bself initForm];
                if (bself.catogryArr.count > 0) {
                    NSDictionary *dict = bself.catogryArr[0];
                    [bself initForm1:dict];
                }
                
            }
        }
        
        [bself hiddenLoading];
    } fail:^(id json) {
        [bself hiddenLoading];
    }];
}

-(void)initForm{
    WS(bself);
    RETableViewSection *section0 = [RETableViewSection section];
    
    for (int i = 0; i < self.catogryArr.count; i++) {
        NSDictionary *dict1 = self.catogryArr[i];
        LeftCatagoryTitleItem *it = [[LeftCatagoryTitleItem alloc]init];
        it.userinfo = dict1;
        it.selectionHandler = ^(LeftCatagoryTitleItem * item) {
            [bself initForm1:item.userinfo];
        };
        it.titleText = dict1[@"name"];
        [section0 addItem:it];
    }
    
    [self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
    [self.formTable reloadData];
    LeftCatagoryTitleItem *it = section0.items[0];
    [it selectRowAnimated:YES];
}

-(void)initForm1:(NSDictionary *)childDict{
    RETableViewSection *section0 = [RETableViewSection section];
    
    RightCatagoryItem *item1 = [[RightCatagoryItem alloc]init];
    item1.eventArr = childDict[@"childs"];
    item1.typeName = childDict[@"name"];
    [section0 addItem:item1];
    
    [self.formManager1 replaceSectionsWithSectionsFromArray:@[section0]];
    [self.formTable1 reloadData];
}


-(void)sbtnClick{
    ProductSearchViewController *vc = [[ProductSearchViewController alloc]init];
    RootNavPush(vc);
}
@end
