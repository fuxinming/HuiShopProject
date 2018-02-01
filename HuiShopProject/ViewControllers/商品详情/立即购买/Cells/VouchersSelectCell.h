//
//  TagListCell.h
//  SunnyCar
//
//  Created by Fxm on 2017/1/12.
//  Copyright © 2017年 Fxm. All rights reserved.
//

@interface VouchersSelectItem : FMBaseItem
@property (nonatomic,assign)BOOL isdeSelect;
@property (nonatomic,assign)double price;
@property (copy, readwrite, nonatomic) void (^btnSelect)(id item);
@end

@interface VouchersSelectCell : FMBaseCell
@property (nonatomic,strong) VouchersSelectItem *item;
@end
