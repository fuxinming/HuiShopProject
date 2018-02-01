//
//  WSLoginBtnCell.h
//  SunnyCar
//
//  Created by jienliang on 14-5-9.
//  Copyright (c) 2014年 jienliang. All rights reserved.
//

@interface FreeViewItem : FMBaseItem
@property (nonatomic,strong)  UIView *freeView;
@property (nonatomic,copy)  UIColor *bgColor;
@end

@interface FreeViewCell : FMBaseCell
@property (strong, readwrite, nonatomic) FreeViewItem *item;

@end
