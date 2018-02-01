//
//  TagListCell.h
//  SunnyCar
//
//  Created by Fxm on 2017/1/12.
//  Copyright © 2017年 Fxm. All rights reserved.
//

@interface CartProductItem : FMBaseItem
@property (nonatomic,assign)BOOL isBtnSelect;
@property (nonatomic,assign)BOOL isEdict;
@property (nonatomic,assign)int qty;
@end

@interface CartProductCell : FMBaseCell
@property (nonatomic,strong) CartProductItem *item;
@end
