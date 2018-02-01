//
//  TagListCell.h
//  SunnyCar
//
//  Created by Fxm on 2017/1/12.
//  Copyright © 2017年 Fxm. All rights reserved.
//

@interface SelectPingjiaLevelItem : FMBaseItem
@property (nonatomic,copy)NSString *selIndex;
@property (nonatomic,assign)int def;
@property (nonatomic,copy) NSArray *evalListArray;
@end

@interface SelectPingjiaLevelCell : FMBaseCell
@property (nonatomic,strong) SelectPingjiaLevelItem *item;
@end
