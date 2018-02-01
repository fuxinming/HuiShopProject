//
//  WSAdditionalExplainCell.h
//  OMengMerchant
//
//  Created by q on 2016/12/15.
//  Copyright © 2016年 shanjin. All rights reserved.
//


@interface ShowPicsItem : FMBaseItem
@property(nonatomic,strong)NSMutableArray *arrayPics;
@property(nonatomic,assign)float picBtnWH;
@end

@interface ShowPicsCell : FMBaseCell
@property(nonatomic,strong)ShowPicsItem *item;

@end
