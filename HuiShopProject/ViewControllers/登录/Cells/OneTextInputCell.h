//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface OneTextInputItem : FMBaseItem
@property (nonatomic,copy) NSString *value;
@property (nonatomic,copy) NSString *placeholder;
@property (nonatomic,copy) NSString *rightImage;
@property (nonatomic,copy) NSString *rightImage1;
@property (nonatomic,assign) NSInteger maxLenth;
@property (nonatomic,assign) BOOL isSecret;
@property(nonatomic) UIKeyboardType keyboardType;
@property (nonatomic,copy) void (^textValueChanged)(NSString *str);
@end

@interface OneTextInputCell : FMBaseCell
@property (strong, readwrite, nonatomic) OneTextInputItem *item;
@property (nonatomic,strong) UITextField *textField;
@end
