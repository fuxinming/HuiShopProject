//
//  BaseViewController.h
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/2.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMNavBar.h"
@interface BaseViewController : UIViewController<UINavigationControllerDelegate>
@property (nonatomic,copy) NSString *myTitle;
/**
 *    @brief    导航栏是否隐藏, 默认NO.
 */
@property (nonatomic, assign) BOOL navHidden;
/**
 *    @brief    返回是否隐藏, 默认NO.
 */
@property (nonatomic, assign) BOOL hiddenBack;
/**
 *    @brief    导航栏视图.
 */
@property (nonatomic, strong) FMNavBar *navBar;
@property (nonatomic,copy) dispatch_block_t saveSuccess;
- (void)showLoading;
- (void)hiddenLoading;

- (void)popToViewController:(NSString *)cls;
@end
