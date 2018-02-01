//
//  WSLoginBtnCell.h
//  SunnyCar
//
//  Created by jienliang on 14-5-9.
//  Copyright (c) 2014年 jienliang. All rights reserved.
//

@interface TwoButtonItem : FMBaseItem
@property (nonatomic,copy) NSString *title1Text;
@property (nonatomic,copy) NSString *title2Text;

@property (nonatomic,assign) UIControlContentHorizontalAlignment btn1AlignMent;
@property (nonatomic,assign) UIControlContentHorizontalAlignment btn2AlignMent;


@property (nonatomic,assign) CGRect btn1Frame;
@property (nonatomic,assign) CGRect btn2Frame;

@property (nonatomic,copy) UIColor *title1Color;
@property (nonatomic,copy) UIColor *title2Color;
@property (nonatomic,copy) UIFont *title1Font;
@property (nonatomic,copy) UIFont *title2Font;
@property (nonatomic,copy) UIColor *cellBgColor;
@end

@interface TwoButtonCell : FMBaseCell
@property (strong, readwrite, nonatomic) TwoButtonItem *item;

@end
