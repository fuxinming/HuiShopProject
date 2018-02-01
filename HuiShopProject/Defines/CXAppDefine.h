//
//  CXAppDefine.h
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/2.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#ifndef CXAppDefine_h
#define CXAppDefine_h

#define List_DefaultPage_First 1
//#define FMFontPF(_size) [UIFont fontWithName:@"PingFangSC-Medium" size:_size]
#define FMFontPF(_size) [UIFont systemFontOfSize:_size]

#define Font_Size_36 FMFontPF(36)
#define Font_Size_24 FMFontPF(24)
#define Font_Size_18 FMFontPF(18)
#define Font_Size_16 FMFontPF(16)
#define Font_Size_15 FMFontPF(15)
#define Font_Size_14 FMFontPF(14)
#define Font_Size_13 FMFontPF(13)
#define Font_Size_12 FMFontPF(12)
#define Font_Size_11 FMFontPF(11)
#define Font_Size_10 FMFontPF(10)

#define BtnH10 10
#define BtnH12 12
#define BtnH15 15
#define BtnH20 20

#define MyCollectionProduct @"MyCollectionProduct"
#define MyLookedProduct @"MyLookedProduct"
//获得主 window
#define Window [[UIApplication sharedApplication].delegate window]

#define Toast(str)  CSToastStyle *style = [[CSToastStyle alloc] initWithDefaultStyle]; \
[Window  makeToast:str duration:0.8 position:CSToastPositionCenter style:style];\
Window.userInteractionEnabled = NO; \
dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{\
Window.userInteractionEnabled = YES;\
});\

#define HitorySearch @"HitorySearch"
#define LoginPhone @"LoginPhone"
#define LoginPwd @"LoginPwd"

#define BindPhone @"BindPhone"
#define RefreshTable @"RefreshTable"//通知刷新列表
#define IsLogin ISEmptyStr(UserDefaultObjectForKey(LoginPhone))?NO:YES
#endif /* CXAppDefine_h */
