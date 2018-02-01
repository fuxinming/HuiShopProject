//
//  LoginInfo.h
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/21.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginInfo : NSObject
@property (nonatomic, copy) NSString *birthday;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *mobile;
@property (nonatomic, copy) NSString *picUrl;//头像
@property (nonatomic, copy) NSString *realName;
@property (nonatomic, copy) NSString *nickName;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *sex;

//登录信息转换成对象
+ (LoginInfo *)loginInfoWithDict:(NSDictionary *)dInfo;
//获取存储在本地的登录文件路径
+ (NSString *)getUserInfoFile;
//写入本地登录文件路径
+ (void)writeUserInfo:(NSDictionary *)dic;
//获取用户信息
+ (LoginInfo *)getUserInfo;
//获取用户信息
+ (NSDictionary *)getUserDic;
//判断是否登录
+ (BOOL)isLogin;

+ (void)removeUserInfo;
+ (void)clearLoginInfo;
@end
