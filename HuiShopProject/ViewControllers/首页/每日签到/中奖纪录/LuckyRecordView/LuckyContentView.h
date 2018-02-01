//
//  CXMatchContentView.h
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/7.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "FMListView.h"

@interface LuckyContentView : FMListView
@property(nonatomic,assign)int type;
- (id)initWithFrame:(CGRect)frame andType:(int)type;
@end
