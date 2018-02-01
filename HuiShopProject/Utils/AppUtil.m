//
//  AppUtil.m
//  ChiXinTiYuProject
//
//  Created by cx-fu on 2017/11/8.
//  Copyright © 2017年 cx-fu. All rights reserved.
//

#import "AppUtil.h"

@implementation AppUtil
+ (NSMutableDictionary *)getPublicParam {
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    return dic;
}

+ (NSString *)getAppVersion {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

+(void)loginWith:(NSString *)phone andPass:(NSString *)pass  complete:(dispatch_block_t)successBlock andFail:(failed)failBlock{
    NSMutableDictionary *param = [AppUtil getPublicParam];
    [param setObject:phone forKey:@"user_name"];
    [param setObject:pass forKey:@"password"];
    [NSObject postDataWithHost:Server_Host Path:Api_BuyerLogin Param:param isCache:NO success:^(id json) {
        if (IntRelay(json[@"state"]) == 1) {
            UserDefaultSetObjectForKey(StrRelay(phone), LoginPhone);
            UserDefaultSetObjectForKey(StrRelay(pass), LoginPwd);
            FMBlock(successBlock);
            [[CommonUtil appDelegate] bindClientId];
			[[CommonUtil appDelegate] getUserInfo];
        }else{
			Toast(json[@"msg"]);
            if (failBlock) {
                failBlock(json);
            }
        }
        
    } fail:^(id json) {
        Toast(json[@"网络错误"]);
        if (failBlock) {
            failBlock(json);
        }
    }];
}

+ (PXAlertView *)showAlert:(NSString *)title msg:(NSString *)msg handle:(void(^)(BOOL cancelled, NSInteger buttonIndex))handle
{
    NSString *t = title;
    if (ISEmptyStr(t)) {
        t = @"提示";
    }
    PXAlertView *alert = [PXAlertView showAlertWithTitle:t message:msg cancelTitle:@"取消" otherTitle:@"确认" completion:handle];
    [alert setOtherButtonTextColor:[UIColor redColor]];
    [alert useDefaultIOS7Style];
    return alert;
}


+(BOOL)isCollection:(NSString *)productId{
	BOOL isC = NO;
	NSArray *arr = UserDefaultObjectForKey(MyCollectionProduct);
	for (int i = 0; i < arr.count; i++) {
		NSDictionary *dict = [arr objectAtIndex:i];
		if ([StrRelay(dict[@"id"]) isEqualToString:productId]) {
			isC = YES;
			break;
		}
	}
	
	return isC;
}

+(void)AddCollection:(NSDictionary *)productInfo{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSMutableArray *mutableArrayCopy = [[prefs objectForKey:MyCollectionProduct] mutableCopy];

	if (mutableArrayCopy) {
		[mutableArrayCopy addObject:[CommonUtil processDictionaryIsNSNull:productInfo]];
	}else{
		mutableArrayCopy = [NSMutableArray array];
		[mutableArrayCopy addObject:[CommonUtil processDictionaryIsNSNull:productInfo]];
	}
	[prefs setObject:[NSArray arrayWithArray:mutableArrayCopy] forKey:MyCollectionProduct];
	[prefs synchronize];
}

+(void)RemoveCollection:(NSString *)productId{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSMutableArray *mutableArrayCopy = [[prefs objectForKey:MyCollectionProduct] mutableCopy];
	if (mutableArrayCopy) {
		for (int i = 0; i < mutableArrayCopy.count; i++) {
			NSDictionary *dict = [mutableArrayCopy objectAtIndex:i];
			if ([StrRelay(dict[@"id"]) isEqualToString:productId]) {
				[mutableArrayCopy removeObjectAtIndex:i];
				break;
			}
		}
		[prefs setObject:[NSArray arrayWithArray:mutableArrayCopy] forKey:MyCollectionProduct];
		[prefs synchronize];
	}
}


+(void)AddLookRecord:(NSDictionary *)productInfo{
	NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
	NSMutableArray *mutableArrayCopy = [[prefs objectForKey:MyLookedProduct] mutableCopy];
	BOOL isC = NO;
	for (int i = 0; i < mutableArrayCopy.count; i++) {
		NSDictionary *dict = [mutableArrayCopy objectAtIndex:i];
		if ([StrRelay(dict[@"id"]) isEqualToString:StrRelay(productInfo[@"id"])]) {
			isC = YES;
			break;
		}
	}
	if (!isC) {
		if (mutableArrayCopy) {
			[mutableArrayCopy addObject:[CommonUtil processDictionaryIsNSNull:productInfo]];
		}else{
			mutableArrayCopy = [NSMutableArray array];
			[mutableArrayCopy addObject:[CommonUtil processDictionaryIsNSNull:productInfo]];
		}
		[prefs setObject:[NSArray arrayWithArray:mutableArrayCopy] forKey:MyLookedProduct];
		[prefs synchronize];
	}
}

+ (void)openUrl:(NSString *)url{
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

+(NSString *)getOrderStatus:(int)orderSta{
//	orderState：订单状态(Byte) 1--未付款, 2--已付款, 3--待发货，4--待收货, 5--已完成, 6--已取消, 7--已评价, 8--已删除（未完成） 9--已删除 （已完成）
	NSString *str = @"";
	if (orderSta == 1) {
		str = @"未付款";
	}
	if (orderSta == 2) {
		str = @"已付款";
	}
	if (orderSta == 3) {
		str = @"待发货";
	}
	if (orderSta == 4) {
		str = @"待收货";
	}
	if (orderSta == 5) {
		str = @"已完成";
	}
	if (orderSta == 6) {
		str = @"已取消";
	}
	if (orderSta == 7) {
		str = @"已评价";
	}
	if (orderSta == 8) {
		str = @"未完成";
	}
	if (orderSta == 9) {
		str = @"已删除";
	}
	if (orderSta == 10) {
		str = @"已退款";
	}
	if (orderSta == 11) {
		str = @"已投诉";
	}
	
	return str;
}

+(NSString *)getNameWithStatus:(int)status{
//	1、商品已过期
//	2、商品有破损
//	3、协商一致退款
//	4、服务态度差
//	5、商品漏发、错发
	NSString *staStr = @"";
	
	if (status == 1)  {
		staStr = @"商品已过期";
	}
	
	if (status == 2)  {
		staStr = @"商品有破损";
	}
	
	if (status == 3)  {
		staStr = @"协商一致退款";
	}
	
	if (status == 4)  {
		staStr = @"服务态度差";
	}
	
	if (status == 5)  {
		staStr = @"商品漏发、错发";
	}
	
	return staStr;
}

+ (void)callPhoneNum:(NSString *)phone{
	NSString *ph = [NSString stringWithFormat:@"tel://%@",phone];
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:ph]];
}

+ (void)checkTextView:(UITextView *)textField maxLen:(int)max countLab:(UILabel *)countLab{
	int kMaxLength = INT_MAX;
	if (max>0) {
		kMaxLength = max;
	}
	NSString *toBeString = textField.text;

	
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
				if (countLab) {
					countLab.text = [NSString stringWithFormat:@"%d/%d",(int)(kMaxLength - textField.text.length),kMaxLength];
				}
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
				if (countLab) {
				}
			}
		}
	}
	if (countLab) {
		int x = (int)(kMaxLength - textField.text.length);
		if (x<0) {
			x=0;
		}
		countLab.text = [NSString stringWithFormat:@"%d/%d",x,kMaxLength];
	}
}

@end
