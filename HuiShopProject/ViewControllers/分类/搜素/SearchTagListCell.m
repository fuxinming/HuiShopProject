//
//  WSMsgCell.m
//  SunnyCar
//
//  Created by ZhangQun on 2017/1/12.
//  Copyright © 2017年 shanjin. All rights reserved.
//

#import "SearchTagListCell.h"


@implementation SearchTagListItem
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.cellHeight = 68;
    }
    return self;
}
@end

@interface SearchTagListCell ()
{
    CGRect previousFrame;
    int totalHeight ;
    NSMutableArray*_tagArr;
}
@end
@implementation SearchTagListCell
@dynamic item;
- (void)cellDidLoad
{
    [super cellDidLoad];
    self.contentView.backgroundColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor clearColor];
    totalHeight=0;
    _tagArr=[[NSMutableArray alloc]init];
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
    
    previousFrame = CGRectZero;
    [_tagArr addObjectsFromArray:self.item.tagListArray];
    [self.item.tagListArray enumerateObjectsUsingBlock:^(NSString*str, NSUInteger idx, BOOL *stop) {
        UIButton*tagBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        tagBtn.frame=CGRectZero;
        tagBtn.backgroundColor=COLOR_ddd;
        tagBtn.userInteractionEnabled=YES;
        [tagBtn setTitleColor: COLOR_333 forState:UIControlStateNormal];
//        [tagBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        tagBtn.titleLabel.font=[UIFont systemFontOfSize:14];
        [tagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        [tagBtn setTitle:[NSString stringWithFormat:@"%@",str] forState:UIControlStateNormal];
        View_Border_Radius(tagBtn,3 , 0, Color_Clear);
        tagBtn.tag=100+idx;
        
        NSDictionary *attrs = @{NSFontAttributeName : [UIFont systemFontOfSize:14]};
        CGSize Size_str=[[NSString stringWithFormat:@"%@",str] sizeWithAttributes:attrs];
        Size_str.width += 4;
        Size_str.height += 4;
        
        CGRect newRect = CGRectZero;
        
        if (previousFrame.origin.x + previousFrame.size.width + Size_str.width + 8 > self.bounds.size.width) {
            
            newRect.origin = CGPointMake(18, previousFrame.origin.y + Size_str.height + 10);
            totalHeight +=Size_str.height + 10;
        }
        else {
            newRect.origin = CGPointMake(previousFrame.origin.x + previousFrame.size.width + 18, previousFrame.origin.y);
            
        }
        newRect.size = Size_str;
        [tagBtn setFrame:newRect];
        previousFrame=tagBtn.frame;
        [self setHight:self andHight:totalHeight+Size_str.height + 10];
        [self.contentView addSubview:tagBtn];
    }];
    
}

- (void)setHight:(UIView *)view andHight:(CGFloat)hight
{
    self.item.cellHeight = hight;
}

-(void)tagBtnClick:(UIButton *)btn{
    if (self.item.tagBtnClick) {
        self.item.tagBtnClick(btn.titleLabel.text);
    }
}
@end
