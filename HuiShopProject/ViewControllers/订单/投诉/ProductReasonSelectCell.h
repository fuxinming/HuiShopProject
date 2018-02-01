//
//  TagListCell.h
//  SunnyCar
//
//  Created by Fxm on 2017/1/12.
//  Copyright © 2017年 Fxm. All rights reserved.
//

@interface ProductReasonSelectItem : FMBaseItem
@property (nonatomic,assign)BOOL isdeSelect;
@property (nonatomic,copy) NSString *t1;
@property (copy, readwrite, nonatomic) void (^btnSelect)(id item);
@end

@interface ProductReasonSelectCell : FMBaseCell
@property (nonatomic,strong) ProductReasonSelectItem *item;
@end
