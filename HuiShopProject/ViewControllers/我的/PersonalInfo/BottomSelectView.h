//
//  BottomSelectView.h
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/16.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BottomSelectView : UIView<UIPickerViewDelegate,UIPickerViewDataSource>
-(id)initWithArr:(NSArray *)arr;
@property (nonatomic, copy) void (^rebackBlock) (NSString *str1,int index);
@end
