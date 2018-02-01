//
//  WSAdditionalExplainCell.h
//  OMengMerchant
//
//  Created by q on 2016/12/15.
//  Copyright © 2016年 shanjin. All rights reserved.
//


@interface SelectPicItem : FMBaseItem
@property(nonatomic,strong)NSMutableArray *arrayPics;
@property(nonatomic,assign)float picBtnWH;
@end

@interface SelectPicCell : FMBaseCell
@property(nonatomic,strong)SelectPicItem *item;

- (void)addPic:(UIButton *)btn;
@end
