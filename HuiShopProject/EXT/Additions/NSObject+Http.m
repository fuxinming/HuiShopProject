//
//  WJObject+Http.m
//  WJLibrary
//
//  Created by jienliang on 14-5-4.
//  Copyright (c) 2014年 jienliang. All rights reserved.
//

#import "NSObject+Http.h"
#import "AFNetworking.h"
#import "WSNSString+Additions.h"
#import <objc/runtime.h>

static const void *tagKey = &tagKey;

@implementation NSObject (WJLibraryT)

- (void)setUserinfo:(id)info {
    objc_setAssociatedObject(self, tagKey, info, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)userinfo {
    return objc_getAssociatedObject(self, tagKey);
}

+ (void)getDataWithUrl:(NSString *)url success:(void (^)(id json))success fail:(void (^)(id json))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    [manager.requestSerializer setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [manager GET:url parameters:nil progress:^(NSProgress * downloadProgress) {
    } success:^(NSURLSessionDataTask * task, id  responseObject) {
        FMBlock(success,responseObject);
    } failure:^(NSURLSessionDataTask * task, NSError *   error) {
        FMBlock(fail,nil);
    }];
}

+ (void)getDataWithHost:(NSString *)host Path:(NSString *)path Param:(NSDictionary *)param isCache:(BOOL)isCache success:(void (^)(id json))success fail:(void (^)(id json))fail
{
	AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	
	NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"GET" URLString:[NSString stringWithFormat:@"%@%@",host,path] parameters:param error:nil];
	request.timeoutInterval= 30;
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	//    [request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
	
	AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
	responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
	manager.responseSerializer = responseSerializer;
	
	[[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
		if (!error) {
			FMBlock(success,responseObject);
		} else {
			FMBlock(fail,error.userInfo);
		}
	}] resume];
}

+ (void)postDataWithHost:(NSString *)host Path:(NSString *)path Param:(NSDictionary *)param isCache:(BOOL)isCache success:(void (^)(id json))success fail:(void (^)(id json))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager.requestSerializer setTimeoutInterval:30];
    
    [manager POST:[NSString stringWithFormat:@"%@%@",host,path] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}

+ (void)uploadPic:(NSString *)host path:(NSString *)path param:(NSString *)param files:(NSArray *)files success:(void (^)(id json))success fail:(void (^)(id json))fail
{
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    if (files==nil||[files count]==0) {
        [manager.requestSerializer setTimeoutInterval:30];
    }
    else{
        [manager.requestSerializer setTimeoutInterval:120];
    }

    [manager POST:[NSString stringWithFormat:@"%@%@",host,path] parameters:param constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if (files&&files.count>0) {
            for (int k = 0; k < [files count]; k++) {
                NSDictionary *dic = [files objectAtIndex:k];
                NSString *key = [[dic allKeys] objectAtIndex:0];
                NSData *fileData = [NSData dataWithContentsOfFile:[CommonUtil strRelay:dic[key]]];
                NSString *fileName = [CommonUtil strRelay:dic[key]];
                fileName = [fileName lastPathComponent];
                if (fileData) {
                    [formData appendPartWithFileData:fileData name:key fileName:[CommonUtil strRelay:fileName] mimeType:@"*/*"];
                }
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (fail) {
            fail(error);
        }
    }];
}


+ (void)postDataWithHost:(NSString *)host Path:(NSString *)path Param:(NSString *)param success:(void (^)(id json))success fail:(void (^)(id json))fail
{
	AFURLSessionManager *manager = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
	
	NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] requestWithMethod:@"POST" URLString:[NSString stringWithFormat:@"%@%@",host,path] parameters:nil error:nil];
	request.timeoutInterval= 30;
	[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
	[request setHTTPBody:[param dataUsingEncoding:NSUTF8StringEncoding]];
	
	AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializer];
	responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/html", @"text/json", @"text/javascript", @"text/plain", nil];
	manager.responseSerializer = responseSerializer;
	
	[[manager dataTaskWithRequest:request completionHandler:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
		if (!error) {
			FMBlock(success,responseObject);
		} else {
			FMBlock(fail,error);
		}
	}] resume];
}
@end
