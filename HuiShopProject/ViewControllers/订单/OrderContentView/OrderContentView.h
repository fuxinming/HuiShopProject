//
//  CXMatchContentView.h
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/7.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "FMListView.h"

@interface OrderContentView : FMListView
- (id)initWithFrame:(CGRect)frame withType:(int)type;
@property (nonatomic,assign) int type;//(全部-0,待付款-1,待发货-3,待收货-4,待评价-5)
@property (nonatomic,copy) void(^payOk)(id);
@end
