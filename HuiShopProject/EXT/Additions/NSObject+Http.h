//
//  NSObject+Http.h
//  WJLib
//
//  Created by jienliang on 16-11-14.
//  Copyright (c) 2014年 jienliang. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface NSObject (WJLibraryT){
}
/**
 *	@brief	存储其他信息.
 */
@property (nonatomic, copy) id userinfo;

+ (void)getDataWithUrl:(NSString *)url success:(void (^)(id json))success fail:(void (^)(id json))fail;
+ (void)getDataWithHost:(NSString *)host Path:(NSString *)path Param:(NSDictionary *)param isCache:(BOOL)isCache success:(void (^)(id json))success fail:(void (^)(id json))fail;
+ (void)postDataWithHost:(NSString *)host Path:(NSString *)path Param:(NSDictionary *)param isCache:(BOOL)isCache success:(void (^)(id json))success fail:(void (^)(id json))fail;
+ (void)uploadPic:(NSString *)host path:(NSString *)path param:(NSString *)param files:(NSArray *)files success:(void (^)(id json))success fail:(void (^)(id json))fail;


+ (void)postDataWithHost:(NSString *)host Path:(NSString *)path Param:(NSString *)param  success:(void (^)(id json))success fail:(void (^)(id json))fail;
@end

