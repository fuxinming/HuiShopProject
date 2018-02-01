//
//  TagListCell.h
//  SunnyCar
//
//  Created by Fxm on 2017/1/12.
//  Copyright © 2017年 Fxm. All rights reserved.
//

@interface SelectSexItem : FMBaseItem
@property (nonatomic,assign)int selIndex;
@end

@interface SelectSexCell : FMBaseCell
@property (nonatomic,strong) SelectSexItem *item;
@end
