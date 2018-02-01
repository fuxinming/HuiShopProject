//
//  AppUtil.h
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/8.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PXAlertView.h"
#import "PXAlertView+Customization.h"
typedef void (^failed)(id);
@interface AppUtil : NSObject
+ (NSMutableDictionary *)getPublicParam;

+ (NSString *)getAppVersion;

+(void)loginWith:(NSString *)phone andPass:(NSString *)pass complete:(dispatch_block_t)successBlock andFail:(failed)failBlock;

+ (PXAlertView *)showAlert:(NSString *)title msg:(NSString *)msg handle:(void(^)(BOOL cancelled, NSInteger buttonIndex))handle;

+(BOOL)isCollection:(NSString *)productId;
+(void)AddCollection:(NSDictionary *)productInfo;
+(void)RemoveCollection:(NSString *)productId;

+(void)AddLookRecord:(NSDictionary *)productInfo;
+ (void)openUrl:(NSString *)url;

+(NSString *)getOrderStatus:(int)orderSta;
+ (void)callPhoneNum:(NSString *)phone;

+ (void)checkTextView:(UITextView *)textField maxLen:(int)max countLab:(UILabel *)countLab;

+(NSString *)getNameWithStatus:(int)status;
@end
