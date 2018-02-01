//
//  TagListCell.h
//  SunnyCar
//
//  Created by Fxm on 2017/1/12.
//  Copyright © 2017年 Fxm. All rights reserved.
//

@interface SearchTagListItem : FMBaseItem

@property (nonatomic,copy) NSArray *tagListArray;
@property (nonatomic,copy) void (^tagBtnClick)(NSString *str);
@end

@interface SearchTagListCell : FMBaseCell
@property (nonatomic,strong) SearchTagListItem *item;
@end
