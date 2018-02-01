//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface ImageTextInputItem : FMBaseItem
@property (nonatomic,copy) NSString *leftImage;
@property (nonatomic,copy) NSString *value;
@property (nonatomic,copy) NSString *placeholder;
@property (nonatomic,assign) NSInteger maxLenth;
@property (nonatomic,assign) BOOL isSecret;
@property (nonatomic,assign) BOOL haveLine;
@property(nonatomic) UIKeyboardType keyboardType;
@property (nonatomic,copy) void (^textChange)(NSString *text);

@end

@interface ImageTextInputCell : FMBaseCell
@property (strong, readwrite, nonatomic) ImageTextInputItem *item;
@property (nonatomic,strong) UITextField *textField;
@end
