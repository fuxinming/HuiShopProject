//
//  FMFormTextCell.h
//  OMengMerchant
//
//  Created by fuxinming on 14-5-9.
//  Copyright (c) 2014年 fuxinming. All rights reserved.
//

#import "RETableViewCell.h"
#import "RETableViewItem.h"

@interface AllEvalHeadItem : FMBaseItem
@property (nonatomic,assign)  int defIndex;
@property (nonatomic,copy) NSArray*levelList;
@property (nonatomic,copy)void (^buttonClick)(NSInteger tag,id);
@end

@interface AllEvalHeadCell : FMBaseCell
@property (strong, readwrite, nonatomic) AllEvalHeadItem *item;

@end
