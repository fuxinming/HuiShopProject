//
//  WSMsgCell.h
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//

@interface WSBannerItem : FMBaseItem
@property (nonatomic,copy) NSArray *bannerArray;
@property (nonatomic,copy) NSArray *items;
@property(nonatomic,copy) void (^bannerDidSelect)(int index);
@end

@interface WSBannerCell : FMBaseCell
@property (nonatomic,strong) WSBannerItem *item;
@end
