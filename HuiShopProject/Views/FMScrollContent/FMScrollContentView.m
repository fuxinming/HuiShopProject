//
//  WTScrollContentView.m
//  WTLibrary
//
//  Created by jienliang on 14-5-23.
//  Copyright (c) 2014年 @"". All rights reserved.
//

#import "FMScrollContentView.h"

@implementation FMScrollContentView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        mNeedUseDelegate = YES;
        self.scrollEnable = YES;
        [self commInit];
    }
    return self;
}

-(void)commInit{
    if (_contentItems == nil) {
        _contentItems = [[NSMutableArray alloc] init];
    }
    if (_scrollView == nil) {
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
        _scrollView.delegate = self;
        [_scrollView setDirectionalLockEnabled:YES];
        [_scrollView setAlwaysBounceHorizontal:YES];
        [_scrollView setAlwaysBounceVertical:NO];
        [_scrollView setPagingEnabled:YES];
        _scrollView.bounces = NO;
        [_scrollView setShowsHorizontalScrollIndicator:NO];
        [_scrollView setShowsVerticalScrollIndicator:NO];
    }
    [self addSubview:_scrollView];
}


-(void)layoutSubviews{
    [super layoutSubviews];
    _scrollView.scrollEnabled = self.scrollEnable;
    _scrollView.height = self.height;
}
-(void)dealloc{
    [_contentItems removeAllObjects];
    _contentItems= nil;
}

#pragma mark - 其他辅助功能
#pragma mark 添加ScrollowViewd的ContentView
-(void)setContentOfTables:(NSInteger)aNumerOfTables{
    for (int i = 0; i < aNumerOfTables; i++) {
        UIView *v = self.createViewAtIndex(i);
        [_scrollView addSubview:v];
        [_contentItems addObject:v];
    }
    [_scrollView setContentSize:CGSizeMake(self.frame.size.width * aNumerOfTables, self.frame.size.height)];
}

#pragma mark 移动ScrollView到某个页面
-(void)moveScrollowViewAthIndex:(NSInteger)aIndex{
    mNeedUseDelegate = NO;
    CGRect vMoveRect = CGRectMake(self.frame.size.width * aIndex, 0, self.frame.size.width, self.frame.size.width);
    [_scrollView scrollRectToVisible:vMoveRect animated:YES];
    mCurrentPage= aIndex;
    [self scrollToPage:(int)aIndex];
}

-(void)setScrollowViewAthIndex:(NSInteger)aIndex{
    mNeedUseDelegate = NO;
    CGRect vMoveRect = CGRectMake(self.frame.size.width * aIndex, 0, self.frame.size.width, self.frame.size.width);
    [_scrollView scrollRectToVisible:vMoveRect animated:NO];
    mCurrentPage= aIndex;
    [self scrollToPage:(int)aIndex];
}

#pragma mark 刷新某个页面
-(void)freshContentTableAtIndex:(NSInteger)aIndex{
    if (_contentItems.count < aIndex) {
        return;
    }
    ///UIView *v =(UIView *)[_contentItems objectAtIndex:aIndex];
//    if([v respondsToSelector:@selector(forceToFreshData)]){
//        [v forceToFreshData];
//    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    mNeedUseDelegate = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (_scrollView.contentOffset.x+self.frame.size.width/2.0) / self.frame.size.width;
    if (mCurrentPage == page) {
        return;
    }
    mCurrentPage = page;
    [self scrollToPage:page];
}

- (void)scrollToPage:(int)page{
    self.scrollPageView(page);
}
@end
