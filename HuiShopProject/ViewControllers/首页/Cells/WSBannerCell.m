//
//  WSMsgCell.m
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//

#import "WSBannerCell.h"
#import "WJScrollView.h"

@implementation WSBannerItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        float imgH = (625*SCREEN_WIDTH)/1000;
        self.cellHeight = imgH;
    }
    return self;
}
@end

@interface WSBannerCell ()
{

}
@end
@implementation WSBannerCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated{}
- (void)layoutSubviews
{
    [super layoutSubviews];
}

- (void)cellWillAppear
{
    [super cellWillAppear];
    WS(bself);
    [self.contentView removeAllSubviews];
    NSMutableArray *imgArr = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i< self.item.bannerArray.count; i++) {
        NSDictionary *dict = self.item.bannerArray[i];
        [imgArr addObject:dict[@"picUrl"]];
    }
    
    
    if (self.item.bannerArray && self.item.bannerArray.count>0) {
        WJScrollView *scroll = [[WJScrollView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, self.item.cellHeight) withImages:imgArr withIsRunloop:NO withBlock:^(NSInteger index) {
            NSDictionary *dic = bself.item.items[index];

        }];
        scroll.color_currentPageControl = COLOR_RED_;
        [self.contentView addSubview:scroll];
    }
}


@end
