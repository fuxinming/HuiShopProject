//
//  RestoreMenuView.h
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/9.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "FMFormView.h"

@interface RestoreMenuView : FMFormView
- (id)initWithFrame:(CGRect)frame withArr:(NSArray *)arr1;
@property (nonatomic,copy)NSArray *arr1;
@property (nonatomic,copy)NSArray *arr2;
@property (nonatomic,copy)void (^selectItem)(int type,int index,NSString *t);
@end
