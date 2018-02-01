//
//  CommonDefine.h
//  FMBaseOCProject
//
//  Created by q on 2017/10/20.
//  Copyright © 2017年 付新明. All rights reserved.
//

#ifndef CommonDefine_h
#define CommonDefine_h

#ifdef DEBUG
#define LLog(...) NSLog(@"%s 第%d行 \n %@\n\n",__func__,__LINE__,[NSString stringWithFormat:__VA_ARGS__])
#else
#define LLog(...)
#endif


#define WS(weakSelf)  __weak __typeof(&*self)weakSelf = self;


#define UUID [[[UIDevice currentDevice] identifierForVendor] UUIDString]

#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
#define TabBarH        (SCREEN_HEIGHT == 812.0 ? 76.0f:56.0f)
#define StatusBarH     (SCREEN_HEIGHT == 812.0 ? 44:20)
#define NavigationBarH (SCREEN_HEIGHT == 812.0 ? 88:64)

#define View_Border_Radius(View, Radius, Width, Color)\
\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]

#define View_Shadow(View, Opacity, Color, Radius,Offset)\
\
[View.layer setShadowOpacity:(Opacity)];\
[View.layer setShadowColor:[Color CGColor]];\
[View.layer setShadowRadius:(Radius)];\
[View.layer setShadowOffset:Offset]


#define FMFontSys(_size) [UIFont systemFontOfSize:_size]
#define FMFontBoldSys(_size) [UIFont boldSystemFontOfSize:_size]

#define ISEmptyStr(var) [CommonUtil strNilOrEmpty:var]
#define ISNULL(_VAR) (_VAR == nil || [_VAR isKindOfClass:[NSNull class]])
#define StrRelay(_VAR) [CommonUtil strRelay:_VAR]
#define IntRelay(_VAR) [[CommonUtil strRelay:_VAR] intValue]
#define IntegerRelay(_VAR) [[CommonUtil strRelay:_VAR] integerValue]
#define DoubleRelay(_VAR) [[CommonUtil strRelay:_VAR] doubleValue]

#define ReloadItem(item) [item reloadRowWithAnimation:UITableViewRowAnimationNone]

#define RootNavPush(vc) [(UINavigationController *)Window.rootViewController pushViewController:vc animated:YES]

#define RootNavPop(_ANIMATE) [(UINavigationController *)Window.rootViewController popViewControllerAnimated:_ANIMATE]

#define ShowAlert(message)    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];[alert show];

#define FMBlock(block, ...) if (block) { block(__VA_ARGS__); };
//获取图片资源
#define GetImage(imageName) [UIImage imageNamed:imageName]
//读取本地图片
#define Load_Image(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//获取temp
#define Path_Temp NSTemporaryDirectory()
//获取沙盒 Document
#define Path_Document [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define Path_Cache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]

//GCD - 一次性执行
#define DISPATCH_ONCE_BLOCK(onceBlock) static dispatch_once_t onceToken; dispatch_once(&onceToken, onceBlock);
//GCD - 在Main线程上运行
#define DISPATCH_MAIN_THREAD(mainQueueBlock) dispatch_async(dispatch_get_main_queue(), mainQueueBlock);
//GCD - 开启异步线程
#define DISPATCH_GLOBAL_QUEUE_DEFAULT(globalQueueBlock) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), globalQueueBlocl);


//存储对象

#define UserDefaultSetObjectForKey(__VALUE__,__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] setObject:__VALUE__ forKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}
//获得存储的对象
#define UserDefaultObjectForKey(__KEY__)  [[NSUserDefaults standardUserDefaults] objectForKey:__KEY__]

//     删除对象
#define UserDefaultRemoveObjectForKey(__KEY__) \
{\
[[NSUserDefaults standardUserDefaults] removeObjectForKey:__KEY__];\
[[NSUserDefaults standardUserDefaults] synchronize];\
}

//判断是否 Retina屏、设备是否iPhone 5、是否是iPad
#define Is_Retina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 判断是否为iPhone */
#define Is_iPhone (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

/** 判断是否是iPad */
#define Is_iPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)

/** 判断是否为iPod */
#define Is_iPod ([[[UIDevice currentDevice] model] isEqualToString:@"iPod touch"])

/** 设备是否为iPhone 4/4S 分辨率320x480，像素640x960，@2x */
#define iPhone4 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 5C/5/5S 分辨率320x568，像素640x1136，@2x */
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 分辨率375x667，像素750x1334，@2x */
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)

/** 设备是否为iPhone 6 Plus 分辨率414x736，像素1242x2208，@3x */
#define iPhone6P ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#endif /* CommonDefine_h */
