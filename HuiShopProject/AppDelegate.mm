//
//  AppDelegate.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/2.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "AppDelegate.h"
#import "CXOpenIndexViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import "WXApi.h"
#import "WXApi+XWAdd.h"
#import "AlipaySDK+XWAdd.h"
#import <GTSDK/GeTuiSdk.h>     // GetuiSdk头文件应用
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
#import <UserNotifications/UserNotifications.h>
#endif
@interface AppDelegate ()<BMKGeneralDelegate, GeTuiSdkDelegate, UNUserNotificationCenterDelegate>

@end
BMKMapManager* _mapManager;
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [GeTuiSdk startSdkWithAppId:GTAppID appKey:GTAppKey appSecret:GTAppSecret delegate:self];
    // 注册 APNs
    [self registerRemoteNotification];
    [self goToRoot:0];
    [self setBaiduMap];
	[WXApi registerApp:APP_ID];
    [self doLogin];
    [[UIApplication sharedApplication] setApplicationIconBadgeNumber:0];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

/** 远程通知注册成功委托 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSLog(@"\n>>>[DeviceToken Success]:%@\n\n", token);
    // 向个推服务器注册deviceToken
    [GeTuiSdk registerDeviceToken:token];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0

//  iOS 10: App在前台获取到通知
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler {
    
    NSLog(@"willPresentNotification：%@", notification.request.content.userInfo);
    
    // 根据APP需要，判断是否要提示用户Badge、Sound、Alert
    if (@available(iOS 10.0, *)) {
        completionHandler(UNNotificationPresentationOptionBadge | UNNotificationPresentationOptionSound | UNNotificationPresentationOptionAlert);
    } else {
        // Fallback on earlier versions
    }
}

//  iOS 10: 点击通知进入App时触发，在该方法内统计有效用户点击数
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler {
    
    NSLog(@"didReceiveNotification：%@", response.notification.request.content.userInfo);
    
    // [ GTSdk ]：将收到的APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:response.notification.request.content.userInfo];
    
    completionHandler();
}

/** APP已经接收到“远程”通知(推送) - 透传推送消息  */
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult result))completionHandler {
    // 处理APNs代码，通过userInfo可以取到推送的信息（包括内容，角标，自定义参数等）。如果需要弹窗等其他操作，则需要自行编码。
    NSLog(@"\n>>>[Receive RemoteNotification - Background Fetch]:%@\n\n",userInfo);
    
    //静默推送收到消息后也需要将APNs信息传给个推统计
    [GeTuiSdk handleRemoteNotification:userInfo];
    
    completionHandler(UIBackgroundFetchResultNewData);
}

#endif


- (void)goToRoot:(int)index {
    if([CommonUtil strNilOrEmpty:[[NSUserDefaults standardUserDefaults] objectForKey:@"GoToClient"]]){
        CXOpenIndexViewController *index = [[CXOpenIndexViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:index];
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = [UIColor whiteColor];
        self.window.rootViewController =nav;
        nav.navigationBarHidden = YES;
        [self.window makeKeyAndVisible];
    }
    else {
        _tab = [[FMTabBar alloc] init];
        _tab.navigationController.navigationBarHidden = YES;
        _tab.cIndex = index;
        
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:_tab];
        nav.navigationBarHidden = YES;
        self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
        self.window.backgroundColor = [UIColor whiteColor];
        self.window.rootViewController = nav;
        [self.window makeKeyAndVisible];
    }
}

-(void)setBaiduMap{
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:BaiduMapKey generalDelegate:self];
    if (!ret) {
        NSLog(@"Baidu manager start failed!");
    }
}

