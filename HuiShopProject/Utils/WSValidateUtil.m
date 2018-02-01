//
//  WSValidateUtil.m
//  CheBaiTong
//
//  Created by shanjin on 15/7/6.
//  Copyright (c) 2015年 shanjin. All rights reserved.
//

#import "WSValidateUtil.h"

@implementation WSValidateUtil

//邮箱
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

//车牌号验证
+ (BOOL) validateCarNo:(NSString *)carNo
{
    NSString *carRegex = @"^[\u4e00-\u9fa5]{1}[a-zA-Z]{1}[a-zA-Z_0-9]{4}[a-zA-Z_0-9_\u4e00-\u9fa5]$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:carNo];
}


//车型
+ (BOOL) validateCarType:(NSString *)CarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:CarType];
}


//用户名
+ (BOOL) validateUserName:(NSString *)name
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}


//密码
+ (BOOL) validatePassword:(NSString *)passWord
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}


//昵称
+ (BOOL) isChinese:(NSString *)nickname
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:nickname];
}


+(NSString *)formatPhoneNumberWithString:(NSString *)string{
    NSString *strResult =@"";
    if (![CommonUtil strNilOrEmpty:string]) {
        //去掉 +86
        string =[string stringByReplacingOccurrencesOfString:@"+86" withString:@""];
        for (int i =0; i < string.length ; i++) {
            NSString *tmpStr =[string substringWithRange:NSMakeRange(i, 1)];
            NSString *allowCharacters = @"0123456789";
            NSCharacterSet *setOfnonNumberSet = [NSCharacterSet characterSetWithCharactersInString:allowCharacters];
            NSString *strItem =[tmpStr stringByTrimmingCharactersInSet:setOfnonNumberSet];
            if ([strItem stringByTrimmingCharactersInSet:setOfnonNumberSet].length ==0) {
                //是数字
                strResult =  [NSString stringWithFormat:@"%@%@",strResult,tmpStr];
            }
        }
    }
    return strResult;
}
/*
 *  身份证验证
 */
+ (BOOL) checkUserIdCard: (NSString *) idCard
{
    NSString *pattern = @"(^[0-9]{15}$)|([0-9]{17}([0-9]|X|x)$)";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:idCard];
    return isMatch;
}

/*
 *  银行卡位数校验
 */
+ (BOOL) isValidateCardNumber:(NSString *)certificate
{
    NSString *certificateRegex = @"^([0-9]{15,25})$";
    NSPredicate *certificateTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",certificateRegex];
    return [certificateTest evaluateWithObject:certificate];
}
//纯数字校验
+ (BOOL) isValidateNumber:(NSString *)certificate
{
    NSString *certificateRegex = @"^[0-9]$";
    NSPredicate *certificateTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",certificateRegex];
    return [certificateTest evaluateWithObject:certificate];
}

+ (BOOL)checkURL:(NSString *) url
{
    NSString *pattern = @"^[0-9A-Za-z]{1,50}";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:url];
    return isMatch;
    
}

/*
 *  @brief  是否是常规字符串，仅包含字母数字和汉子
 */
+ (BOOL)checkStringIsCommonString:(NSString *) str
{
    NSString *pattern = @"^[a-zA-Z0-9\u4e00-\u9fa5,:.，：。 ·]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}


/*
 *  手机号或者固话验证
 */
+ (BOOL) isValidateMobile:(NSString *)mobile
{
    NSString *phoneRegex = @"^0[0-9]{2,3}[0-9]{5,9}|0?(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])[0-9]{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

/**
 *  手机号码验证
 *
 *  @param mobileNumbel 传入的手机号码
 *
 *  @return 格式正确返回true  错误 返回fals
 */
+ (BOOL) isMobile:(NSString *)mobileNumbel{
    NSString * MOBIL = @"^(13|14|17|18|15)\\d{9}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBIL];
    if (([regextestmobile evaluateWithObject:mobileNumbel])) {
        return YES;
    }
    return NO;
}

/*
 *  网址验证
 */
+ (BOOL) isValidateWebSite:(NSString *)site
{
    NSString *siteRegex = @"^([w-]+.)+[w-]+.([^a-z])(/[w-: ./?%&=]*)?|[a-zA-Z-.][w-]+.([^a-z])(/[w-: ./?%&=]*)?$";
    NSPredicate *siteTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",siteRegex];
    return [siteTest evaluateWithObject:site];
}

+(BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:
     ^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
         
         const unichar hs = [substring characterAtIndex:0];
         // surrogate pair
         if (0xd800 <= hs && hs <= 0xdbff) {
             if (substring.length > 1) {
                 const unichar ls = [substring characterAtIndex:1];
                 const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                 if (0x1d000 <= uc && uc <= 0x1f77f) {
                     returnValue = YES;
                 }
             }
         } else if (substring.length > 1) {
             const unichar ls = [substring characterAtIndex:1];
             if (ls == 0x20e3) {
                 returnValue = YES;
             }
             
         } else {
             // non surrogate
             if (0x2100 <= hs && hs <= 0x27ff) {
                 returnValue = YES;
             } else if (0x2B05 <= hs && hs <= 0x2b07) {
                 returnValue = YES;
             } else if (0x2934 <= hs && hs <= 0x2935) {
                 returnValue = YES;
             } else if (0x3297 <= hs && hs <= 0x3299) {
                 returnValue = YES;
             } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                 returnValue = YES;
             }
         }
     }];
    
    return returnValue;
}

+ (NSString *)disable_emoji:(NSString *)text
{
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text
                                                               options:0
                                                                 range:NSMakeRange(0, [text length])
                                                          withTemplate:@""];
    return modifiedString;
}

+ (BOOL)checkStringIsNickString:(NSString *) str
{
    NSString *pattern = @"^[a-zA-Z0-9\u4e00-\u9fa5]+$";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", pattern];
    BOOL isMatch = [pred evaluateWithObject:str];
    return isMatch;
}
@end
