//
//  WSValidateUtil.h
//  CheBaiTong
//
//  Created by shanjin on 15/7/6.
//  Copyright (c) 2015年 shanjin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WSValidateUtil : NSObject
//邮箱
+ (BOOL) validateEmail:(NSString *)email;
//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo;
//车型
+ (BOOL) validateCarType:(NSString *)CarType;
//是否全是汉字
+ (BOOL) isChinese:(NSString *)nickname;
//密码
+ (BOOL) validatePassword:(NSString *)passWord;
//用户名
+ (BOOL) validateUserName:(NSString *)name;
//格式化手机号
+(NSString *)formatPhoneNumberWithString:(NSString *)string;
/*
 *  手机号验证
 */
+ (BOOL) isMobile:(NSString *)mobileNumbel;

+ (BOOL) isValidateMobile:(NSString *)mobile;
/*
 *  身份证验证
 */
+ (BOOL) checkUserIdCard:(NSString *) idCard;
/*
 *  银行卡位数校验
 */
+ (BOOL) isValidateCardNumber:(NSString *)certificate;
//检查url是否合法
+ (BOOL)checkURL : (NSString *) url;
/*
 *  @brief  是否是常规字符串，仅包含字母数字和汉子
 */
+ (BOOL)checkStringIsCommonString:(NSString *) str;

/*
 *  @brief  判断字符串是否含有表情字符
 */
+(BOOL)stringContainsEmoji:(NSString *)string;
+ (NSString *)disable_emoji:(NSString *)text;
/*
 *  网址验证
 */
+ (BOOL) isValidateWebSite:(NSString *)site;

//纯数字校验
+ (BOOL) isValidateNumber:(NSString *)certificate;

/*
 *  @brief  是否是常规字符串，仅包含字母和汉子
 */
+ (BOOL)checkStringIsNickString:(NSString *) str;
@end
