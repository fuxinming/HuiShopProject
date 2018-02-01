//
//  DateUtil.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/10.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "DateUtil.h"

@implementation DateUtil
+(NSInteger)getDataFromDate:(NSDate *)date type:(CXDateType)type
{
    NSDateFormatter*df = [[NSDateFormatter alloc]init];//格式化
    [df setDateFormat:@"yyyyMMdd"];
    NSString *dateStr = [df stringFromDate:date];
    NSInteger year = [[dateStr substringToIndex:4] integerValue];
    NSRange range = {4,2};
    NSInteger mouth = [[dateStr substringWithRange:range] integerValue];
    NSInteger day = [[dateStr substringFromIndex:6] integerValue];
    NSDate *date1 = [self dateWithYear:year mouth:mouth day:day];
    
    
    if (type == CXDateTypeYear) {
        return year;
    }else if (type == CXDateTypeMounth) {
        return mouth;
    }else if (type == CXDateTypeDay) {
        return day;
    }else if (type == CXDateTypeWeek) {
        return [self weekdayStringFromDate:date1];
    }else{
        return 0;
    }
}

//通过年月日获得日期
+(NSDate *)dateWithYear:(NSInteger )year mouth:(NSInteger )mouth day:(NSInteger )day{
    return [self stringToDate:[self dateStringWithYear:year mouth:mouth day:day]];
}
//通过年月日获得日期字符串
+(NSString *)dateStringWithYear:(NSInteger )year mouth:(NSInteger )mouth day:(NSInteger )day
{
    
    return [NSString stringWithFormat:@"%ld%02ld%02ld",year,mouth,day];
}

//时间字符串转时间
+(NSDate *)stringToDate:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"yyyyMMdd"];
    return [formatter dateFromString:dateStr];
}
//时间转时间字符串
+(NSString *)dateToString:(NSDate *)date
{
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    
    return dateStr;
}

//时间转月日
+(NSString *)dateToMDString:(NSDate *)date
{
	NSDateFormatter *dateFormatter=[[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd"];
	
	
	NSString *dateStr = [dateFormatter stringFromDate:date];
	if (dateStr.length > 5) {
		dateStr = [dateStr substringFromIndex:5];
	}
	return dateStr;
}
//通过日期得到当月有多少天
+ (NSInteger)totaldaysInThisMonth:(NSDate *)date{
    
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}
+ (NSInteger )weekdayStringFromDate:(NSDate*)inputDate {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    //如果传进来的日期已经加上了时区差的时间，那么求周的时候就不用再加
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return theComponents.weekday;
    
}

//通过时间戳获得特定字符串
+(NSString *)YMDWithTimeIntervalString:(NSString *)timeString{
	NSDate *dat1 = [DateUtil dateWithTimeIntervalString:timeString];
	NSString *dateStr = [DateUtil dateToString:dat1];
	if (dateStr.length > 3) {
		dateStr = [dateStr substringFromIndex:2];
	}
	
	return dateStr;
}

+ (NSString*)MHDateWithTimeIntervalString:(NSString *)timeString{
    NSString *dateStr = [DateUtil timeWithTimeIntervalString:timeString];
    if (dateStr.length > 5) {
        dateStr = [dateStr substringFromIndex:5];
    }

    return dateStr;
}

+ (NSString*)timeStrWithTimeIntervalString:(NSString *)timeString{
	NSString *dateStr = [DateUtil timeWithTimeIntervalString:timeString];
	if (dateStr.length > 11) {
		dateStr = [dateStr substringFromIndex:11];
	}
	
	return dateStr;
}
+ (NSString *)timeWithTimeIntervalString:(NSString *)timeString
{
    // 格式化时间
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.timeZone = [NSTimeZone timeZoneWithName:@"shanghai"];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    
    // 毫秒值转化为秒
    NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
    NSString* dateString = [formatter stringFromDate:date];
    return dateString;
}

+ (NSDate *)dateWithTimeIntervalString:(NSString *)timeString
{
	// 毫秒值转化为秒
	NSDate* date = [NSDate dateWithTimeIntervalSince1970:[timeString doubleValue]/ 1000.0];
	return date;
}

+ (NSString*)weekStringFromDate:(NSDate*)inputDate {
    NSString *str;
    NSInteger week = [self weekdayStringFromDate:inputDate];
    switch (week) {
        case 1:
            str = @"周日";
            break;
            
        case 2:
            str = @"周一";
            break;
            
        case 3:
            str = @"周二";
            break;
            
        case 4:
            str = @"周三";
            break;
            
        case 5:
            str = @"周四";
            break;
            
        case 6:
            str = @"周五";
            break;
            
        case 7:
            str = @"周六";
            break;
            
        default:
            break;
    }
    return str;
}
//日期比较
+(int)compareDate:(NSDate *)date01 withDate:(NSDate *)date02{
	int ci;
	NSComparisonResult result = [date01 compare:date02];
	switch (result)
	{
			//date02比date01大
		case NSOrderedAscending: ci=1; break;
			//date02比date01小
		case NSOrderedDescending: ci=-1; break;
			//date02=date01
		case NSOrderedSame: ci=0; break;
		default: NSLog(@"erorr dates %@, %@", date02, date01); break;
	}
	return ci;
}
@end
