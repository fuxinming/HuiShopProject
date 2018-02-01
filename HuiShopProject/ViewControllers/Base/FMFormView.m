//
//  FMFormView.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/7.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "FMFormView.h"
#import "FMEmptyCell.h"
#import "EmptyDataCell.h"
@implementation FMFormView
@synthesize formTable,formManager;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        [self initTableView];
    }
    return self;
}



- (void)initTableView
{
    formTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.width, self.height) style:UITableViewStylePlain];
    formTable.showsVerticalScrollIndicator = NO;
    formTable.estimatedRowHeight = 0;
    formTable.estimatedSectionHeaderHeight = 0;
    formTable.estimatedSectionFooterHeight = 0;
    formTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    formTable.backgroundColor = [UIColor clearColor];
    [self addSubview:formTable];
#ifdef __IPHONE_11_0
    if ([formTable respondsToSelector:@selector(setContentInsetAdjustmentBehavior:)]) {
        formTable.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
#endif
    
    formManager = [[RETableViewManager alloc] initWithTableView:formTable];
    formManager.delegate = self;
    formManager[@"FMEmptyItem"] = @"FMEmptyCell";
  	formManager[@"EmptyDataItem"] = @"EmptyDataCell";
}

- (void)addHeader {
    WS(bself);
    self.formTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [bself performSelector:@selector(getData) withObject:nil afterDelay:0.001];
    }];
}

-(void)getData{}
#pragma mark - RETableViewManagerDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    return 0;
}



#pragma mark - Private
- (void)hiddenLoading {
    [MBProgressHUD hideHUDForView:Window animated:YES];
}

- (void)showLoading {
    [MBProgressHUD showHUDAddedTo:Window animated:YES];
}

- (void)beginRefrash {
    [self.formTable.mj_header beginRefreshing];
}

- (void)endRefrash {
    [self.formTable.mj_header endRefreshing];
}

-(void)initEmptyForm:(float)height andType:(int)type;{
	RETableViewSection *section0 = [RETableViewSection section];
	
	EmptyDataItem *emptyItem = [[EmptyDataItem alloc]initWithHeight:height andType:type];
	[section0 addItem:emptyItem];
	
	[self.formManager replaceSectionsWithSectionsFromArray:@[section0]];
	[self.formTable reloadData];
}
@end
