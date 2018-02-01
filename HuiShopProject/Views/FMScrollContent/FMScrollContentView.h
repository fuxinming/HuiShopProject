//
//  WTScrollContentView.h
//  WTLibrary
//
//  Created by jienliang on 14-5-23.
//  Copyright (c) 2014年 @"". All rights reserved.
//

#import <UIKit/UIKit.h>
@interface FMScrollContentView : UIView<UIScrollViewDelegate>
{
    NSInteger mCurrentPage;
    BOOL mNeedUseDelegate;
}
@property (nonatomic,retain) UIScrollView *scrollView;

@property (nonatomic,retain) NSMutableArray *contentItems;
//创建每个contentview的内容视图
@property (copy,nonatomic) UIView * (^createViewAtIndex)(int index);
//滚动到指定页面视图
@property (copy,nonatomic) void (^scrollPageView)(int page);
@property (assign,nonatomic) BOOL scrollEnable;
#pragma mark 添加ScrollowViewd的ContentView
-(void)setContentOfTables:(NSInteger)aNumerOfTables;

-(void)moveScrollowViewAthIndex:(NSInteger)aIndex;
-(void)setScrollowViewAthIndex:(NSInteger)aIndex;
@end
