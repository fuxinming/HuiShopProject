//
//  LoginInfo.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/21.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "LoginInfo.h"
#import "FMFile.h"
@implementation LoginInfo
+ (LoginInfo *)loginInfoWithDict:(NSDictionary *)dInfo{
    LoginInfo *loginInfo = [[LoginInfo alloc] init];
    loginInfo.userId = [CommonUtil strRelay:dInfo[@"id"]];
    loginInfo.birthday = [CommonUtil strRelay:dInfo[@"birthday"]];
    loginInfo.email = [CommonUtil strRelay:dInfo[@"email"]];
    loginInfo.mobile = [CommonUtil strRelay:dInfo[@"mobile"]];
    loginInfo.name = [CommonUtil strRelay:dInfo[@"name"]];
    loginInfo.nickName = [CommonUtil strRelay:dInfo[@"nickName"]];
    loginInfo.picUrl = [CommonUtil strRelay:dInfo[@"picUrl"]];
    loginInfo.realName = [CommonUtil strRelay:dInfo[@"realName"]];
    loginInfo.sex = [CommonUtil strRelay:dInfo[@"sex"]];
    return loginInfo;
}

+ (NSString *)getUserInfoFile {
    NSArray * paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString * documentsDirectory = [paths objectAtIndex:0];
    NSString * path = [documentsDirectory stringByAppendingPathComponent:@"user.txt"];
    return path;
}

+ (void)writeUserInfo:(NSDictionary *)dic {
    NSString *fileName = [LoginInfo getUserInfoFile];
    if ([FMFile fileExistAtPath:fileName]) {
        [FMFile fileDel:fileName];
    }
    dic = [CommonUtil processDictionaryIsNSNull:dic];
    NSString *str = [NSString jsonStringWithObject:dic];
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    [data writeToFile:fileName atomically:YES];
}

+ (void)removeUserInfo {
    NSString *fileName = [LoginInfo getUserInfoFile];
    if ([FMFile fileExistAtPath:fileName]) {
        [FMFile fileDel:fileName];
    }
}

+ (NSDictionary *)getUserDic {
    NSString *fileName = [LoginInfo getUserInfoFile];
    NSString *version = [AppUtil getAppVersion];
    if ([FMFile fileExistAtPath:fileName]) {
        NSData *data = [NSData dataWithContentsOfFile:fileName];
        if (data) {
            NSDictionary *d = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
            NSMutableDictionary *dic = nil;
            if (d!=nil) {
                dic = [[NSMutableDictionary alloc] init];
                [dic addEntriesFromDictionary:d];
                if (![[CommonUtil strRelay:dic[@"appVersion"]] isEqualToString:version]) {
                    return nil;
                }
            }
            return dic;
        }
    }
    return nil;
}

+ (LoginInfo *)getUserInfo {
    NSDictionary *dic = [LoginInfo getUserDic];
    if (dic==nil) {
        return nil;
    }
    LoginInfo *loginInfo = [LoginInfo loginInfoWithDict:dic];
    return loginInfo;
}

+ (void)clearLoginInfo {
    [LoginInfo removeUserInfo];
    AppDelegate *de = (AppDelegate *)[CommonUtil appDelegate];
    de.loginInfo = nil;
}

+ (BOOL)isLogin {
    AppDelegate *de = (AppDelegate *)[CommonUtil appDelegate];
    if (de.loginInfo==nil||
        [CommonUtil strNilOrEmpty:de.loginInfo.mobile]) {
        return NO;
    }
    return YES;
}
@end