-(void)doLogin{
    WS(bself);
    NSString *phone = UserDefaultObjectForKey(LoginPhone);
    NSString *pwd = UserDefaultObjectForKey(LoginPwd);
    
    if (ISEmptyStr(phone) || ISEmptyStr(pwd)) {
        return;
    }else{
        [AppUtil loginWith:phone andPass:pwd complete:^{
            LLog(@"appdelegate 登录成功——————————");
            [bself bindClientId];
        } andFail:^(id josn) {
            UserDefaultRemoveObjectForKey(LoginPhone);
            UserDefaultRemoveObjectForKey(LoginPwd);
        }];
    }
}
-(void)getUserInfo{
	WS(bself);
	[NSObject getDataWithHost:Server_Host Path:Api_Buyer_getuser Param:nil isCache:NO success:^(id json) {
		bself.loginInfo = [LoginInfo loginInfoWithDict:json[@"obj"]];
		[LoginInfo writeUserInfo:json[@"obj"]];
		[[NSNotificationCenter defaultCenter] postNotificationName:RefreshTable object:nil];
	} fail:^(id json) {
		
	}];
}
-(void)bindClientId{
    if (ISEmptyStr(self.clientId)) {
        return;
    }
    NSMutableDictionary *param = [AppUtil getPublicParam];
    [param setObject:self.clientId forKey:@"CID"];
    [NSObject getDataWithHost:Server_Host Path:Api_cid_bind Param:param isCache:NO success:^(id json) {
		
    } fail:^(id json) {
        
    }];
}
- (void)handUrl:(NSURL *)url {
	//处理微信回调信息
	[WXApi xwAdd_handleOpenURL:url];
	//处理支付宝回调信息
	[AlipaySDK xwAdd_handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
	[self handUrl:url];
	return YES;
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
	[self handUrl:url];
	return  YES;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
	[self handUrl:url];
	return YES;
}

/** 注册 APNs */
- (void)registerRemoteNotification {
    /*
     警告：Xcode8 需要手动开启"TARGETS -> Capabilities -> Push Notifications"
     */
    
    /*
     警告：该方法需要开发者自定义，以下代码根据 APP 支持的 iOS 系统不同，代码可以对应修改。
     以下为演示代码，注意根据实际需要修改，注意测试支持的 iOS 系统都能获取到 DeviceToken
     */
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 10.0) {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0 // Xcode 8编译会调用
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        if (@available(iOS 10.0, *)) {
            [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionCarPlay) completionHandler:^(BOOL granted, NSError *_Nullable error) {
                if (!error) {
                    NSLog(@"request authorization succeeded!");
                }
            }];
        } else {
            // Fallback on earlier versions
        }
        
        [[UIApplication sharedApplication] registerForRemoteNotifications];
#else // Xcode 7编译会调用
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#endif
    } else if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        UIUserNotificationType types = (UIUserNotificationTypeAlert | UIUserNotificationTypeSound | UIUserNotificationTypeBadge);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:types categories:nil];
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    } else {
        UIRemoteNotificationType apn_type = (UIRemoteNotificationType)(UIRemoteNotificationTypeAlert |UIRemoteNotificationTypeSound |
UIRemoteNotificationTypeBadge);
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:apn_type];
    }
}

/** SDK启动成功返回cid */
- (void)GeTuiSdkDidRegisterClient:(NSString *)clientId {
    //个推SDK已注册，返回clientId
    NSLog(@"\n>>>[GeTuiSdk RegisterClient]:%@\n\n", clientId);
    self.clientId = clientId;
	if(IsLogin){
		[self bindClientId];
	}
}



/** SDK收到透传消息回调 */
- (void)GeTuiSdkDidReceivePayloadData:(NSData *)payloadData andTaskId:(NSString *)taskId andMsgId:(NSString *)msgId andOffLine:(BOOL)offLine fromGtAppId:(NSString *)appId {
    //收到个推消息
    NSString *payloadMsg = nil;
    if (payloadData) {
        payloadMsg = [[NSString alloc] initWithBytes:payloadData.bytes length:payloadData.length encoding:NSUTF8StringEncoding];
    }
    
    NSString *msg = [NSString stringWithFormat:@"taskId=%@,messageId:%@,payloadMsg:%@%@",taskId,msgId, payloadMsg,offLine ? @"<离线消息>" : @""];
    NSLog(@"\n>>>[GexinSdk ReceivePayload]:%@\n\n", msg);
}
@end
