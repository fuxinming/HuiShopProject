//
//  DateUtil.h
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/10.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef enum : NSUInteger {
    CXDateTypeYear = 1,
    CXDateTypeMounth,
    CXDateTypeDay,
    CXDateTypeWeek,
} CXDateType;
@interface DateUtil : NSObject
+(NSInteger)getDataFromDate:(NSDate *)date type:(CXDateType)type;
+(NSDate *)dateWithYear:(NSInteger )year mouth:(NSInteger )mouth day:(NSInteger )day;

+(NSString *)dateStringWithYear:(NSInteger )year mouth:(NSInteger )mouth day:(NSInteger )day;
+(NSDate *)stringToDate:(NSString *)dateStr;
+(NSString *)dateToString:(NSDate *)date;
+(NSString *)dateToMDString:(NSDate *)date;
+(NSInteger )weekdayStringFromDate:(NSDate*)inputDate;

+ (NSString*)weekStringFromDate:(NSDate*)inputDate;
+ (NSInteger)totaldaysInThisMonth:(NSDate *)date;

+ (NSString*)MHDateWithTimeIntervalString:(NSString *)timeString;//月日时间
+ (NSString*)timeStrWithTimeIntervalString:(NSString *)timeString;//时间 18：00

+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString;
+ (NSDate *)dateWithTimeIntervalString:(NSString *)timeString;
+(int)compareDate:(NSDate *)date01 withDate:(NSDate *)date02;

+(NSString *)YMDWithTimeIntervalString:(NSString *)timeString;
@end
