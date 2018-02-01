//
//  FMActMenu.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/7.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "FMActMenu.h"
#import "FMButton.h"
@implementation FMActMenu

- (id)initWithFrame:(CGRect)frame ButtonItems:(NSArray *)aItemsArray titleColor:(UIColor *)tColor defaultIndex:(int)dIndex
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleColor = tColor;
        self.defaultIndex = dIndex;
        
        if (mButtonArray == nil) {
            mButtonArray = [[NSMutableArray alloc] init];
        }
        if (mScrollView == nil) {
            mScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
            mScrollView.showsHorizontalScrollIndicator = NO;
            mScrollView.bounces = NO;
        }
        if (mItemInfoArray == nil) {
            mItemInfoArray = [[NSMutableArray alloc]init];
        }
        [mItemInfoArray removeAllObjects];
        [self createMenuItems:aItemsArray];
    }
    return self;
}

-(void)createMenuItems:(NSArray *)aItemsArray{
    float menuWidth = 0.0;
    for (int i = 0; i < [aItemsArray count]; i++) {
        NSDictionary *lDic = [aItemsArray objectAtIndex:i];
        NSString *vTitleStr = [lDic objectForKey:TITLEKEY];
        float vButtonWidth = [[lDic objectForKey:TITLEWIDTH] floatValue];
        
        FMButton*vButton = [FMButton buttonWithType:UIButtonTypeCustom];
        [vButton setTitle:vTitleStr forState:UIControlStateNormal];
        vButton.titleLabel.font = Font_Size_14;
        [vButton setTitleColor:COLOR_333 forState:UIControlStateNormal];
        [vButton setTitleColor:self.titleColor forState:UIControlStateHighlighted];
        [vButton setTitleColor:self.titleColor forState:UIControlStateSelected];
        [vButton setTag:i];
        vButton.userInfo = lDic;
        [vButton addTarget:self action:@selector(menuButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [vButton setFrame:CGRectMake(menuWidth, 0, vButtonWidth, self.frame.size.height)];
//        if(i == 0){
//            vButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
//            vButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 10);
//        }
//        if(i == [aItemsArray count] - 1){
//            vButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
//            vButton.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
//        }
        
        [mScrollView addSubview:vButton];
        [mButtonArray addObject:vButton];
        [self performSelector:@selector(addRedLine:) withObject:vButton afterDelay:0.1];
        menuWidth += vButtonWidth;
        
        //保存button资源信息，同时增加button.oringin.x的位置，方便点击button时，移动位置。
        NSMutableDictionary *vNewDic = [lDic mutableCopy];
        [vNewDic setObject:[NSNumber numberWithFloat:menuWidth] forKey:TOTALWIDTH];
        [mItemInfoArray addObject:vNewDic];
    }
    
    [mScrollView setContentSize:CGSizeMake(menuWidth, self.frame.size.height)];
    [self addSubview:mScrollView];
    
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, mScrollView.bottom, mScrollView.width, 1)];
    line.backgroundColor = UIColorFromRGB(0xf2f0f0);
    [self addSubview:line];
    
    // 保存menu总长度，如果小于320则不需要移动，方便点击button时移动位置的判断
    mTotalWidth = menuWidth;
}


-(void)addRedLine:(FMButton *)vButton{
    if (vButton.tag ==self.defaultIndex) {
        vButton.selected = YES;
        
        
        lineView = [[UIImageView alloc] initWithFrame:CGRectMake(vButton.left, mScrollView.bottom - 2.5, vButton.width, 2.5)];
        lineView.image = [UIImage imageNamed:@"naviSliderBar"];
        lineView.backgroundColor = COLOR_RED_;
        [mScrollView addSubview:lineView];
    }
}
#pragma mark - 其他辅助功能
#pragma mark 取消所有button点击状态
-(void)changeButtonsToNormalState{
    for (UIButton *vButton in mButtonArray) {
        vButton.selected = NO;
    }
}

#pragma mark 模拟选中第几个button
-(void)clickButtonAtIndex:(NSInteger)aIndex{
    FMButton *vButton = [mButtonArray objectAtIndex:aIndex];
    [self menuButtonClicked:vButton];
}

#pragma mark 改变第几个button为选中状态，不发送delegate
-(void)changeButtonStateAtIndex:(NSInteger)aIndex{
    FMButton *vButton = [mButtonArray objectAtIndex:aIndex];
    [self changeButtonsToNormalState];
    vButton.selected = YES;
   
    [UIView animateWithDuration:0.3 animations:^{
        //CGFloat x = vButton.left + (vButton.width - 20)/2;
        lineView.frame = CGRectMake(vButton.left, lineView.top, vButton.width, lineView.height);
    }];
    [self moveScrolViewWithIndex:aIndex];
}

#pragma mark 移动button到可视的区域
-(void)moveScrolViewWithIndex:(NSInteger)aIndex{
    if (mItemInfoArray.count < aIndex) {
        return;
    }
    //宽度小于320肯定不需要移动
    if (mTotalWidth <= SCREEN_WIDTH) {
        return;
    }
    NSDictionary *vDic = [mItemInfoArray objectAtIndex:aIndex];
    float vButtonOrigin = [[vDic objectForKey:TOTALWIDTH] floatValue];
    if (vButtonOrigin >= 300) {
        if ((vButtonOrigin + 180) >= mScrollView.contentSize.width) {
            [mScrollView setContentOffset:CGPointMake(mScrollView.contentSize.width - SCREEN_WIDTH, mScrollView.contentOffset.y) animated:YES];
            return;
        }
        
        float vMoveToContentOffset = vButtonOrigin - 180;
        if (vMoveToContentOffset > 0) {
            [mScrollView setContentOffset:CGPointMake(vMoveToContentOffset, mScrollView.contentOffset.y) animated:YES];
        }
    }else{
        [mScrollView setContentOffset:CGPointMake(0, mScrollView.contentOffset.y) animated:YES];
        return;
    }
}

#pragma mark - 点击事件
-(void)menuButtonClicked:(FMButton *)aButton{
    [self changeButtonStateAtIndex:aButton.tag];
    if (self.onClick) {
        self.onClick(aButton.userInfo,(int)aButton.tag);
    }
}


#pragma mark 内存相关
-(void)dealloc{
    [mButtonArray removeAllObjects];
    mButtonArray = nil;
}
@end
