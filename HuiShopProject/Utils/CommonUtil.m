//
//  CommonUtil.m
//  FMBaseOCProject
//
//  Created by q on 2017/10/20.
//  Copyright © 2017年 付新明. All rights reserved.
//

#import "CommonUtil.h"
#import "WSValidateUtil.h"
@implementation CommonUtil
+ (BOOL)strNilOrEmpty:(NSString *)str {
    return str == nil
    || str == NULL
    || [str isKindOfClass:[NSNull class]]
    ||([str respondsToSelector:@selector(length)]
       && [(NSData *)str length] == 0)
    || ([str respondsToSelector:@selector(count)]
        && [(NSArray *)self count] == 0);
}

+ (NSString *)strRelay:(id)str
{
    if([CommonUtil strNilOrEmpty:str]){
        return @"";
    }
    else if([str isKindOfClass:[NSString class]]){
        return str;
    }
    else if([str isKindOfClass:[NSNumber class]]){
        NSString *sss = [str stringValue];
        if ([sss containsString:@"."]) {
            //小数
            return [NSString stringWithFormat:@"%0.2f",[str doubleValue]];
        }
        return sss;
    }
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}
+ (CGSize)sizeForFont:(NSString *)str Font:(UIFont *)font CtrlSize:(CGSize)size
{
    CGSize sz = CGSizeZero;
    NSDictionary *attributes = @{NSFontAttributeName:font,};
    sz = [str boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine |
          NSStringDrawingUsesLineFragmentOrigin |
          NSStringDrawingUsesFontLeading
                        attributes:attributes
                           context:nil].size;
    return sz;
}

+ (CGFloat)heightForFont:(NSString *)str Font:(UIFont *)font CtrlSize:(CGSize)size
{
    CGSize sz = CGSizeZero;
    NSDictionary *attributes = @{NSFontAttributeName:font};
    sz = [str boundingRectWithSize:size options:NSStringDrawingTruncatesLastVisibleLine |
          NSStringDrawingUsesLineFragmentOrigin |
          NSStringDrawingUsesFontLeading
                        attributes:attributes
                           context:nil].size;
    return sz.height;
}

+(AppDelegate *)appDelegate {
    return ((AppDelegate *)[UIApplication sharedApplication].delegate);
}



+ (UIImage*) quickBuildimageWithColor:(UIColor*)color {
    
    CGSize imageSize = CGSizeMake(1, 1);
    UIGraphicsBeginImageContextWithOptions(imageSize,0, [UIScreen mainScreen].scale);
    [color set];
    UIRectFill(CGRectMake(0,0, imageSize.width, imageSize.height));
    UIImage *img =UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}


+ (void)checkTextField:(UITextField *)textField maxLen:(NSInteger)max {
    int kMaxLength = INT_MAX;
    if (max>0) {
        kMaxLength = max;
    }
    NSString *toBeString = textField.text;
    if ([WSValidateUtil stringContainsEmoji:textField.text]) {
        toBeString = [WSValidateUtil disable_emoji:toBeString];
        textField.text = toBeString;
        return;
    }
    
    NSString *lang = [textField.textInputMode primaryLanguage];
    if ([lang isEqualToString:@"zh-Hans"])// 简体中文输入
    {
        //获取高亮部分
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position)
        {
            if (toBeString.length > kMaxLength)
            {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
        }
    }
    // 中文输入法以外的直接对其统计限制即可，不考虑其他语种情况
    else
    {
        if (toBeString.length > kMaxLength)
        {
            NSRange rangeIndex = [toBeString rangeOfComposedCharacterSequenceAtIndex:kMaxLength];
            if (rangeIndex.length == 1)
            {
                textField.text = [toBeString substringToIndex:kMaxLength];
            }
            else
            {
                NSRange rangeRange = [toBeString rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, kMaxLength)];
                textField.text = [toBeString substringWithRange:rangeRange];
            }
        }
    }
}
+ (NSMutableAttributedString *)mutableStringAppendString:(id)str{
    NSMutableAttributedString *mutableString = [NSMutableAttributedString new];
    mutableString.clear();
    mutableString.append(str);
    return mutableString;
}

+ (BOOL)isContainStr:(NSString *)str inArr:(NSArray *)arr{
    BOOL isContain = NO;
    
    for (NSString *tStr in arr) {
        if ([str isEqualToString:tStr]) {
            isContain = YES;
            break;
        }
    }
    
    return isContain;
}

+ (id) processDictionaryIsNSNull:(id)obj{
	const NSString *blank = @"";
	if ([obj isKindOfClass:[NSDictionary class]]) {
		NSMutableDictionary *dt = [(NSMutableDictionary*)obj mutableCopy];
		for(NSString *key in [dt allKeys]) {
			id object = [dt objectForKey:key];
			if([object isKindOfClass:[NSNull class]]) {
				[dt setObject:blank
					   forKey:key];
			}
			else if ([object isKindOfClass:[NSString class]]){
				NSString *strobj = (NSString*)object;
				if ([strobj isEqualToString:@"<null>"]) {
					[dt setObject:blank
						   forKey:key];
				}
			}
			else if ([object isKindOfClass:[NSNumber class]]){
				NSString *strobj = (NSString*)object;
				[dt setObject:[NSString stringWithFormat:@"%@",strobj]
					   forKey:key];
			}
			else if ([object isKindOfClass:[NSArray class]]){
				NSArray *da = (NSArray*)object;
				da = [self processDictionaryIsNSNull:da];
				[dt setObject:da
					   forKey:key];
			}
			else if ([object isKindOfClass:[NSDictionary class]]){
				NSDictionary *ddc = (NSDictionary*)object;
				ddc = [self processDictionaryIsNSNull:ddc];
				[dt setObject:ddc forKey:key];
			}
		}
		return [dt copy];
	}
	else if ([obj isKindOfClass:[NSArray class]]){
		NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
		for (int i=0; i<[da count]; i++) {
			NSDictionary *dc = [obj objectAtIndex:i];
			dc = [self processDictionaryIsNSNull:dc];
			[da replaceObjectAtIndex:i withObject:dc];
		}
		return [da copy];
	}
	else{
		return obj;
	}
}


@end
