//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface PhoneCodeInputItem : FMBaseItem
@property (nonatomic,copy) NSString *phone;
@property (nonatomic,copy) NSString *value;
@property (nonatomic,copy) NSString *placeholder;
@property (nonatomic,assign) NSInteger maxLenth;
@property(nonatomic) UIKeyboardType keyboardType;
@property (nonatomic,copy) dispatch_block_t getPhoneCode;
@end

@interface PhoneCodeInputCell : FMBaseCell
@property (strong, readwrite, nonatomic) PhoneCodeInputItem *item;
@property (nonatomic,strong) UITextField *textField;
@property (nonatomic,strong) NSTimer *time;
@property (nonatomic,assign) int t;
@end
