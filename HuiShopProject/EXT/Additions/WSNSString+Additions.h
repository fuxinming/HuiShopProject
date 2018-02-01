//
//  WSNSString+Additions.h
//  WJLibraryT
//
//  Created by jienliang on 2017/6/6.
//  Copyright © 2017年 jienliang. All rights reserved.
//

#import <Foundation/Foundation.h>
/**
 *	@brief	NSString 拓展.
 */
@interface NSString (WJLibraryT){
    
}
/**
 *	@brief	移除字符串首位空字符串.
 *
 *	@return	字符串实例.
 */
- (NSString *)trim;
/**
 *	@brief	是否是纯数字.
 *
 *	@return	BOOL.
 */
- (BOOL)stringIsNumber;
/**
 *	@brief	是否是字母和数字组成.
 *
 *	@return	BOOL.
 */
- (BOOL)stringIsNumberOrChar;
/**
 *	@brief	是否是身份证号码.
 *
 *	@return	BOOL.
 */
- (BOOL)stringIsPersonCardNo;
/**
 *	@brief	md5字符串.
 *
 *	@return	字符串.
 */
- (NSString *)md5;

+(NSString *) jsonStringWithString:(NSString *) string;
+(NSString *) jsonStringWithArray:(NSArray *)array;
+(NSString *) jsonStringWithDictionary:(NSDictionary *)dictionary;
+(NSString *) jsonStringWithObject:(id) object;
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;

@end
