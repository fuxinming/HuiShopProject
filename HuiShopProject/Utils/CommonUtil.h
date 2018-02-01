//
//  CommonUtil.h
//  FMBaseOCProject
//
//  Created by q on 2017/10/20.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@interface CommonUtil : NSObject
+ (BOOL)strNilOrEmpty:(NSString *)str;
+ (NSString *)strRelay:(id)str;

+ (CGSize)sizeForFont:(NSString *)str Font:(UIFont *)font CtrlSize:(CGSize)size;
+ (CGFloat)heightForFont:(NSString *)str Font:(UIFont *)font CtrlSize:(CGSize)size;

+(AppDelegate *)appDelegate;



+ (UIImage*) quickBuildimageWithColor:(UIColor*)color;

+ (void)checkTextField:(UITextField *)textField maxLen:(int)max;
+ (NSMutableAttributedString *)mutableStringAppendString:(id)str;
+ (BOOL)isContainStr:(NSString *)str inArr:(NSArray *)arr;

+ (id) processDictionaryIsNSNull:(id)obj;


@end
