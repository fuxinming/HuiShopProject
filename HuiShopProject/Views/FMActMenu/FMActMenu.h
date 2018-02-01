//
//  FMActMenu.h
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/7.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TITLEKEY   @"titleKey"
#define TITLEWIDTH @"titleWidth"
#define TOTALWIDTH @"totalWidth"
@interface FMActMenu : UIView{
    NSMutableArray        *mButtonArray;
    NSMutableArray        *mItemInfoArray;
    UIScrollView          *mScrollView;
    float                 mTotalWidth;
    UIImageView                *lineView;
}
@property (copy, readwrite, nonatomic) void (^onClick)(id item,int index);
@property (nonatomic,copy) UIColor *titleColor;
@property (nonatomic,assign) int defaultIndex;
#pragma mark 初始化菜单
- (id)initWithFrame:(CGRect)frame ButtonItems:(NSArray *)aItemsArray titleColor:(UIColor *)tColor defaultIndex:(int)dIndex;

#pragma mark 选中某个button
-(void)clickButtonAtIndex:(NSInteger)aIndex;

#pragma mark 改变第几个button为选中状态，不发送delegate
-(void)changeButtonStateAtIndex:(NSInteger)aIndex;

@end
