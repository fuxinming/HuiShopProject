//
//  AppDelegate.h
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/2.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMTabBar.h"
#import "WXApi.h"
#import "LoginInfo.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) FMTabBar *tab;
@property (strong, nonatomic) UIWindow *window;
@property (copy, nonatomic) NSString *clientId;
@property (assign, nonatomic) BOOL isInBackGround;//app是否在后台
-(void)bindClientId;
- (void)goToRoot:(int)index;
-(void)getUserInfo;

@property (strong, nonatomic) LoginInfo *loginInfo;
@end

