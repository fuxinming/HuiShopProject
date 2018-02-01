//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface TitleTextInputItem : FMBaseItem
@property (nonatomic,copy) NSString *value;
@property (nonatomic,copy) NSString *titleText;
@property (nonatomic,copy) NSString *placeholder;
@property (nonatomic,assign) NSInteger maxLenth;
@property(nonatomic) UIKeyboardType keyboardType;
@property (nonatomic,copy) void (^textValueChanged)(NSString *str);
@end

@interface TitleTextInputCell : FMBaseCell
@property (strong, readwrite, nonatomic) TitleTextInputItem *item;
@property (nonatomic,strong) UITextField *textField;
@end
