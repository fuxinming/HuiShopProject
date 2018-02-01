//
//  WSServiceSeachView.h
//  OMengMerchant
//
//  Created by ZhangQun on 2017/5/3.
//  Copyright © 2017年 shanjin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CXSeachView : UIView<UITextFieldDelegate>
@property (nonatomic,copy)void (^btnClick)(NSInteger tag);
@property (copy, readwrite, nonatomic) void (^searchBtnPress)(NSString *keyWords);
@property (copy, readwrite, nonatomic) void (^shouldEditPress)(void);
@property (nonatomic,strong) UITextField *seachTF;
@property (nonatomic, copy) NSString *keyWord;
@property (nonatomic,strong)UIView *actionBar;
@end
