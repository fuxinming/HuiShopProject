//
//  TagListCell.h
//  SunnyCar
//
//  Created by Fxm on 2017/1/12.
//  Copyright © 2017年 Fxm. All rights reserved.
//

@interface PingLunTagListItem : FMBaseItem
@property (nonatomic,copy) NSArray *evalListArray;
@property (nonatomic,copy) NSArray *tagListArray;
@property (nonatomic,copy) void (^tagBtnClick)(NSString *str);
@end

@interface PingLunTagListCell : FMBaseCell
@property (nonatomic,strong) PingLunTagListItem *item;
@end
