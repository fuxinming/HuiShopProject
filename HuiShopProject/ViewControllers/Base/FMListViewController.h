//
//  FMListViewController.h
//  ShuiDongGou
//
//  Created by q on 2017/10/20.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "FMFormViewController.h"

@interface FMListViewController : FMFormViewController
@property (nonatomic,strong) NSMutableArray *dataArray;///< 列表数据数组
@property (nonatomic,assign) int hasNextPage;//默认-1，如果为1，用nextPage分页

/**
 *    @brief    请求数据成功后加载列表数据
 *
 *    @param     dataArray     列表数据
 *    @return     列表Item数据
 */
- (void)requestFinish:(NSMutableArray *)dataArray;
/**
 *    @brief 必须重载的方法，根据data创建items
 *
 *    @param     dataArray     数据
 *
 *    @return    items数组
 */
- (NSMutableArray *)createItems:(NSMutableArray *)dataArray;
/**
 *    @brief 必须重载的方法，根据json获取data数组以便createItems使用
 *
 *    @param     dataArray     数据
 *
 *    @return    items数组
 */
- (NSMutableArray *)getDataArray:(id)json;

- (void)requestWithPage:(int)pageIndex;

- (void)requestFirstPage;
- (void)requestComplete;

@end
