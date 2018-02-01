//
//  WSLoginBtnCell.h
//  SunnyCar
//
//  Created by jienliang on 14-5-9.
//  Copyright (c) 2014年 jienliang. All rights reserved.
//

@interface RecentSearchItem : FMBaseItem
@property (copy, readwrite, nonatomic) void (^btnPress)(void);
@end

@interface RecentSearchCell : FMBaseCell
@property (strong, readwrite, nonatomic) RecentSearchItem *item;

@end
