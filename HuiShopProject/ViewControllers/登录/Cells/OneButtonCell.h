//
//  WSLoginBtnCell.h
//  SunnyCar
//
//  Created by jienliang on 14-5-9.
//  Copyright (c) 2014年 jienliang. All rights reserved.
//

@interface OneButtonItem : FMBaseItem
@property (nonatomic,copy) NSString *titleText;
@property (nonatomic,assign) CGRect btnFrame;
@property (nonatomic,copy) UIColor *bgColor;
@property (copy, readwrite, nonatomic) void (^btnPress)(void);
@end

@interface OneButtonCell : FMBaseCell
@property (strong, readwrite, nonatomic) OneButtonItem *item;

@end
