//
//  TagListCell.h
//  SunnyCar
//
//  Created by Fxm on 2017/1/12.
//  Copyright © 2017年 Fxm. All rights reserved.
//

@interface PingTagListItem : FMBaseItem
@property (nonatomic,strong) NSMutableArray *evalListArray;
@property (nonatomic,copy) NSArray *tagListArray;

@end

@interface PingTagListCell : FMBaseCell
@property (nonatomic,strong) PingTagListItem *item;
@end
