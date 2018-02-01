//
//  FMListViewController.m
//  ShuiDongGou
//
//  Created by q on 2017/10/20.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "FMListViewController.h"

@interface FMListViewController (){
}
@property (nonatomic,strong) RETableViewSection *section;
@end

@implementation FMListViewController

- (id)init {
    self = [super init];
    if (self) {
        self.hasNextPage = -1;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _dataArray = [[NSMutableArray alloc] init];
    _section = [RETableViewSection sectionWithHeaderTitle:@""];
    [self.formManager addSection:_section];
    [self addHeader];
    [self addFooter];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.formTable setEditing:NO];
}

- (void)addHeader
{
    WS(bself);
    self.formTable.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [bself performSelector:@selector(requestFirstPage) withObject:nil afterDelay:0.001];
    }];
    self.formTable.mj_header.tag = List_DefaultPage_First;//设置tag为1表示第1页开始加载
}

- (void)addFooter
{
    WS(bself);
    // 添加传统的上拉刷新
    self.formTable.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        [bself performSelector:@selector(requestNextPage) withObject:nil afterDelay:0.001];
    }];
    self.formTable.mj_footer.hidden = YES;
}

- (void)requestFirstPage
{
    self.formTable.mj_header.tag = List_DefaultPage_First;//设置tag为0表示第0页开始加载
    [self requestWithPage:(int)self.formTable.mj_header.tag];
}

- (void)requestNextPage
{
    int curPage = (int)self.formTable.mj_header.tag;
    [self requestWithPage:curPage];
}

- (void)requestComplete {
    // 拿到当前的下拉刷新控件，结束刷新状态
    if (self.formTable.mj_header) {
        [self.formTable.mj_header endRefreshing];
    }
    if (self.formTable.mj_footer) {
        [self.formTable.mj_footer endRefreshing];
    }
}

#pragma mark - RETableViewManagerDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    return 0;
}

//必须重载的方法，根据页码加载指定页
- (void)requestWithPage:(int)pageIndex{}

- (void)requestFinish:(NSMutableArray *)dataArray
{
    int curPage = (int)self.formTable.mj_header.tag;
    if (curPage==List_DefaultPage_First) {
        [self.dataArray removeAllObjects];
    }
    if (dataArray) {
        [self.dataArray addObjectsFromArray:dataArray];
    }
    self.formTable.mj_header.tag = curPage+1;
    //创建并加载所有item项
    NSMutableArray *itemsArray = [self createItems:self.dataArray];
    [self.section replaceItemsWithItemsFromArray:itemsArray];
    //刷新列表
    [self requestComplete];
    [self.formTable reloadData];
    if (dataArray.count>0 && self.hasNextPage==1) {
        self.formTable.mj_footer.hidden = NO;
    }
    else{//去除下拉加载更多
        self.formTable.mj_footer.hidden = YES;
    }
//    [self.formTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.section.items.count- 1 inSection:0] atScrollPosition:UITableViewScrollPositionBottom animated:YES];

}

- (NSMutableArray *)createItems:(NSMutableArray *)dataArray
{
    NSLog(@"%s need override",__func__);
    return nil;
}

- (NSMutableArray *)getDataArray:(id)json
{
    NSLog(@"%s need override",__func__);
    return nil;
}

@end
