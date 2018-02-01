//
//  WSFormTextCell.h
//  WiseSeller
//
//  Created by jienliang on 14-5-9.
//  Copyright (c) 2014年 jienliang. All rights reserved.
//



@interface WSFeedBackItem : FMBaseItem
@property (nonatomic,assign) UIViewController *ccc;
@property (nonatomic,copy) NSString *remarks;
@property (nonatomic,copy) NSString *placeH;
@property (nonatomic,assign) int maxLenth;

@end

@interface WSFeedBackCell : FMBaseCell

@property (strong, readwrite, nonatomic) WSFeedBackItem *item;

@end
