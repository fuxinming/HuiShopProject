//
//  FMFormViewController.m
//  FMBaseProject
//
//  Created by shanjin on 2016/10/25.
//  Copyright © 2016年 付新明. All rights reserved.
//

#import "FMFormViewController.h"
#import "EmptyDataCell.h"
@interface FMFormViewController ()

@end

@implementation FMFormViewController
@synthesize sectionArray;
@synthesize section0;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
	self.automaticallyAdjustsScrollViewInsets = NO;
}
- (void)initView
{
    _formTable = [[UITableView alloc] initWithFrame:CGRectMake(0, NavigationBarH, SCREEN_WIDTH, SCREEN_HEIGHT - NavigationBarH) style:UITableViewStylePlain];
    _formTable.showsVerticalScrollIndicator = NO;
    _formTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    _formTable.backgroundColor = [UIColor clearColor];
    _formTable.estimatedRowHeight = 0;
    _formTable.estimatedSectionHeaderHeight = 0;
    _formTable.estimatedSectionFooterHeight = 0;
#ifdef __IPHONE_11_0
    if ([_formTable respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        _formTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    [self.view addSubview:_formTable];
    
    _formManager = [[RETableViewManager alloc] initWithTableView:_formTable];
    _formManager.delegate = self;
    _formManager[@"FMEmptyItem"] = @"FMEmptyCell";
    _formManager[@"EmptyDataItem"] = @"EmptyDataCell";
	self.formManager[@"FreeViewItem"] = @"FreeViewCell";
}
#pragma mark - RETableViewManagerDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
	return 0.001f;
}
- (void)addHeader {
    WS(bself);
    self.formTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [bself performSelector:@selector(getData) withObject:nil afterDelay:0.001];
    }];
}

- (void)beginRefrash {
    [self.formTable.mj_header beginRefreshing];
}

- (void)endRefrash {
    [self.formTable.mj_header endRefreshing];
}

-(void)getData{}

-(void)initEmptyForm:(float)height andType:(int)type{
	RETableViewSection *section0 = [RETableViewSection section];
	
	EmptyDataItem *emptyItem = [[EmptyDataItem alloc]initWithHeight:height andType:type];
	[section0 addItem:emptyItem];
	
	[self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
	[self.formTable reloadData];
}
@end
